/* OSSAudio.cc
 *
 * Audio agent -- OSS functions
 *
 * Authors: Michal Svec <msvec@suse.cz>
 *
 * $Id$
 */

#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <linux/soundcard.h>

#include <Y2.h>
#include <scr/SCRAgent.h>
#include <scr/SCRInterpreter.h>

#include "OSSAudio.h"

/**
 * stereo volume structure for oss volume settings
 */
typedef struct {
    unsigned char left;
    unsigned char right;
} stereovolume;

/**
 * convert channel string to oss device number
 */
int ossDevice(string channel) {
    if(channel=="" || channel=="Master") return SOUND_MIXER_VOLUME;
    else if(channel=="PCM") return SOUND_MIXER_PCM;
    else if(channel=="SYNTH") return SOUND_MIXER_SYNTH;
    // else if(channel=="") return SOUND_MIXER_;
    else {
	y2error("bad channel specification: %s", channel.c_str());
	return -1;
    }
}

/**
 * @builtin SCR (`Write (.volume, integer volume)) -> bool
 * @builtin SCR (`Write (.volume.N, integer volume)) -> bool
 *
 * Set a master volume. If called with just volume, /dev/mixer
 * is used, otherwise /dev/mixerN is used as a device.
 *
 * This call returns true on success and false, if it fails.
 *
 * @example SCR (`Write (.volume, 50)) -> true
 * @example SCR (`Write (.volume.1, 50)) -> false
 */
YCPValue ossSetVolume(int value, const string channel, const string card) {

    string mixerfile = "/dev/mixer";
    mixerfile += card;

    int vol = value;
    if(vol<0) {
	y2warning("volume set to 0");
	vol=0;
    }
    if(vol>99) {
	y2warning("volume set to 99");
	vol=99;
    }

    int device = SOUND_MIXER_VOLUME;
    if(channel!="") {
	device = ossDevice(channel);
	if(device == -1)
	    return YCPBoolean(false);
    }

    stereovolume volume;
    volume.left = vol;
    volume.right = vol;

    int mixer_fd = open(mixerfile.c_str(), O_RDWR, 0);
    if(mixer_fd < 0) {
	y2error("%s",string("cannot open mixer: '" + string(mixerfile) +
			    "' : " + string(strerror(errno))).c_str());
	/* FIXME y2error -> YCPError */
	return YCPBoolean(false);
    }

    if(ioctl(mixer_fd,MIXER_WRITE(device),&volume) == -1) {
	y2error(string("ioctl failed : " + string(strerror(errno))).c_str());
	return YCPBoolean(false);
    }

    close(mixer_fd);
    return YCPBoolean (true);
}

/**
 * @builtin SCR (`Read (.volume)) -> integer
 * @builtin SCR (`Read (.volume.N)) -> integer
 *
 * Read a master volume. If called with just volume, /dev/mixer
 * is used, otherwise /dev/mixerN is used as a device.
 *
 * This call returns the volume on success and -1, if it fails.
 *
 * @example SCR (`Read (.volume)) -> 50
 * @example SCR (`Read (.volume.1)) -> -1
 */
YCPValue ossGetVolume(const string channel, const string card) {

    string mixerfile = "/dev/mixer";
    mixerfile += card;

    stereovolume volume;

    int device = SOUND_MIXER_VOLUME;
    if(channel!="") {
	device = ossDevice(channel);
	if(device == -1)
	    return YCPBoolean(false);
    }

    int mixer_fd = open(mixerfile.c_str(), O_RDWR, 0);
    if(mixer_fd < 0) {
	y2error("%s",string("cannot open mixer: '" + string(mixerfile) +
			    "' : " + string(strerror(errno))).c_str());
	/* FIXME y2error -> YCPError */
	return YCPInteger(-1);
    }

    if(ioctl(mixer_fd,MIXER_READ(device),&volume) == -1) {
	y2error(string("ioctl failed : " + string(strerror(errno))).c_str());
	return YCPInteger(-1);
    }

    if(volume.left != volume.right)
	y2warning("volume is not balanced (%d,%d)", volume.left, volume.right);

    int vol = volume.left;
    if(vol<0) {
	y2warning("read volume set to 0");
	vol=0;
    }
    if(vol>99) {
	y2warning("read volume set to 99");
	vol=99;
    }
}

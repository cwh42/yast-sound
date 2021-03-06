# encoding: utf-8

module Yast
  class GetCardLabelClient < Client
    def main
      Yast.import "UI"
      # testedfiles: Sound.ycp sound/routines.ycp

      Yast.include self, "testsuite.rb"
      @READ_I = { "target" => { "size" => -1, "tmpdir" => "/tmp" } }

      TESTSUITE_INIT([@READ_I], nil)
      Yast.include self, "sound/routines.rb"

      @card = {}

      TEST(lambda { get_card_label(@card) }, [], nil)

      @card = {
        "bus"           => "PCI",
        "class_id"      => 4,
        "device"        => "SB Live! EMU10000",
        "device_id"     => 65538,
        "drivers"       => [
          {
            "active"   => false,
            "modprobe" => true,
            "modules"  => [["emu10k1", ""]]
          }
        ],
        "resource"      => {
          "io"  => [
            {
              "active" => true,
              "length" => 0,
              "mode"   => "rw",
              "start"  => 49152
            }
          ],
          "irq" => [{ "count" => 1146364, "enabled" => true, "irq" => 10 }]
        },
        "rev"           => "7",
        "sub_class_id"  => 1,
        "sub_device"    => "CT4830 SBLive! Value",
        "sub_device_id" => 98342,
        "sub_vendor"    => "Creative Labs",
        "sub_vendor_id" => 69890,
        "unique_key"    => "CvwD.k1dGGUobcK9",
        "vendor"        => "Creative Labs",
        "vendor_id"     => 69890
      }

      TEST(lambda { get_card_label(@card) }, [], nil)

      @card = {
        "bus"           => "PCI",
        "class_id"      => 4,
        "device"        => "",
        "device_id"     => 65538,
        "drivers"       => [
          {
            "active"   => false,
            "modprobe" => true,
            "modules"  => [["emu10k1", ""]]
          }
        ],
        "resource"      => {
          "io"  => [
            {
              "active" => true,
              "length" => 0,
              "mode"   => "rw",
              "start"  => 49152
            }
          ],
          "irq" => [{ "count" => 1146364, "enabled" => true, "irq" => 10 }]
        },
        "rev"           => "7",
        "sub_class_id"  => 1,
        "sub_device"    => "CT4830 SBLive! Value",
        "sub_device_id" => 98342,
        "sub_vendor"    => "Creative Labs",
        "sub_vendor_id" => 69890,
        "unique_key"    => "CvwD.k1dGGUobcK9",
        "vendor"        => "Creative Labs",
        "vendor_id"     => 69890
      }

      TEST(lambda { get_card_label(@card) }, [], nil)

      @card = {
        "bus"           => "PCI",
        "class_id"      => 4,
        "device"        => "",
        "device_id"     => 65538,
        "drivers"       => [
          {
            "active"   => false,
            "modprobe" => true,
            "modules"  => [["emu10k1", ""]]
          }
        ],
        "resource"      => {
          "io"  => [
            {
              "active" => true,
              "length" => 0,
              "mode"   => "rw",
              "start"  => 49152
            }
          ],
          "irq" => [{ "count" => 1146364, "enabled" => true, "irq" => 10 }]
        },
        "rev"           => "7",
        "sub_class_id"  => 1,
        "sub_device"    => "",
        "sub_device_id" => 98342,
        "sub_vendor"    => "Creative Labs",
        "sub_vendor_id" => 69890,
        "unique_key"    => "CvwD.k1dGGUobcK9",
        "vendor"        => "Creative Labs",
        "vendor_id"     => 69890
      }

      TEST(lambda { get_card_label(@card) }, [], nil)

      @card = {
        "bus"           => "PCI",
        "class_id"      => 4,
        "device"        => "",
        "device_id"     => 65538,
        "drivers"       => [
          {
            "active"   => false,
            "modprobe" => true,
            "modules"  => [["emu10k1", ""]]
          }
        ],
        "resource"      => {
          "io"  => [
            {
              "active" => true,
              "length" => 0,
              "mode"   => "rw",
              "start"  => 49152
            }
          ],
          "irq" => [{ "count" => 1146364, "enabled" => true, "irq" => 10 }]
        },
        "rev"           => "7",
        "sub_class_id"  => 1,
        "sub_device"    => "CT4830 SBLive! Value",
        "sub_device_id" => 98342,
        "sub_vendor"    => "Creative Labs",
        "sub_vendor_id" => 69890,
        "unique_key"    => "CvwD.k1dGGUobcK9",
        "vendor"        => "Creative Labs",
        "vendor_id"     => 69890
      }

      TEST(lambda { get_card_label(@card) }, [], nil)

      nil
    end
  end
end

Yast::GetCardLabelClient.new.main

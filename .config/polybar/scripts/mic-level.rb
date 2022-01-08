#!/usr/bin/env ruby

ICON_INTERNAL = 1
ICON_EXTERNAL = 2
ICON_INTERNAL_MUTED = 3

HOOK_NAME = "mic-volume-icon"

deviceName = "alsa_input.pci-0000_00_1b.0.analog-stereo"

data = `pactl list sources | grep "Name:\\|Volume: front-left\\|Active Port:" | grep "#{deviceName}" -A 3`.split("\n")

volume = ""
port = ""

data.each { |line|
    striped = line.strip
    if striped.index("Volume:") == 0
        volume = striped.split("/")[1].strip
    elsif striped.index("Active Port:") == 0
        name = striped.split(":")[1].strip
        if name.include? "internal"
            port = "IN-"
            `polybar-msg hook #{HOOK_NAME} #{ICON_INTERNAL}`
        else
            port = "EX-"
            `polybar-msg hook #{HOOK_NAME} #{ICON_EXTERNAL}`
        end
    end
}

puts "#{port}#{volume}"

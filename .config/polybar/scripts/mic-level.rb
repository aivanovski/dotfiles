#!/usr/bin/env ruby

ICON_INTERNAL = 1
ICON_EXTERNAL = 2
ICON_INTERNAL_MUTED = 3

HOOK_NAME = 'mic-volume-icon'.freeze
ERROR_RESPONSE = '?'.freeze

FRONT_LEFT = 'front-left'.freeze
FRONT_RIGHT = 'front-right'.freeze

INTERNAL_OUTPUT_NAME = 'analog-input-internal-mic'.freeze
EXTERNAL_OUTPUT_NAME = 'analog-input-headset-mic'.freeze

def parse_volume(line)
  # Line example: 'Volume: front-left: 65536 / 100% / 0.00 dB,   front-right: 65536 / 100% / 0.00 dB'
  channels = line['Volume:'.length, line.length].split(',').map(&:strip)

  if channels.size != 2
    return ERROR_RESPONSE
  end

  if !channels[0].start_with?(FRONT_LEFT) || !channels[1].start_with?(FRONT_RIGHT)
    return ERROR_RESPONSE
  end

  left = channels[0].split('/')[1].strip.gsub('%', '')
  right = channels[1].split('/')[1].strip.gsub('%', '')

  if left == right
    left.to_s
  else
    "#{left}:#{right}"
  end
end

def main
  device_name = 'alsa_input.pci-0000_00_1f.3.analog-stereo'

  data = `pactl list sources | grep "Name:\\|Volume: front-left\\|Active Port:" | grep "#{device_name}" -A 3`.split("\n").map(&:strip)
  # data = `cat $HOME/tmp/pactl-internal-mic-mutes.txt | grep "Name:\\|Volume:\\|Active Port:" | grep "#{device_name}" -A 3`.split("\n").map(&:strip)

  volume = ''
  port = ''

  data.each { |line|
    if line.start_with?('Volume:')
      volume = parse_volume(line)
    elsif line.start_with?('Active Port:')
      name = line.split(':')[1].strip
      if name.include? 'internal'
        port = 'IN-'
        `polybar-msg hook #{HOOK_NAME} #{ICON_INTERNAL}`
      else
        port = 'EX-'
        `polybar-msg hook #{HOOK_NAME} #{ICON_EXTERNAL}`
      end
    end
  }

  puts "#{port}#{volume}"
end

main

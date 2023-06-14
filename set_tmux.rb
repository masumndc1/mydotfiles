#!/usr/env/env ruby

def set_tmux(file)
  home = ENV['HOME']
  location_tmux_conf = "#{home}/.#{file}"
  backup_tmux_conf = "#{home}/.#{file}.bk"
  tmux_plugins_location = "#{home}/.tmux/plugins/tpm"

  if !File.exist?(location_tmux_conf)
    `cp #{file} #{location_tmux_conf}`
  else
    `cp #{location_tmux_conf} #{backup_tmux_conf}`
    `cp #{file} #{location_tmux_conf}`
  end

  if !File.exist?(tmux_plugins_location)
    `git clone https://github.com/tmux-plugins/tpm #{tmux_plugins_location}`
  else
    puts 'tpm location is set'
  end
end

def main
  if ARGV[0]
    file = ARGV[0]
    set_tmux(file)
  else
    puts 'ruby set_tmux.rb tmux.conf'
  end
end

main if __FILE__ == $PROGRAM_NAME

require "socket"
require "date"
require "time"

module CSGOLytics; end

class CSGOLytics::LogParser

  def parse(line)
    ev = nil
    return ev if ev = parse_frag(line)
    return ev
  end

private

  def parse_frag(line)
    r = /^L (?<time>\d{2}\/\d{2}\/\d{4} - \d{2}:\d{2}:\d{2}): "(?<attacker_name>.*)<\d+><(?<attacker_steamid>BOT|(STEAM_\d+:\d+:\d+))><(?<attacker_team>CT|TERRORIST)>" \[(?<attacker_coords>-?\d+ -?\d+ -?\d+)\] killed "(?<victim_name>.*)<\d+><(?<victim_steamid>BOT|(STEAM_\d+:\d+:\d+))><(?<victim_team>CT|TERRORIST)>" \[(?<victim_coords>-?\d+ -?\d+ -?\d+)\] with "(?<weapon>\w+)" ?\(?(?<headshot>headshot)? ?(?<penetrated>penetrated)?\)?$/

    m = r.match(line)
    if m
      attacker_coords = m[:attacker_coords].split
      victim_coords = m[:victim_coords].split

      return {
        :event => "frag",
        :time => parse_time(m[:time]).utc.iso8601,
        :attacker_name => m[:attacker_name],
        :attacker_steamid => m[:attacker_steamid],
        :attacker_team => normalize_team(m[:attacker_team]),
        :attacker_coords_x => attacker_coords[0].to_i,
        :attacker_coords_y => attacker_coords[1].to_i,
        :attacker_coords_z => attacker_coords[2].to_i,
        :victim_name => m[:victim_name],
        :victim_steamid => m[:victim_steamid],
        :victim_team => normalize_team(m[:victim_team]),
        :victim_coords_x => victim_coords[0].to_i,
        :victim_coords_y => victim_coords[1].to_i,
        :victim_coords_z => victim_coords[2].to_i,
        :weapon => m[:weapon],
        :headshot => !!m[:headshot],
        :penetrated => !!m[:penetrated]
      }
    end
  end

  def parse_time(time_str)
    DateTime.strptime("#{time_str} #{Time.now.strftime("%:z")}", "%m/%d/%Y - %H:%M:%S %z").to_time
  end

  def normalize_team(team)
    case team
      when "CT" then return "CT"
      when "T" then return "T"
      when "TERRORIST" then return "T"
      else return "?"
    end
  end

end
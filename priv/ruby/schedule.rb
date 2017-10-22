# frozen_string_literal: true
require "ice_cube"
require "active_support/time"

def daily(start_time, days)
  # time should be a string. needs to be a Time/DateTime object for IceCube.
  start_time = Time.parse(start_time)

  schedule = IceCube::Schedule.new(start_time) do |s|
    s.add_recurrence_rule(IceCube::Rule.daily.count(days))
  end

  schedule.all_occurrences.map(&:to_s)
end

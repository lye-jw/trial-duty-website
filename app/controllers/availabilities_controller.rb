require 'set'

class AvailabilitiesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @time_ranges = TimeRange.order(:start_time)
    @availabilities = load_availabilities
    create_missing_availabilities
    @disable_viewport = true
  end

  def update_availabilities
    availability_ids = params[:availability_ids] || []
    Availability.where(user: current_user).each do |availability|
      available = availability_ids.include?(availability.id.to_s)
      availability.update(status: available) if availability.status != available
    end
    redirect_to availabilities_path
  end

  def show_everyone
    @time_ranges = TimeRange.order(:start_time)
    @availabilities = load_all_availabilities
    @users = load_all_users
  end

  private

  def load_all_availabilities
    result = {}
    Availability.joins(:time_range)
                .order(:day, 'time_ranges.start_time')
                .each do |a|
      result[[a.day, a.time_range_id]] ||= []
      result[[a.day, a.time_range_id]].push(a.user_id) if a.status
    end
    result
  end

  def load_all_users
    User.all.map do |u|
      [u.id, { username: u.username, mc: u.mc }]
    end.to_h
  end

  def load_availabilities
    Availability.where(user: current_user).joins(:time_range)
                .order('day', 'time_ranges.start_time')
                .map do |availability|
      [[availability.day, availability.time_range_id], availability]
    end.to_h
  end

  def create_missing_availabilities
    Availability.days.each_key do |day|
      @time_ranges.each do |time_range|
        next if @availabilities.key?([day, time_range.id])

        @availabilities[[day, time_range.id]] = Availability.create(
          user: current_user, day: day,
          time_range_id: time_range.id, status: false
        )
      end
    end
  end
end
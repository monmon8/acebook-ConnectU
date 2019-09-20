# module ApplicationCable
#   class Channel < ActionCable::Channel::Base
#   end
# end
class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find params[:room]
    stream_for room

    # or
    # stream_from "room_#{params[:room]}"
  end
end

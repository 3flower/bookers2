class ChatController < ApplicationController

  def top
    if user_signed_in?
      @room = Room.new
      @rooms = current_user.rooms
      @nonrooms = Room.where(id: UserRoom.where.not(user_id: current_user.id).pluck(:id))
    end
  end

  def show
    @room = Room.find(params[:id])
    @chats = @room.chats
  end

  def create
    @room = Room.new(room_params)
    @room.save
    current_user.user_rooms.create(room_id: @room.id)
    redirect_to @room
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end

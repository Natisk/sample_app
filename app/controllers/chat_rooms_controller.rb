class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chat_rooms = ChatRoom.paginate(page: params[:page])
  end

  def new
    @chat_room = ChatRoom.new
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  def destroy
    @chat_room = ChatRoom.find_by(id: params[:id])
    @chat_room.destroy
    flash[:success] = 'Chat room deleted'
    redirect_to request.referrer || root_url
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
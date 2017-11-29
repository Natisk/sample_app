# frozen_string_literal: true

class PersonalMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_conversation!

  def new
    redirect_to conversation_path(@conversation) and return if @conversation
    @personal_message = current_user.personal_messages.build
  end

  def create
    conversation ||= Conversation.create(author: current_user, receiver: @receiver)
    personal_message = current_user.personal_messages.build(personal_message_params)
    personal_message.conversation_id = conversation.id
    personal_message.save!
    flash[:success] = 'Your message was sent!'
    redirect_to conversation_path(@conversation)
  end

  private

  def personal_message_params
    params.require(:personal_message).permit %i[body]
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find(params[:receiver_id])
      return redirect_to(root_path) unless @receiver

      @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find(params[:conversation_id])
      return redirect_to(root_path) unless @conversation && @conversation.participates?(current_user)
    end
  end
end

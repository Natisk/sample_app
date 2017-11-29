# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, except: %i[index]
  before_action :check_participating!, except: %i[index]

 def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC').paginate(page: params[:page])
  end

  def show
    @personal_message = PersonalMessage.new
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def check_participating!
    redirect_to root_path unless @conversation && @conversation.participates?(current_user)
  end
end

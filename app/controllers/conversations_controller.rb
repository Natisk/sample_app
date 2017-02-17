class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
  end
end

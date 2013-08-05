class HipsterController < ApplicationController
  def index
    @rooms = Room.all
    @messages = Message.messages('Dev Lab')

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end

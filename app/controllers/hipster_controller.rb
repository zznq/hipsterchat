class HipsterController < ApplicationController
  def index
    @messages = Message.messages('Dev Lab')
  end
end

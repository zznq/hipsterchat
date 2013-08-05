class Message < ActiveRecord::Base

  attr_accessible :date, :from_id, :message
  has_one :from, class_name: "User", foreign_key: "user_id"

  def self.messages(name)
    if @service.nil?
      @service = HipchatService.new(ENV['HIPCHAT_API_KEY']);
    end

    messages = @service.room_history(name)
    return messages
  end
end

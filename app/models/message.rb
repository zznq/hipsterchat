class Message < ActiveRecord::Base

  attr_accessible :date, :from_id, :message, :from
  has_one :from, class_name: "User", foreign_key: "user_id"

  def self.messages(name)
    if @service.nil?
      @service = HipchatService.new(ENV['HIPCHAT_API_KEY']);
    end

    return new_messages(@service.room_history(name))
  end

  def self.new_messages(messages_json)
    messages_json.inject([]) do |messages, m|
      messages << create_message(m)
    end
  end

  def self.new_message(message)
    user = User.new(message['from'])
    message['from'] = user
    Message.new(message)
  end
end

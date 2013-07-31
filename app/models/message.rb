class Message < ActiveRecord::Base
  attr_accessible :date, :from_id, :message
  has_one :from, class_name: "User", foreign_key: "from_id"
end

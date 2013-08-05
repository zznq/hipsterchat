class Room < ActiveRecord::Base
  attr_accessible :is_archived, :is_private, :name,
                  :room_id, :topic

  def self.create_service
    @service ||= HipchatService.new(ENV['HIPCHAT_API_KEY'])
  end

  def self.all
    self.create_service
    @service.rooms
  end

  def self.room(name)
    self.create_service
    @service.room(name)
  end

  def self.room_by_id(id)
    self.create_service
    @service.room_by_id(id)
  end
end

require 'spec_helper'

describe HipchatService do
  before :all do
    @service = HipchatService.new('57945bad79575cfbef20f0af08550d')
  end
  describe "GET" do
    it "should retrieve a list of rooms" do
      rooms = @service.rooms
      rooms.should_not be_nil 
      rooms.should be_instance_of(Array)
    end
    it "should retrieve the room with id 1" do
      pending
      room = @service.room_by_id 1
      room.room_id.should == 1 
    end
    it "should retrieve the room with name 'DevLab'" do
      pending
      room = @service.room 'DevLab'
      room.should_not be nil
      room.name.should == 'DevLab'
    end
  end
  describe "GET room history by room id"
  describe "GET room history by room name"
end

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

    it "should retrieve the room with name 'Dev Lab'" do
      room = @service.room 'Dev Lab'
      room.should_not be_nil
      room['name'].should == 'Dev Lab'
    end

    it "should retrieve the room with id 251762" do
      room = @service.room_by_id(251762)
      room['room_id'].should == 251762
    end

    it "should retrieve messages from room with name Dev Lab" do
      history = @service.room_history 'Dev Lab'
      history.should_not be_nil
      history.should be_instance_of(Array)
      history.all? { |m| m.key?('message').should be_true }
    end

    it "should retrieve messages from room with id 251762" do
      history = @service.room_history_by_id(251762)
      history.should_not be_nil
      history.should be_instance_of(Array)
      history.all? { |m| m.key?('message').should be_true }
    end
  end
end

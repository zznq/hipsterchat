require 'spec_helper'

describe HipchatService do
  before :all do
    @service = HipchatService.new(ENV['HIPCHAT_API_KEY'])
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

    it "should return nil for invalid room name" do
      room = @service.room 'Invalid'
      room.should be_nil
    end

    it "should retrieve the room with id 251762" do
      room = @service.room_by_id(251762)
      room['room_id'].should == 251762
    end

    it "should return nil for invalid room id" do
      room = @service.room_by_id(0)
      room.should be_nil
    end

    it "should retrieve messages from room with name Dev Lab" do
      history = @service.room_history 'Dev Lab'
      history.should_not be_nil
      history.should be_instance_of(Array)
      history.all? { |m| m.key?('message').should be_true }
    end

    it "should return nil for room history when name invalid" do
      history = @service.room_history 'Invalid'
      history.should be_nil
    end

    it "should return nil for room history when id invalid" do
      history = @service.room_history_by_id(0)
      history.should be_nil
    end

    it "should retrieve messages from room with id 251762" do
      history = @service.room_history_by_id(251762)
      history.should_not be_nil
      history.should be_instance_of(Array)
      history.all? { |m| m.key?('message').should be_true }
    end
  end
end

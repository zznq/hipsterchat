require 'spec_helper'

describe HipchatService do
  before :all do
    @service = HipchatService.new(ENV['HIPCHAT_API_KEY'], DateTime.new('2013-08-01'))
  end

  describe "GET" do
    it "should retrieve a list of rooms" do
      rooms = @service.get_rooms
      rooms.should_not be_nil
      rooms.should be_instance_of(Array)
    end

    it "should return empty array for room history when id invalid" do
      history = @service.room_history(0)
      history.should be_empty
    end

    it "should retrieve messages from room with id 251762" do
      history = @service.room_history(251762)
      history.should_not be_nil
      history.should be_instance_of(Array)
      history.all? { |m| m.key?('message').should be_true }
    end
  end

  describe "Poll" do
    it "should consolidate rooms with db" do
      rooms = @sercvice.poll_rooms

      rooms.each do |r|
        Room.where(:room_id => r.room_id).should_not be_nil
      end
    end

    it "should consolidate history for room 251762 with db" do
      history = @service.poll_history()

      history.each do |history|
        m = Message
          .where(:date => history.date)
          .where(:message => history.message)

        m.should_not be_nil
      end
    end
  end
end

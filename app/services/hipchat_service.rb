class HipchatService
  include HTTParty

  base_uri 'https://api.hipchat.com'
  format :json

  def initialize(auth_token)
    @options = {:query => {:auth_token => auth_token}}
  end

  def retrieve_rooms
    response = self.class.get('/v1/rooms/list', @options)
    @rooms = response.parsed_response['rooms']
  end

  def retrieve_room_history(id, date='recent')
    params = @options.deep_merge({:query => {:room_id => id,
      :date => date}})
    messages = self.class.get('/v1/rooms/history', params)

    return messages.parsed_response['messages']
  end

  def rooms
    if @rooms.nil?
      retrieve_rooms
    end

    return @rooms
  end

  def room(name)
    if @rooms.nil?
      retrieve_rooms
    end

    # returns either the first occurance of the
    # room matching name or nil
    @rooms.find { |item| item['name'] == name }
  end

  def room_by_id(id)
    if @rooms.nil?
      retrieve_rooms
    end

    # returns either the first occurance of the
    # room matching id or nil
    @rooms.find { |item| item['room_id'] == id }
  end

  def room_history(name)
    if @rooms.nil?
      retrieve_rooms
    end

    room_data = room(name)

    retrieve_room_history(room_data["room_id"]) unless room_data.nil?
  end

  def room_history_by_id(id)
    retrieve_room_history(id)
  end
end

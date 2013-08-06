class HipchatService
  include HTTParty

  base_uri 'https://api.hipchat.com'
  format :json

  def initialize(auth_token, last_record)
    @options = {:query => {:auth_token => auth_token}}
    @last_record = last_record
  end

  def poll
    rooms = poll_rooms

    reconcile_rooms(rooms)

    rooms.each do |room|
      if rooms.last_active > @last_record
        messages = poll_history(room.room_id)
        reconcile_messages(room_id, messages)
      end
    end
  end

  def poll_rooms
    response = self.class.get('/v1/rooms/list', @options)

    response.parsed_response['rooms'] || []
  end

  def reconcile_rooms(rooms)
    rooms.inject([]) do |output, room|
      output << reconcile_room(room)
    end
  end

  def reconcile_room(room)
    Room.where(:room_id => room.room_id) || Room.create(r)
  end

  def poll_history(room_id)
    date = Message.maximum('date')

    messages = []
    if date.nil?
      messages = poll_history_for_date(room_id, 'recent')
    else
      (date - Date.now).to_i.times do |i|
        messages.concat(poll_history_for_date(room_id, (date + i.days).strftime('%F')))
      end
    end

    return messages
  end

  def poll_history_for_date(room_id, date)
    params = @options.deep_merge({:query => {:room_id => room_id,
      :date => date}})
    response = self.class.get('/v1/rooms/history', params)

    return response.parsed_response['messages'] || []
  end

  def reconcile_messages(room_id, messages)
    messages.inject([]) do |output, message|
      output << reconcile_message(room_id, message)
    end
  end

  def reconcile_message(room_id, message)
    m = Message
          .where(:room_id => room_id)
          .where(:date => message.date)

    unless m.nil?
      m = Message.new_message(message)
      m.save
    end

    return m
  end
end

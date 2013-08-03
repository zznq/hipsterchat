class HipchatService
  include HTTParty

  base_uri 'https://api.hipchat.com/v1'

  def initialize(auth_token)
    @options = { :auth_token => auth_token }
  end

  def rooms
    @rooms = self.class.get('/rooms/list', @options)
    return rooms
  end
end

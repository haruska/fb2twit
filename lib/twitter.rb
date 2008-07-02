module Twitter

  SUCCESS = :success
  UNAUTHORIZED = :unauthorized
  UNKNOWN = :unknown
  
  # Updates the authenticating user's status.
  # Requires the status parameter specified below.
  # Request must be a POST.
  #
  # URL: http://twitter.com/statuses/update.format
  # Formats: xml, json. Returns the posted status in requested format when successful.
  # Parameters:
  #
  # status. Required. The text of your status update.
  # Be sure to URL encode as necessary. Must not be more than 160 characters and should
  # not be more than 140 characters to ensure optimal display.
  
  def self.update_status(name, pass, status)
    url = URI.parse("http://twitter.com/statuses/update.xml")
    req = Net::HTTP::Post.new url.path
    req.basic_auth name, pass
    
    req.set_form_data 'status' => status, 'source' => 'fb2twit'
    
    net = Net::HTTP.new url.host
    net.open_timeout = 30
    net.read_timeout = 30
    
    begin
      res = net.start { |http| http.request req }
    rescue Timeout::Error
      return Twitter::UNKNOWN
    end 
    
    self.response_value res
  end
  
  
  def self.auth_check(name, pass)
    url = URI.parse("http://twitter.com/statuses/friends_timeline.json")
    req = Net::HTTP::Get.new url.path
    req.basic_auth name, pass
    
    net = Net::HTTP.new url.host
    net.read_timeout = 15
    
    begin
      res = net.start { |http| http.request req }
    rescue Timeout::Error
      return Twitter::UNKNOWN
    end
    
    self.response_value res
  end
  
  protected
  
  def self.response_value(http_response)
    case http_response
    when Net::HTTPOK
      Twitter::SUCCESS
    when Net::HTTPUnauthorized
      Twitter::UNAUTHORIZED
    else
      Twitter::UNKNOWN
    end
  end
  
end
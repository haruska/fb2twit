module Twitter
  
  # Updates the authenticating user's status.
  # Requires the status parameter specified below.  
  # Request must be a POST.
  # 
  # URL: http://twitter.com/statuses/update.format
  # Formats: xml, json.  Returns the posted status in requested format when successful.
  # Parameters:
  #
  # status.  Required.  The text of your status update.  
  # Be sure to URL encode as necessary.  Must not be more than 160 characters and should 
  # not be more than 140 characters to ensure optimal display.
  
  def self.update_status(name, pass, status)
    url = URI.parse("http://#{CGI::escape(name)}:#{CGI::escape(pass)}@twitter.com/statuses/update.xml")
    res = Net::HTTP.post_form(url, {'status' => status, 'source' => 'fb2twit'})
    case res.code_type.to_s
    when "Net::HTTPOK"
      :success
    when "Net::HTTPUnauthorized"
      :unauthorized
    else
      :unknown
    end
  end
  
end
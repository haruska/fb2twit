#!/usr/bin/env ruby

User.find(:all).each do |user|
  begin
    user.update_twitter
  rescue => e
    logger.error { "Couldn't update twitter user #{user.twitter_name}\n#{e.to_s}" }
  end
end
#!/usr/bin/env ruby
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + '/../../config/boot'
LOG_PATH = "#{RAILS_ROOT}/log/twitter_update.log"
require File.dirname(__FILE__) + "/../../config/environment"

logger = RAILS_DEFAULT_LOGGER
logger.info "Started twitter daemon"

$running = true;
Signal.trap("TERM") do 
  $running = false
end

wait_count = 0

begin
  while($running) do
    if wait_count <= 0
      wait_count = 300 #5 min polling
      begin
        logger.info "Starting updates at #{Time.now}"
        User.find(:all).each(&:update_twitter)
      rescue Exception => exception
        logger.error exception.to_s
      end
    else
      wait_count -= 1
      sleep 1
    end
  end
rescue Exception => exception
  logger.error exception.to_s
  exit!(1)
end

logger.info "twitter daemon exiting"
exit!(0)
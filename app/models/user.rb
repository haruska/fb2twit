class User < ActiveRecord::Base
  
  def session
    YAML::load(self["session"])
  end
  
  def session=(val)
    self["session"] = val.to_yaml
  end
  
  def update_twitter
    logger.info {"updating self #{self.facebook_id}"}
    unless self.twitter_name.blank? || self.twitter_pass.blank? || self.bad_pass?
      begin
        msg = self.session.user.status.message
      rescue Facebooker::Session::SessionExpired
        message = ''
        self.destroy
      end
      logger.info {"message: #{msg}"}
      if !msg.blank? && self.last_status != msg.to_s
        f_msg = self.remove_is? ? msg.gsub(/^is /,"") : msg
        f_msg = self.pretext.blank? ? f_msg : "#{self.pretext} #{f_msg}"
        if self.ignore.blank? || !f_msg.match(self.ignore)
          case Twitter::update_status(self.twitter_name, self.twitter_pass, f_msg)
          when :success
            self.update_attribute :last_status, msg.to_s
          when :unauthorized
            self.update_attribute :bad_pass, true
          else
            logger.error {"unknown twitter response"}
          end
        end
      end
    end
  end
  
end

class Log < ActiveRecord::Base
  belongs_to :user

  # Crane Logger
  module CrLogger
    def log(user, msg)
      Log.create({
        :user       => user,
        :controller => controller_name,
        :action     => action_name,
        :message    => msg
      })
    end
  end
end
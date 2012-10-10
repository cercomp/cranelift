class Log < ActiveRecord::Base
  belongs_to :user

  default_scope :order => 'created_at DESC'

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

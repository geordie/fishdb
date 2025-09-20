# Be sure to restart your server when you modify this file.

# Configure parameters to be partially matched (e.g. params[:blog_name] = 'weblog')
# Rails.application.config.action_controller.partial_inserts = true

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [
  :passw, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn
]

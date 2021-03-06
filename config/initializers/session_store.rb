# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => ENV['SESSION_KEY'] || '_australia_session',
  :secret      => ENV['SESSION_SECRET'] || 'a0a9c93e1bcb8722fb672d2967c119bf703e50f891c9354dd390ac4ae591ae5e1611d925208a019f688e51e3ba87b30f0e1faed11bb14fa219535e2420c5d0ca'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

ActionController::Dispatcher.middleware.insert_before(ActionController::Base.session_store, FlashSessionCookieMiddleware, ActionController::Base.session_options[:key])
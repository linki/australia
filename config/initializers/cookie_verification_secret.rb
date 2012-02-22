# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.cookie_verifier_secret = ENV['SESSION_SECRET'] || '2602b120798ef2a2eb94d811e7d85488ccba4f205bf51743d529f324db886096cab177b44d7de04296910d3fb9c235d2953f299d7ed7e1db2d270ef311f434b5';

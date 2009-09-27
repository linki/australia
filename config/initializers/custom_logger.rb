# Custom Logger for Rawk production log analyzer
# http://ckhsponge.wordpress.com/2006/10/11/ruby-on-rails-log-analyzer-rawk/

# Rails > 2.0 uses BufferedLogger
module ActiveSupport
  class BufferedLogger
     def add(severity, message = nil, progname = nil, &block)
       return if @level > severity
       message = (message || (block && block.call) || progname).to_s
       # If a newline is necessary then create a new message ending with a newline.
       # Ensures that the original message is not mutated.
	   message = "#{message} (pid:#{$$})" if RAILS_ENV=="production"	   
       message = "#{message}\n" unless message[-1] == ?\n
       buffer << message
       auto_flush
       message
     end
   end
end
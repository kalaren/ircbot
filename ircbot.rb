require "socket"
require 'nokogiri'
require 'open-uri'
#require 'timeout'

class Headline

	

	def initialize()

		@server = "chat.freenode.net"
		@port = "6667"
		@nick = "DrewEricSbot"
		@channel = "#bitmaker"
		@s = TCPSocket.open(@server, @port)
		# @s.setsockopt(Socket::SOL_SOCKET, Socket::SO_RCVTIMEO, 10)
		print("addr: ", @s.addr.join(":"), "\n")
		print("peer: ", @s.peeraddr.join(":"), "\n")
		@s.puts "USER eksdsbot 0 * eksdsbot"
		@s.puts "NICK #{@nick}"
		@s.puts "JOIN #{@channel}"
		# @s.puts "PRIVMSG #{@channel} :Hello this is Eric and Drew's headline bot."
		# @s.puts "PRIVMSG #{@channel} :Type -headline for the Toronto Star's top headline"
		@old_headline = ""
		@new_headline = ""
		@time = Time.new
		

 
	end

	def send
	end

	def new_headline_check
		data = Nokogiri::HTML(open("http://thestar.com"))
		@new_headline = data.at_css(".headline").text.strip

  	if @new_headline == @old_headline
  		@time = Time.now
  		return false
  	else
  		@time = Time.now
  		@old_headline = @new_headline
  		return true
  	end
  end


	def run

		until @s.eof? do
		  
		  #gets receives no inputs after x amount of time do something else
		  # wait for input for 20 seconds, if nothing then run check
		  msg = @s.gets
			 #  begin
			 #  Timeout::timeout(5) do
				# 				msg = @s.gets
				# 			end
				# rescue Timeout::Error
				# 	msg = "BITMAKEREKS"
				# end
		  puts msg
			check = new_headline_check
				if  check == true
					new_headline_check
					@s.puts "PRIVMSG #{@channel} :As of #{@time} there is a new thestar.com headline!"
					@s.puts "PRIVMSG #{@channel} :#{@new_headline}"
				end
		 #  if msg == Error
		  	
			# 		@s.puts "PRIVMSG #{@channel} :New headline!"
			# 		@s.puts "PRIVMSG #{@channel} :#{@new_headline}"
				
			# 		@s.puts "PRIVMSG #{@channel} :Old headline :("
				
			# end

		  if msg.include? "list"
				@s.puts "PRIVMSG #{@channel} :Hello this is Eric Szeto and Drew Sing's headline bot."
				@s.puts "PRIVMSG #{@channel} :Type -headline for the Toronto Star's top headline"
			end


				  		
		  if msg.include? "-headline"
				new_headline_check
		  	@s.puts "PRIVMSG #{@channel} :As of #{@time} the headline at thestar.com is:"
		  	@s.puts "PRIVMSG #{@channel} :#{@old_headline}"
		  end
		end
	end
end

bot = Headline.new
bot.run

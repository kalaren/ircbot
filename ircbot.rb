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
		@s.puts "PRIVMSG #{@channel} :Hello this is Eric and Drew's headline bot."
		@s.puts "PRIVMSG #{@channel} :Type -headline for the Toronto Star's top headline"
		@old_headline = ""
		@new_headline = ""
		@time = Time.new
		

 
	end

	def send
	end

	def new_headline_check
		data = Nokogiri::HTML(open("http://thestar.com"))
		@new_headline = data.at_css(".headline").text.strip
		@time = Time.now
  	if @new_headline == @old_headline
  		return false
  	else
  		@old_headline = @new_headline
  		return true
  	end
  end


	def run

		t = Thread.new do
			loop do
				sleep (60)
				check = new_headline_check
				if check == true
					new_headline_check
					@s.puts "PRIVMSG #{@channel} :As of #{@time} there is a new thestar.com headline!"
					@s.puts "PRIVMSG #{@channel} :#{@new_headline}"
				end
			end
		end

		until @s.eof? do

		  msg = @s.gets
		  puts msg

		  if msg.include? "PING :"
		  	@s.puts "PONG"
		  	next
		  end

		  if msg.include? "PRIVMSG #{@channel} :list"
				@s.puts "PRIVMSG #{@channel} :Hello this is Eric Szeto and Drew Sing's headline bot."
				@s.puts "PRIVMSG #{@channel} :Type -headline for the Toronto Star's top headline"
				next
			end
				  		
		  if msg.include? "PRIVMSG #{@channel} :-headline"
				new_headline_check
		  	@s.puts "PRIVMSG #{@channel} :As of #{@time} the headline at thestar.com is:"
		  	@s.puts "PRIVMSG #{@channel} :#{@old_headline}"
		  	next
		  end

		end

	end

end

bot = Headline.new
bot.run

require "socket"
require 'nokogiri'
require 'open-uri'

class Headline

	

	def initialize()

		@server = "chat.freenode.net"
		@port = "6667"
		@nick = "DrewEricSbot"
		@channel = "#bitmaker2"
		@s = TCPSocket.open(@server, @port)
		print("addr: ", @s.addr.join(":"), "\n")
		print("peer: ", @s.peeraddr.join(":"), "\n")
		@s.puts "USER eksdsbot 0 * eksdsbot"
		@s.puts "NICK #{@nick}"
		@s.puts "JOIN #{@channel}"
		@s.puts "PRIVMSG #{@channel} :Hello from IRB Bot"
		

 
	end

	def send
	end

	def run

		until @s.eof? do
			data = Nokogiri::HTML(open("http://thestar.com"))
		  headline = ""
		  msg = @s.gets
		  puts msg

		  if msg.include? "headline"
		  	headline = data.at_css(".headline").text.strip
		  	@s.puts "PRIVMSG #{@channel} :The current headline at Toronto Star is: #{headline}"
		  end
		end
	end
end

bot = Headline.new
bot.run

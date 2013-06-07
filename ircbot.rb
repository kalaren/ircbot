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
		@s.puts "PRIVMSG #{@channel} :Hello this is Eric and Drew's headline bot."
		@s.puts "PRIVMSG #{@channel} :Type -headline for the Toronto Star's top headline"
		

 
	end

	def send
	end

	def run

		until @s.eof? do
			data = Nokogiri::HTML(open("http://thestar.com"))
		  headline = ""
		  msg = @s.gets
		  puts msg

		  if msg.include? "list"
		  	@s.puts "PRIVMSG #{@channel} :Headline Bot Type -headline for the Toronto Star's top headline"
		  end

		  if msg.include? "-headline"

		  	headline = data.at_css(".headline").text.strip
		  	@s.puts "PRIVMSG #{@channel} :The current headline at Toronto Star is:"
		  	@s.puts "PRIVMSG #{@channel} :#{headline}"
		  end
		end
	end
end

bot = Headline.new
bot.run

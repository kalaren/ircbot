require "socket"

server = "irc.rizon.net"
port = "6667"
nick = "Qintest"
channel = "#0x40"

s = TCPSocket.open(server, port)
print("addr: ", s.addr.join(":"), "\n")
print("peer: ", s.peeraddr.join(":"), "\n")
s.puts "USER testing 0 * Testing"
s.puts "NICK #{nick}"
s.puts "JOIN #{channel}"
s.puts "PRIVMSG #{channel} :Hello from IRB Bot"

until s.eof? do
  msg = s.gets
  puts msg
end
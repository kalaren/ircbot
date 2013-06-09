require 'monitor'

f = File.new("aaa.txt", "w")
lock = Monitor.new

t = Thread.new do
  lock.synchronize do
    f.puts("thread output1")
  end

  sleep(3)

  lock.synchronize do
    f.puts("thread output2")
  end
end

print "Enter command: "
STDOUT.flush
input = gets

lock.synchronize do
  f.puts(input)
end

t.join
f.close

File.open("aaa.txt") do |file|
  print file.read
end

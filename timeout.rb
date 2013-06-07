require 'timeout'

  msg = ""
		  #gets receives no inputs after x amount of time do something else
		  # wait for input for 20 seconds, if nothing then run check
		  
			  begin
			  Timeout::timeout(5) do
								msg = gets
							end
				rescue Timeout::Error
					msg = "BITMAKEREKS"
				end
		  puts msg
		  puts "pie" if msg == "BITMAKEREKS"
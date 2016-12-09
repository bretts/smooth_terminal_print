# SmoothTerminalPrint

The purpose of this program is to animate printing text in a terminal window while in a tight loop


## Example Usage - passing STDOUT via a block
```
require 'smooth_terminal_print'

smooth_terminal_print = SmoothTerminalPrint.new
loop do
	smooth_terminal_print.print_smoothly do
		puts Time.now.to_f * rand(10000)
		puts Time.now.to_f * rand(10000)
		puts Time.now.to_f * rand(10000)
		puts Time.now.to_f * rand(10000)
	end
end
```

## Example Usage - passing an IO object via a method param
```
require 'smooth_terminal_print'

smooth_terminal_print = SmoothTerminalPrint.new
loop do
	io = StringIO.new

	20.times do
		s = ''
		rand(100).times { s << '*' }
		io.puts s
	end

	smooth_terminal_print.print_smoothly(io)
end
```
# SmoothTerminalPrint

The purpose of this program is to animate printing text in a terminal window while in a tight loop


## Example Usage

```
require 'smooth_terminal_print'

loop do
    io = StringIO.new

    20.times do
        s = ''
        rand(100).times { s << '*' }
        io.puts s
    end

    SmoothTerminalPrint.start_stp(io)
end
```
SmoothTerminalPrint
===========

PURPOSE
-------
The purpose of this program is smoothly continoulsy update printing data to the terminal window while in a tight loop

FEATURES
--------
Adds ability to call SmoothTerminalPrint.start and SmoothTerminalPrint.stop

EXAMPLE USAGE
-------------
        1) gem install smooth_terminal print

        require 'smooth_terminal_print'
        trap('SIGINT') { SmoothTerminalPrint::stop; exit }

        loop do
            stars   = ''
            number  = rand(100)
            number.times { stars << '*' }
            stars.length.upto(100) { stars << ' '}
            
            SmoothTerminalPrint.start do
                puts number
                puts stars
            end
        end

        4) That's it.
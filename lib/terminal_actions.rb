module SmoothTerminalPrint
    module TerminalActions
        def clear_screen
            print "\e[2J"
        end

        def hide_cursor
            print "\e[?25l"
        end

        def move_to_top_left
            print "\e[H"
        end

        def show_cursor
            print "\e[?25h"
        end

        def move_to_bottom
            print "\e[2000E"
        end
    end
end
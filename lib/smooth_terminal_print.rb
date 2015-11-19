require 'stringio'

module SmoothTerminalPrint
    extend self

    def start(&block)
        @stp_reset_timer ||= Time.now.to_i
        
        if(Time.now.to_i - @stp_reset_timer > 1)
            clear_screen
            @stp_reset_timer = Time.now.to_i
        end
        hide_cursor
        move_to_top_left
        
        out = StringIO.new
        $stdout = out
        yield
        out.rewind

        num_lines = ((`tput lines`).strip.to_i) - 5
        num_lines.times do
            STDOUT.puts out.gets
        end

        $stdout = STDOUT
    end

    def stop
        move_to_bottom
        show_cursor
    end

    private
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
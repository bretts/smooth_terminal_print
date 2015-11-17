module SmoothTerminalPrint
    extend self

    def start(&block)
        @stp_reset_timer ||= Time.now.to_i

        if(Time.now.to_i - @stp_reset_timer > 1)
            print "\e[2J"
            @stp_reset_timer = Time.now.to_i
        end
        hide_cursor
        move_to_top_left
        yield
    end

    def stop
        move_to_bottom
        show_cursor
    end

    private
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
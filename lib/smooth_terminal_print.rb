require 'stringio'
require_relative './terminal_actions'

module SmoothTerminalPrint
    include TerminalActions
    extend self

    def start(&block)
        get_screen_dimensions

        hide_cursor

        move_to_top_left

        io = StringIO.new
        $stdout = io
        yield
        $stdout = STDOUT
        io.rewind

        print_text(io)
    end

    def stop
        $stdout = STDOUT
        move_to_bottom
        show_cursor
    end

    private
    def print_text(string_io)
        0.upto(@num_lines) do
            line = string_io.gets

            if line.nil?
                line = ''
            else
                line.strip!
                # If the line includes ANSI escape codes then I'm not sure currently how to
                # truncate them without creating a mess. So just skip them for now and suffer
                # the consequences, being that, the screen will not refresh properly if there are ANSI
                # escape codes in the string, AND the length of said string exceeds the total columns available.
                if(!line.include?("\e["))
                    line = line[0..@columns]
                end
            end

            line.length.upto(@columns) { line << ' ' }
            line << "\n"
            puts line
        end
    end

    def get_screen_dimensions
        @stp_reset_timer ||= nil

        if(@stp_reset_timer == nil || Time.now.to_i - @stp_reset_timer > 3)
            old_num_lines   = @num_lines
            old_num_cols    = @columns
            @num_lines      = (`tput lines`).strip.to_i - 2
            @columns        = `tput cols`.strip.to_i - 5

            if(old_num_lines != @num_lines || old_num_cols != @columns)
                clear_screen
            end

            @stp_reset_timer = Time.now.to_i
        end
    end
end
module SmoothTerminalPrint
	module TerminalActions
		def clear_screen
			return "\e[2J"
		end

		def hide_cursor
			return "\e[?25l"
		end

		def move_to_top_left
			return "\e[H"
		end

		def clear_to_line_end
			return "\e[K"
		end

		def show_cursor
			return "\e[?25h"
		end

		def move_to_bottom
			return "\e[2000E"
		end
	end
end
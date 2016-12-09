require 'stringio'
require_relative './terminal_actions'

class SmoothTerminalPrint
	include TerminalActions

	def initialize
		update_screen_dimensions

		trap('SIGINT')   { stop_smooth_printing_mode; exit }
		trap('SIGWINCH') { update_screen_dimensions }
		at_exit          { stop_smooth_printing_mode }
	end

	def print_smoothly(io)
		print(hide_cursor)
		print(move_to_top_left)

		print_text(io)
	end

	def stop_smooth_printing_mode
		print(move_to_bottom)
		print(show_cursor)
	end

	private
	def update_screen_dimensions
		@num_lines = `tput lines`.strip.to_i - 2
		@columns   = `tput cols`.strip.to_i - 5
	end

	def print_text(io)
		io.rewind

		0.upto(@num_lines) do
			line = io.gets

			if line.nil?
				line = ''
			else
				line.strip!
			end

			line << clear_to_line_end
			puts line
		end
	end
end
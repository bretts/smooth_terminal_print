require 'stringio'
require_relative './terminal_actions'

module SmoothTerminalPrint
	include TerminalActions
	extend self
	trap('SIGINT')   { SmoothTerminalPrint.stop_stp; exit }
	trap('SIGWINCH') { get_screen_dimensions }
	at_exit          { SmoothTerminalPrint.stop_stp }

	def start_stp(io)
		get_screen_dimensions
		print(hide_cursor)
		print(move_to_top_left)

		print_text(io)
	end

	def stop_stp
		print(move_to_bottom)
		print(show_cursor)
	end

	def get_screen_dimensions
		@num_lines = `tput lines`.strip.to_i - 2
		@columns   = `tput cols`.strip.to_i - 5

		print clear_screen
	end

	private
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
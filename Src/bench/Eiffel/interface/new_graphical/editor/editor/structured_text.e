indexing
	description: "Text Paragraph"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCTURED_TEXT

inherit
	ANY

create
	make, make_from_file

feature -- Initialization

	make is
		do
			create chapter.make
		end

	make_from_file (fn: STRING) is
		local
--			file: PLAIN_TEXT_FILE
--			line: like first_displayed_line
		do
--			create chapter.make
--			create file.make_open_read (fn)
--			from
--					
--			until
--				file.end_of_file
--			loop
--				file.read_line
--				create line.make_from_string (file.last_string)
--				append_line (line)
--			end
		end	

feature -- Access

	first_displayed_line: EDITOR_LINE

	last_displayed_line: like first_displayed_line

	nb_of_lines_displayed: INTEGER

	count: INTEGER is
		do
			Result := chapter.count
		end

feature -- test features

	item: like first_displayed_line

	after: BOOLEAN is
		do
			Result := (item = Void)
		end

	forth is
		do
			item := item.next
		end

	go_i_th (i: INTEGER) is
		do
			item := chapter.item (i)
		end

feature -- Element Change

	prepend_line (tl: like first_displayed_line) is
		do
			chapter.prepend_line (tl)
		end

	append_line, extend (tl: like first_displayed_line) is
		do
			chapter.append_line (tl)
		end

feature -- Basic Operations

	delete_selection (start_selection: TEXT_CURSOR; end_selection: TEXT_CURSOR) is
			-- Delete text between `start_selection' until `end_selection'.
			-- `end_selection' is not included.
		local
			s, aux: STRING
			line: EDITOR_LINE
			t : EDITOR_TOKEN
		do
				-- Retrieving line before `start_selection'.
			line := start_selection.line
			t := start_selection.token
			if t /= line.end_token then
				from
					s := t.image.substring (1, start_selection.pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
			else
				s := line.image
			end
				-- Retrieving line after `end_selection'.
			line := end_selection.line
			t := end_selection.token
			if t /= line.end_token then
				from
					s.append (t.image.substring (end_selection.pos_in_token, t.image.count))
					t := t.next
				until
					t = line.end_token
				loop
					s.append (t.image)
					t := t.next
				end
			end
				-- Removing unwanted lines.
			line := start_selection.line
			if line /= end_selection.line then
				from
				until
					line.next = end_selection.line
				loop
					line.next.delete
				end
				line.next.delete
			end
				-- Rebuild line with previously collected parts.
			lexer.execute (s)
			line.make_from_lexer (lexer)
		end

--	list is
--		do
--			chapter.list
--		end

feature {NONE} -- Private feature

-- 	prepare_line (line: like first_displayed_line) is
-- 			-- Prepare the line to be added in our
-- 			-- structure.
-- 		local
-- 			current_position: INTEGER
-- 			current_token	: EDITOR_TOKEN
-- 		do
-- 			from
-- 				line.start
-- 				current_position := 0
-- 			until
-- 				line.after
-- 			loop
-- 					-- Compute the position of each token.
-- 				current_token := line.item
-- 				current_token.set_position (current_position)
-- 				current_position := current_position + current_token.length
-- 
-- 					-- prepare next iteration
-- 				line.forth
-- 			end
-- 		end

feature -- Implementation

	lexer: EIFFEL_SCANNER is
			-- Eiffel Lexer
		once
			create Result.make
		end

feature {NONE} -- Implementation

	chapter: PARAGRAPH

end -- class STRUCTURED_TEXT

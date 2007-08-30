indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP


feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create manager.make (Current, Current)
			close_request_actions.extend (agent
																					local
																						l_env: EV_ENVIRONMENT
																					do
																						create l_env
																						l_env.application.destroy
																					end)
			prepare_content_1
			prepare_content_2
			prepare_tool_bar_content
		end

feature {NONE} -- Implementation functions

	prepare_content_1 is
			-- Prepare `content 1'
		require
			not_prepared: content_1 = Void
			not_void: manager /= Void
		do
			create content_1.make_with_widget (create {EV_RICH_TEXT}, "CONTENT_ONE")
			content_1.set_long_title ("Content 1 long title")
			content_1.set_short_title ("Content 1 title")
			manager.contents.extend (content_1)
			content_1.set_top ({SD_ENUMERATION}.top)
		ensure
			not_void: content_1 /= Void
		end

	prepare_content_2 is
			-- Prepare `content_2'
		require
			not_prepared: content_2 = Void
			not_void: manager /= Void
		do
			create content_2.make_with_widget (create {EV_RICH_TEXT}, "CONTENT_TWO")
			content_2.set_long_title ("Content 2 long title")
			content_2.set_short_title ("Content 2 title")
			manager.contents.extend (content_2)
			content_2.set_top ({SD_ENUMERATION}.top)
		ensure
			not_void: content_2 /= Void
		end

	prepare_tool_bar_content is
			-- Prepare `tool_bar_content'
		require
			not_prepared: tool_bar_content = Void
			not_void: manager /= Void
		local
			l_items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			l_item: SD_TOOL_BAR_BUTTON
			l_count, l_max_count: INTEGER
		do
			-- First we prepare tool bar items
			from
				l_max_count := 5
				create l_items.make (l_max_count)
			until
				l_count >= l_max_count
			loop
				create l_item.make
				l_item.set_text ("Button " + l_count.out)
				l_item.set_pixmap ((create {EV_STOCK_PIXMAPS}).Default_window_icon)
				l_items.extend (l_item)
				if l_count = 2 then
					l_items.extend (create {SD_TOOL_BAR_SEPARATOR}.make)
				end
				l_count := l_count + 1
			end

			-- Then we create tool bar content, extend it to tool bar manager.
			create tool_bar_content.make_with_items ("Tool bar one", l_items)
			manager.tool_bar_manager.contents.extend (tool_bar_content)
			tool_bar_content.set_top ({SD_ENUMERATION}.top)
		ensure
			not_void: tool_bar_content /= Void
		end

feature {NONE} -- Implementation attributes

	manager: SD_DOCKING_MANAGER
			-- Docking manager.

	content_1: SD_CONTENT
			-- Content one.

	content_2: SD_CONTENT

	tool_bar_content: SD_TOOL_BAR_CONTENT;
			-- Tool bar content.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class MAIN_WINDOW


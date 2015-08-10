note
	description: "Summary description for {NODE_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_VIEW_RESPONSE

inherit
	NODE_RESPONSE
		redefine
			make,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_node_api: like node_api)
		do
			create {WSF_NULL_THEME} wsf_theme.make
			Precursor (req, res, a_api, a_node_api)
		end

	initialize
		do
			Precursor
			create {CMS_TO_WSF_THEME} wsf_theme.make (Current, theme)
		end

	wsf_theme: WSF_THEME

feature -- Access

	node: detachable CMS_NODE

	revision: INTEGER_64
			-- If not zero, about history version of the node.

feature -- Element change

	set_node (a_node: like node)
		do
			node := a_node
		end

	set_revision (a_rev: like revision)
		do
			revision := a_rev
		end

feature -- Execution

	process
			-- Computed response message.
		local
			b: detachable STRING_8
			nid: INTEGER_64
			l_node: like node
		do
			l_node := node
			if l_node = Void then
				nid := node_id_path_parameter (request)
				if nid > 0 then
					l_node := node_api.node (nid)
				end
			end
			if l_node /= Void then
				if
					attached node_api.node_type_for (l_node) as l_content_type and then
					attached node_api.node_type_webform_manager (l_content_type) as l_manager
				then
					l_manager.append_html_output_to (l_node, Current)
				end
			elseif revision > 0 then
				set_main_content ("Missing revision node!")
			else
				set_main_content ("Missing node!")
			end
			if revision > 0 then
				add_warning_message ("The revisions let you track differences between multiple versions of a post.")
			end
			if l_node /= Void and revision > 0 then
				set_title ("Revision #" + revision.out + " of " + html_encoded (l_node.title))
			end
		end

end

indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FOLDER_PATH_BOX

inherit
	WIZARD_FOLDER_PATH_BOX_IMP
		rename
			path_label as text_label,
			path_combo as text_combo
		end

	WIZARD_TEXT_BOX
		rename
			setup as text_box_setup,
			text_processor as path_validator
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Initialization

	setup (a_label, a_key: STRING; a_title: like title; a_path_validator: like path_validator) is
			-- Initialize instance.
		require
			non_void_label: a_label /= Void
			non_void_key: a_key /= Void
			non_void_title: a_title /= Void
			non_void_path_validator: a_path_validator /= Void
		do
			text_box_setup (a_label, a_key, a_path_validator)
			title := a_title
			auto_save := True
		ensure
			label_set: text_label.text.is_equal (a_label)
			key_set: key = a_key
			title_set: title = a_title
			auto_save: auto_save
			path_validator_set: path_validator = a_path_validator
		end

feature {NONE} -- Implementation

	on_browse is
			-- Called by `select_actions' of `path_button'.
			-- Browse for file.
		local
			l_dir_dialog: EV_DIRECTORY_DIALOG
			l_dir_name: STRING
		do
			if title /= Void then
				create l_dir_dialog.make_with_title (title)
				l_dir_dialog.show_modal_to_window ((create {EV_UTILITIES}).parent_window (Current))
				l_dir_name := l_dir_dialog.directory
				if not l_dir_name.is_empty then
					text_combo.set_text (l_dir_name)
				end
			end
		end

feature {NONE} -- Private Access

	title: STRING
			-- File open dialog title

end -- class WIZARD_FOLDER_PATH_BOX


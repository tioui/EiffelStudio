indexing
	description: "All resources"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_RESOURCE

inherit
	EMAIL_CONSTANTS

feature -- Access

	header (h: STRING): HEADER is
			-- Retrieve the content of the header 'h'
		do
			Result:= headers.item (h)
		end

	headers: HASH_TABLE [HEADER, STRING]
		-- All information concerning each headers

feature -- Basic operations

	transfer (resource: EMAIL_RESOURCE) is
			-- Transfer the Current email resource to 'resource'.
		require
			resource_exists: resource /= Void
			is_valid_transfer: (resource.can_be_sent and can_send) or
							(resource.can_receive and can_be_received)
			connection_is_initiated: (can_be_sent and resource.is_initiated) or
										(is_initiated and resource.can_be_received)
		deferred
		end

feature -- Status report

	can_receive: BOOLEAN is
			-- Can resource receive?
		deferred
		end

	can_send: BOOLEAN is
			-- Can resource send?
		deferred
		end

	can_be_received: BOOLEAN is
			-- Can resource be received?
		deferred
		end

	can_be_sent: BOOLEAN is
			-- Can resource be sent?
		deferred
		end

	transfer_error: TRANSFER_ERROR is
			-- Transfer error handling
		once
			create Result
		end

	error: BOOLEAN is
			-- Is there an error?
		do
			Result:= transfer_error.transfer_error
		end

			-- Error during the transfer?

--	transfer_error_message: STRING
			-- Error message.

	is_header_valid: BOOLEAN is
		-- Is the email resource's header valid?
		do
		end

	is_initiated: BOOLEAN
		-- Has the connection has been initiated?

feature -- Status setting

	enable_transfer_error is
			-- Enable transfer error.
		do
			transfer_error.enable_transfer_error
		end

	disable_transfer_error is
			-- Disable transfer error.	
		do
			transfer_error.disable_transfer_error
		end

	set_transfer_error_message (s: STRING) is
			-- Set transfer error message to 's'.
		do
			transfer_error.set_transfer_error_message (s)
		end

	enable_initiated is
			-- Set is_initiated.
		do
			is_initiated:= True
		end

	disable_initiated is
			-- Unset is_initiated.
		do
			is_initiated:= False
		end

end -- class EMAIL_RESOURCE

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


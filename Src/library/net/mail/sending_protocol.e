indexing
	description: "Objects that handle the sending of data"
	author: "david"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	SENDING_PROTOCOL

inherit
	EMAIL_PROTOCOL

feature -- Initialization

	transfer is
			-- Transfer any message.
		deferred
		end

end -- class SENDING_PROTOCOL

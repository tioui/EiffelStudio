class S_GENERIC_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE}

    make (s: STRING; t: like constraint_type) is
            -- Set name to `s' and set
            -- type to `t'.
		require
			valid_s: s /= Void;
			valid_t: t /= Void implies t.is_valid
        do
            name := s;
            constraint_type := t
        ensure
            name_set: name = s;
            type_is_set: t = constraint_type
        end;

feature

	constraint_type: S_TYPE_INFO

	name: STRING

end



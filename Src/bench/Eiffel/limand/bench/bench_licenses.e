class SHARED_BENCH_LICENSES

inherit
	SHARED_WORKBENCH

	SHARED_ERROR_HANDLER

	COMPILER_EXPORTER

	EXCEPTIONS
		rename
			raise as raise_exception
		end

feature

	license: LICENSE is
		once
			Result := new_license
		end;

	discard_license is
		do
			license.discard
		end

feature {NONE}

	new_license: LICENSE is
		do
			create {BENCH_LICENSE} Result.make
			Result.set_version (4.0);
			Result.set_application_name ("eiffelstudio")
			licenses.put (Result, "eiffelstudio")
		end

	concurrency_license: LICENSE is
			-- License for Concrrent Eiffel
		once
			create {CONCURRENCY_LICENSE} Result.make
			licenses.put (Result, Result.application_name)
		end

	check_license, init_license: BOOLEAN is
			-- Initialization of the $EiffelGraphicalCompiler$ license
		do
			license.get_license
			Result := license.licensed
		end

	discard_licenses is
		do
			from
				licenses.start
			until
				licenses.after
			loop
				licenses.item_for_iteration.discard
				licenses.forth
			end
		end

	lic_die (i: INTEGER) is
		do
			discard_licenses
			die (i)
		end

	has_limited_license: BOOLEAN is
			-- Is a license going to expire in less than 30 days?
		local
			ht: like licenses
			l: LICENSE
		do
			from
				ht := licenses
				ht.start
			until
				Result or else ht.after
			loop
				l := ht.item_for_iteration
				Result := not l.is_unlimited and then
					l.time_left < 60
				ht.forth
			end
		end

	expiration_message: STRING is
			-- Expiration message (one license will expire in less than
			-- 30 days.
		require
			has_limited_license: has_limited_license
		local
			ht: like licenses
			l: LICENSE
		do
			create Result.make (20)
			from
				ht := licenses
				ht.start
			until
				ht.after
			loop
				l := ht.item_for_iteration
				Result.append ("Your ")
				Result.append (l.application_name)
				Result.append (" license will expire in ")
				Result.append_integer (l.time_left)
				Result.append (" days.%N")
				ht.forth
			end
		end

	check_precompiled_licenses is
			-- Check the precompiled licenses
		local
			precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
			r: REMOTE_PROJECT_DIRECTORY
			l: LIBRARY_LICENSE
			precomp_name: STRING
			error: NO_LICENSE
		do
			precomp_dirs := workbench.precompiled_directories
			from
				precomp_dirs.start
			until
				precomp_dirs.after
			loop
				r := precomp_dirs.item_for_iteration

				debug ("LIMAN")
					io.error.put_string ("Precompilation ");
					if r.system_name /= Void then
						io.error.put_string (r.system_name)
					else
						io.error.put_string ("Void system name!!!!")
					end
					if r.licensed then
						io.error.put_string (" is licensed%N")
					else
						io.error.put_string (" is not licensed%N")
					end
				end

				if r.licensed then
					precomp_name := r.system_name
					l ?= licenses.item (precomp_name)
					if l = Void then
debug ("LIMAN")
	io.error.put_string ("Creating new license%N")
end
						create l.make
						l.set_library_name (precomp_name)
						l.get_license
						if l.licensed then
debug ("LIMAN")
	io.error.put_string ("License valid: inserting into hash table%N")
end
							licenses.put (l, precomp_name)
						else
debug ("LIMAN")
	io.error.put_string ("Cannot get initial license%N")
end
							create error
							error.set_application_name (l.library_name)
							Error_handler.insert_error (error)
						end
					elseif not l.alive then
debug ("LIMAN")
	io.error.put_string ("Cannot get initial license%N")
end
						create error
						error.set_application_name (l.library_name)
						Error_handler.insert_error (error)
					else
debug ("LIMAN")
	io.error.put_string ("License is still valid%N")
end
					end
				end
				precomp_dirs.forth
			end
			Error_handler.checksum
		end

feature {NONE} -- Implementation

	licenses: HASH_TABLE [LICENSE, STRING] is
			-- Licenses for the application
		Once
			create Result.make (5)
		end

end

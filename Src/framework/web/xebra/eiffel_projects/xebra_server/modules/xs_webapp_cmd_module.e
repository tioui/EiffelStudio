note
	description: "[
		A server module that reads commands on a socket.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_CMD_MODULE

inherit
	XC_SERVER_MODULE
		rename
			make as base_make
		end
	THREAD
	XS_SHARED_SERVER_CONFIG
	XS_SHARED_SERVER_OUTPUTTER

create
	make

feature -- Initialization

	make (a_main_server: like main_server; a_name: STRING)
			-- Initializes current
		require
			a_main_server_attached: a_main_server /= Void
			a_name_attached: a_name /= Void
		do
			base_make (a_name)
			main_server := a_main_server
 		ensure
			main_server_set: equal (a_main_server, main_server)
			name_set: equal (name, a_name)
		end

feature -- Inherited Features

	execute
			-- <Precursor>
		local
			l_command_response: XC_COMMAND_RESPONSE
			l_cmd_socket: detachable NETWORK_STREAM_SOCKET

		do
			stop := False
			launched := True
			running := True

			create l_cmd_socket.make_server_by_port ({XU_CONSTANTS}.Cmd_server_port)

			if not l_cmd_socket.is_bound then
				o.eprint ("Socket could not be bound on port " + {XU_CONSTANTS}.Cmd_server_port.out, generating_type)
			else

	 	       	l_cmd_socket.set_accept_timeout ({XU_CONSTANTS}.Socket_accept_timeout)
				from
	                l_cmd_socket.listen ({XU_CONSTANTS}.Max_tcp_clients.as_integer_32)
	                o.dprint("Command Server ready on port " + {XU_CONSTANTS}.Cmd_server_port.out, o.Debug_start_stop_components)
	            until
	            	stop
	            loop
	                l_cmd_socket.accept

	                if not stop then
			            if attached {NETWORK_STREAM_SOCKET} l_cmd_socket.accepted as thread_cmd_socket then
	 					 	o.dprint ("Command connection to Webapp accepted", o.Debug_verbose_subtasks)
	 					 	thread_cmd_socket.read_natural
				            if attached {XC_SERVER_COMMAND} thread_cmd_socket.retrieved as l_command then
				            	o.dprint ("Command retreived...", o.Debug_verbose_subtasks)
								l_command_response := l_command.execute (main_server)

					 	       	if l_command.has_response then
						 	       	o.dprint ("Sending back command_response...", o.Debug_subtasks)
									thread_cmd_socket.put_natural (0)
									thread_cmd_socket.independent_store (l_command_response)
					 	       	end
				 	       	end

				         	thread_cmd_socket.cleanup
				            check
				            	thread_cmd_socket.is_closed
				            end

						end
					end
				end

	            l_cmd_socket.cleanup
	        	check
	        		l_cmd_socket.is_closed
	       		end
	       		o.dprint("Command Server ends.", o.Debug_start_stop_components)
	       		running := False
	       	end
       		rescue
       			o.eprint ("Command Server Module shutdown due to exception. Please relaunch manually.", generating_type)

				if attached {NETWORK_STREAM_SOCKET} l_cmd_socket as ll_cmd_socket then
					ll_cmd_socket.cleanup
					check
		        		ll_cmd_socket.is_closed
		       		end
				end

				stop := True
				running := False
       	end

feature -- Access

	stop: BOOLEAN
			-- Set true to stop accept loop

feature {NONE} -- Access

	main_server: XC_SERVER_INTERFACE

feature -- Status setting

	shutdown
			-- Stops the thread
		do
			stop := True
		end

invariant
	main_server_attached: main_server /= Void
end


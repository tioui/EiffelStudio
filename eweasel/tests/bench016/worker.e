note
	description: "A worker processor that repeatedly executes tasks from a queue."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	WORKER

inherit
	HELPER

create
	make

feature {NONE} -- Initialization

	make (a_queue: separate TASK_QUEUE; a_specialization: INTEGER)
			-- Initialization for `Current'.
		do
			queue := a_queue
			specialization := a_specialization
		end

feature -- Access

	queue: separate TASK_QUEUE
			-- The queue with tasks to be executed.

feature -- Status report

	is_specialized_for (a_job: INTEGER): BOOLEAN
			-- Can `Current' handle the matrix operation `a_job'?
		do
				-- Each worker gets two specializations to avoid some waiting.
			Result := specialization = a_job or ((specialization+1) \\ max_task_number) = a_job

		end

feature -- Basic operations

	live
			-- Execute tasks until the queue is empty.
		local
			task: detachable separate TASK
		do
			from
				task := dequeue (queue)
			until
				task = Void
			loop
				separate
					task as l_task
				do
					execute_task (l_task.task_number, l_task.left_matrix, l_task.right_matrix)
				end
				enqueue (queue, task)
				task := dequeue (queue)
			end
		rescue
			print ("Error: In rescue.%N")
		end

feature {NONE} -- Implementation

	specialization: INTEGER
			-- The type of matrix operations this worker can execute.

	dequeue (a_queue: like queue): detachable separate TASK
			-- Get a new item from the task queue.
			-- A return type of Void means that the worker should terminate.
		require
			can_handle: a_queue.is_stopped or (not a_queue.is_empty and then is_specialized_for (a_queue.next_task_number))
		do
			if not a_queue.is_stopped then
				Result := a_queue.item
				a_queue.remove
			else
				if not a_queue.is_empty then
					print ("Error: Queue still has elements but signalled stop.%N")
				end
			end
		end

	enqueue (a_queue: like queue; a_task: separate TASK)
			-- Put the task back into the queue, or remove it completely if it's finished.
		do
			if a_task.remaining_operations > 0 then
				a_task.generate_subtask
				a_queue.extend (a_task)
			else
				a_task.validate
				a_queue.decrement_task_count
			end
		end

end

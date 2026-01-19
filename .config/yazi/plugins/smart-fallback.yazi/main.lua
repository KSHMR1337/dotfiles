local M = {}

function M:peek(job)
	-- Run file command first
	local child, code = Command("file")
		:arg("--brief")
		:arg(tostring(job.file.url))
		:stdout(Command.PIPED)
		:spawn()

	if not child then
		return
	end

	local limit = job.area.h
	local i, lines = 0, {}
	repeat
		local next, event = child:read_line()
		if event ~= 0 then
			break
		end

		i = i + 1
		if i > job.skip then
			lines[#lines + 1] = next
		end
	until i >= job.skip + limit

	child:start_kill()

	-- Check if output starts with "data"
	local output = lines[1] or ""
	if output:match("^data") then
		return self:show_hexyl(job)
	end

	-- Show file output
	if job.skip > 0 and i < job.skip + limit then
		ya.emit("peek", { math.max(0, i - limit), only_if = job.file.url, upper_bound = true })
	else
		ya.preview_widget(job, ui.Text(lines):area(job.area))
	end
end

function M:show_hexyl(job)
	local child = Command("hexyl")
		:arg("--border=none")
		:arg("--color=always")
		:arg(string.format("--terminal-width=%d", job.area.w))
		:arg(tostring(job.file.url))
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()

	if not child then
		return
	end

	local limit = job.area.h
	local i, lines = 0, {}
	repeat
		local next, event = child:read_line()
		if event ~= 0 then
			break
		end

		i = i + 1
		if i > job.skip then
			lines[#lines + 1] = next
		end
	until i >= job.skip + limit

	child:start_kill()
	if job.skip > 0 and i < job.skip + limit then
		ya.emit("peek", { math.max(0, i - limit), only_if = job.file.url, upper_bound = true })
	else
		-- Use ui.Text.parse to handle ANSI colors
		local text = table.concat(lines, "\n")
		ya.preview_widget(job, ui.Text.parse(text):area(job.area))
	end
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		local step = math.floor(job.units * job.area.h / 10)
		ya.emit("peek", {
			math.max(0, cx.active.preview.skip + step),
			only_if = job.file.url,
		})
	end
end

return M

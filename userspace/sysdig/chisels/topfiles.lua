--[[
Copyright (C) 2013-2014 Draios inc.
 
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

-- Chisel description
description = "Shows the top files in terms of disk usage.";
short_description = "top files by total bytes";
category = "IO";

-- Chisel argument list
args = {}

-- The number of items to show
TOP_NUMBER = 10

require "common"

files = {}

-- Initialization callback
function on_init()
	-- Request the fields
	fbytes = chisel.request_field("evt.rawarg.res")
	ffname = chisel.request_field("fd.name")
	ftime = chisel.request_field("evt.time.s")

	-- set the filter
	chisel.set_filter("evt.is_io=true and fd.type=file")
	
	return true
end

-- Event parsing callback
function on_event()
	bytes = evt.field(fbytes)

	if bytes ~= nil and bytes > 0 then
		fname = evt.field(ffname)

		if fname ~= nil then
			entryval = files[fname]
			
			if entryval == nil then
				files[fname] = bytes
			else
				files[fname] = files[fname] + bytes
			end
		end
	end

	return true
end

-- Interval callback, emits the ourput
function on_capture_end()
	etime = evt.field(ftime)
	sorted_files = pairs_top_by_val(files, TOP_NUMBER, function(t,a,b) return t[b] < t[a] end)

	for k,v in sorted_files do
		print(extend_string(format_bytes(v), 10) .. k)
	end
	
	files = {}
	return true
end

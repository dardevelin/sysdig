-- Chisel description
description = "print the standard error of any process on screen. Combine this script with a filter to limit the output to a specific process or pid.";
short_description = "print stderr";
category = "IO";

args = {}

-- Initialization callback
function on_init()
	-- Request the fileds that we need
	fbuf = chisel.request_field("evt.rawarg.data")

	-- increase the snaplen so we capture more of the conversation 
	sysdig.set_snaplen(2000)

	-- set the filter
	chisel.set_filter("fd.num=2 and evt.is_io=true")
	
	return true
end

-- Event parsing callback
function on_event()
	buf = evt.field(fbuf)
	
	if buf ~= nil then
		print(buf)
	end
	
	return true
end

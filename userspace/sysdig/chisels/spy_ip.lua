-- Chisel description
description = "shows the network payloads exchanged with an IP endpoint";
short_description = "connection spy";
category = "net";

-- Chisel argument list
args = 
{
	{
		name = "host_ip", 
		description = "the remote host IP address", 
		argtype = "ipv4"
	},
}

-- Argument notification callback
function on_set_arg(name, val)
	addr = val

	return true
end

-- Initialization callback
function on_init()
	-- Request the fileds that we need
	fdata = chisel.request_field("evt.arg.data")
	fisread = chisel.request_field("evt.is_io_read")

	-- increase the snaplen so we capture more of the conversation 
	sysdig.set_snaplen(1000)

	-- set the filter
	chisel.set_filter("evt.is_io=true and fd.type=ipv4 and fd.ip=" .. addr)
	
	return true
end

DIR_READ = 1
DIR_WRITE = 2

direction = nil

-- Event parsing callback
function on_event()
	data = evt.field(fdata)
	
	if data ~= nil then
		isread = evt.field(fisread)	
		
		if isread and direction ~= DIR_READ then
			print("\nREAD---------------------------------------\n")
			direction = DIR_READ
		elseif not isread and direction ~= DIR_WRITE then
			print("\nWRITE--------------------------------------\n")
			direction = DIR_WRITE
		end

		print(data)
	end

	return true
end

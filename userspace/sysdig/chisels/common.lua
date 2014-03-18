--[[ 
A bunch of functions that are helpful in multiple scripts
]]--

--[[ 
Extends a string to newlen with spaces
]]--
function extend_string(s, newlen)
	ccs = "                                                                                                        "
	s = s .. string.sub(ccs, 0, newlen - string.len(s))
	return s
end

--[[ 
convert a number into a byte representation.
E.g. 1230 becomes 1.23K
]]--
function format_bytes(val)
	if val > (1024 * 1024 * 1024) then
		return string.format("%.2fP", val / (1024 * 1024 * 1024))
	elseif val > (1024 * 1024 * 1024) then
		return string.format("%.2fT", val / (1024 * 1024 * 1024))
	elseif val > (1024 * 1024 * 1024) then
		return string.format("%.2fG", val / (1024 * 1024 * 1024))
	elseif val > (1024 * 1024) then
		return string.format("%.2fM", val / (1024 * 1024))
	elseif val > 1024 then
		return string.format("%.2fKB", val / (1024))
	else
		return string.format("%dB", val)
	end
end

--[[ 
convert a nanosecond time interval into a s.ns representation.
E.g. 1100000000 becomes 1.1s
]]--
ONE_S_IN_NS=1000000000
ONE_MS_IN_NS=1000000
ONE_US_IN_NS=1000

function format_time_interval(val)
	if val >= (ONE_S_IN_NS) then
		return string.format("%u.%02us", val / ONE_S_IN_NS, (val % ONE_S_IN_NS) / 10000000)
	elseif val >= (ONE_S_IN_NS / 100) then
		return string.format("%ums", val / (ONE_S_IN_NS / 1000))
	elseif val >= (ONE_S_IN_NS / 1000) then
		return string.format("%u.%02ums", val / (ONE_S_IN_NS / 1000), (val % ONE_MS_IN_NS) / 10000)
	elseif val >= (ONE_S_IN_NS / 100000) then
		return string.format("%uus", val / (ONE_S_IN_NS / 1000000))
	elseif val >= (ONE_S_IN_NS / 1000000) then
		return string.format("%u.%02uus", val / (ONE_S_IN_NS / 1000000), (val % ONE_US_IN_NS) / 10)
	else
		return string.format("%uns", val)
	end
end

--[[ 
extract the top num entries from the table t, after sorting them based on the entry value using the function order()
]]--
function pairs_top_by_val(t, num, order)
	local keys = {}
	for k in pairs(t) do keys[#keys+1] = k end

	table.sort(keys, function(a,b) return order(t, a, b) end)

	local i = 0
	return function()
		i = i + 1
		if (num == 0 or i <= num) and keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end

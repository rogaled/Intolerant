--!strict

local Handler = {}
Handler.__index = Handler

function Handler.new()
	local self = setmetatable({}, Handler)
	return self
end

return Handler

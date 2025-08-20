--!strict
local HttpService = game:GetService("HttpService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedModules = ReplicatedStorage.Modules
local Components = require(SharedModules.Components)

local Types = SharedModules.Types
local CombatTypes = require(Types.CombatTypes)

type Context = CombatTypes.Context

local function Transmute(Context: Context, Guid: string, Value: any) --returns a mutated patch
	local Id, World = Context.Id, Context.World

	local Transmution: Components.Stun_Type = World:get(Id, Components.Stun)
	Transmution[Guid] = Value

	return Transmution
end

local Handler = {}

function Handler.AddStun(Context: Context, Payload: { Duration: number, SourceId: number? })
	local Duration, SourceId = Payload.Duration, Payload.SourceId

	local Guid = HttpService:GenerateGUID(false)

	local StunEntryPayload: Components.Stun_Entry_Type = {
		Guid = Guid,
		Duration = Duration,
		DeltaTime = 0,
		SourceId = SourceId,
	}

	local StunPatch: Components.Stun_Type = Transmute(Context, Guid, StunEntryPayload)

	Components.Stun:patch(StunPatch)

	return Guid
end

function Handler.RemoveStun(Context: Context, Guid: string)
	local StunPatch: Components.Stun_Type = Transmute(Context, Guid, nil)

	Components.Stun:patch(StunPatch)
end

function Handler.IsStunned(Context: Context)
	local Id, World = Context.Id, Context.World

	local StunComponent: Components.Stun_Type = World:get(Id, Components.Stun)

	for _, Entry: Components.Stun_Entry_Type in StunComponent do
		if Entry.Duration > Entry.DeltaTime then
			return true
		end
	end

	return false
end

return Handler

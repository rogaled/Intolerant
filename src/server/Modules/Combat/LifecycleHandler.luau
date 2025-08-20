--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedModules = ReplicatedStorage.Modules
local _Components = require(SharedModules.Components)

local Packages = SharedModules.Packages
local Matter = require(Packages.Matter)

local Types = SharedModules.Types
local CombatTypes = require(Types.CombatTypes)

type Context = CombatTypes.Context
type Payload = {}

local Handler = {}

function Handler.Spawn(World: Matter.World, Payload: Payload)
	local Id = World:spawn(table.unpack(Payload))

	print("Created an entity with the id:", Id)

	return Id
end
return Handler

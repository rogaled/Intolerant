--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedModules = ReplicatedStorage.Modules
local Components = require(SharedModules.Components)

local Types = SharedModules.Types
local CombatTypes = require(Types.CombatTypes)

type Context = CombatTypes.Context

local function CalculateDamage(Payload: { Amount: number, Defense: number, Penetration: number? })
	local Amount: number = Payload.Amount
	local Defense: number, Penetration: number = Payload.Defense, Payload.Penetration or 0

	Defense = math.clamp(Defense, 0, 1)
	Penetration = math.clamp(Penetration, 0, 1)

	local EffectiveDefense = Defense * (1 - Penetration)

	return Amount * (1 - EffectiveDefense)
end

local Handler = {}

function Handler.Damage(Context: Context, Payload: { Amount: number, Penetration: number? })
	local Id, World = Context.Id, Context.World

	local DefenseComponent: Components.Defense_Type = World:get(Id, Components.Defense)
	local HealthComponent: Components.Health_Type = World:get(Id, Components.Health)

	local Defense: number = DefenseComponent.Percentage
	local CurrentHealth: number = HealthComponent.Current

	local Damage: number = CalculateDamage({
		Amount = Payload.Amount,
		Defense = Defense,
		Penetration = Payload.Penetration,
	})

	Components.Health:patch(Id, { Current = CurrentHealth - Damage })

	return {
		Dealt = Damage,
		Lethal = Damage >= CurrentHealth,
	}
end

function Handler.Heal(Context: Context, Amount: number)
	local Id, World = Context.Id, Context.World

	local HealthComponent: Components.Health_Type = World:get(Id, Components.Health)
	local CurrentHealth, MaxHealth = HealthComponent.Current, HealthComponent.Max

	local NewHealth = math.clamp(CurrentHealth + Amount, 0, MaxHealth)

	Components.Health:patch(Id, { Current = NewHealth })

	return MaxHealth - NewHealth
end

return Handler

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedModules = ReplicatedStorage.Modules

local Packages = SharedModules.Packages

local Matter = require(Packages.Matter)

--------------------------------

local Defense = require(script.Defense)
export type Defense_Type = typeof(Defense)

local Health = require(script.Health)
export type Health_Type = typeof(Health)

local Stun = require(script.Stun)
export type Stun_Entry_Type = Stun.Entry
export type Stun_Type = Stun.Structure

local Components = {
	Defense = Matter.component("Defense", Defense),
	Health = Matter.component("Health", Health),
	Stun = Matter.component("Stun", Stun),
}
return Components

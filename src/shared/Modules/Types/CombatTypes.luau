local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SharedModules = ReplicatedStorage.Modules

local Packages = SharedModules.Packages

local Matter = require(Packages.Matter)

export type Context = { Id: number, SourceId: number?, World: Matter.World }

return nil

--!strict

local RunService = game:GetService("RunService")

local Camera: Camera = workspace.CurrentCamera
Camera.CameraSubject = nil
Camera.CameraType = Enum.CameraType.Scriptable

local Controller = {}

function Controller:Start()
	self.Connection = RunService.RenderStepped:Connect(function(_DeltaTime) end)
end

return Controller

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
if player:WaitForChild("PlayerGui"):FindFirstChild("CheeseHub") then return end

local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

player.CharacterAdded:Connect(function(c)
	char = c
	hum = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
end)

local ORANGE = Color3.fromRGB(255,153,0)
local DARK = Color3.fromRGB(46,46,46)
local BLACK = Color3.fromRGB(0,0,0)
local WHITE = Color3.new(1,1,1)

local gui = Instance.new("ScreenGui")
gui.Name = "CheeseHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0.55,0,0.6,0)
main.Position = UDim2.new(0.225,0,0.2,0)
main.BackgroundColor3 = ORANGE
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner",main).CornerRadius = UDim.new(0,24)

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,-20,0,60)
titleBar.Position = UDim2.new(0,10,0,10)
titleBar.BackgroundColor3 = DARK
titleBar.BorderSizePixel = 0
titleBar.Parent = main
Instance.new("UICorner",titleBar).CornerRadius = UDim.new(0,20)

local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(1,-160,1,-20)
titleContainer.Position = UDim2.new(0,10,0,10)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = titleBar

local cheese = Instance.new("TextLabel")
cheese.Size = UDim2.new(0,110,1,0)
cheese.BackgroundTransparency = 1
cheese.Text = "Cheese"
cheese.Font = Enum.Font.GothamBold
cheese.TextSize = 26
cheese.TextColor3 = WHITE
cheese.Parent = titleContainer

local hub = Instance.new("TextLabel")
hub.Size = UDim2.new(0,70,0,36)
hub.Position = UDim2.new(0,115,0.5,-18)
hub.BackgroundColor3 = ORANGE
hub.Text = "Hub"
hub.Font = Enum.Font.GothamBold
hub.TextSize = 22
hub.TextColor3 = BLACK
hub.Parent = titleContainer
Instance.new("UICorner",hub).CornerRadius = UDim.new(0,10)

local collapse = Instance.new("TextButton")
collapse.Size = UDim2.new(0,36,0,36)
collapse.Position = UDim2.new(1,-50,0.5,-18)
collapse.Text = "-"
collapse.Font = Enum.Font.GothamBold
collapse.TextSize = 20
collapse.BackgroundColor3 = ORANGE
collapse.TextColor3 = BLACK
collapse.BorderSizePixel = 0
collapse.Parent = titleBar
Instance.new("UICorner",collapse).CornerRadius = UDim.new(1,0)

local holder = Instance.new("ScrollingFrame")
holder.Size = UDim2.new(1,-20,1,-90)
holder.Position = UDim2.new(0,10,0,80)
holder.CanvasSize = UDim2.new(0,0,0,0)
holder.ScrollBarImageColor3 = DARK
holder.BackgroundTransparency = 1
holder.ScrollBarThickness = 6
holder.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,12)
layout.Parent = holder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	holder.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+10)
end)

local collapsed = false
collapse.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	holder.Visible = not collapsed
	main.Size = collapsed and UDim2.new(0.55,0,0,80) or UDim2.new(0.55,0,0.6,0)
	collapse.Text = collapsed and "+" or "-"
end)

local function createButton(name,callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1,0,0,50)
	button.BackgroundColor3 = DARK
	button.TextColor3 = WHITE
	button.Text = name
	button.Font = Enum.Font.Gotham
	button.TextSize = 17
	button.BorderSizePixel = 0
	button.Parent = holder
	Instance.new("UICorner",button).CornerRadius = UDim.new(0,16)
	button.MouseButton1Click:Connect(callback)
end

local function createToggle(name,callback)
	local state = false
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1,0,0,50)
	button.BackgroundColor3 = DARK
	button.TextColor3 = WHITE
	button.Text = name.."  [OFF]"
	button.Font = Enum.Font.Gotham
	button.TextSize = 17
	button.BorderSizePixel = 0
	button.Parent = holder
	Instance.new("UICorner",button).CornerRadius = UDim.new(0,16)
	button.MouseButton1Click:Connect(function()
		state = not state
		button.Text = name..(state and "  [ON]" or "  [OFF]")
		callback(state)
	end)
end

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1,0,0,50)
speedBox.BackgroundColor3 = DARK
speedBox.TextColor3 = WHITE
speedBox.PlaceholderText = "Enter WalkSpeed Value"
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 17
speedBox.BorderSizePixel = 0
speedBox.ClearTextOnFocus = false
speedBox.Parent = holder
Instance.new("UICorner",speedBox).CornerRadius = UDim.new(0,16)

speedBox.FocusLost:Connect(function(enter)
	if enter then
		local value = tonumber(speedBox.Text)
		if value and hum then
			hum.WalkSpeed = value
		end
	end
end)

local infJump = false
createToggle("Infinite Jump",function(e)
	infJump = e
end)

UIS.JumpRequest:Connect(function()
	if infJump then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local flying = false
local bv,bg
createToggle("Fly",function(e)
	flying = e
	if flying then
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1,1,1)*999999
		bv.Parent = hrp
		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(1,1,1)*999999
		bg.Parent = hrp
		hum.PlatformStand = true
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		hum.PlatformStand = false
	end
end)

RunService.RenderStepped:Connect(function()
	if flying and bv and bg then
		local cam = workspace.CurrentCamera
		bg.CFrame = cam.CFrame
		local dir = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += cam.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= cam.CFrame.UpVector end
		bv.Velocity = dir*80
	end
end)

createButton("Equip All Tools",function()
	for _,tool in pairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent = char
		end
	end
end)

createButton("Respawn",function()
	local pos = hrp.CFrame
	hum.Health = 0
	player.CharacterAdded:Wait()
	char = player.Character
	hum = char:WaitForChild("Humanoid")
	hrp = char:WaitForChild("HumanoidRootPart")
	task.wait()
	hrp.CFrame = pos
end)

local tpClick = false

createToggle("(PC ONLY) TP Click",function(e)
	tpClick = e
end)

UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	if tpClick and input.UserInputType == Enum.UserInputType.MouseButton1 then
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then
			local mouse = player:GetMouse()
			if mouse and mouse.Hit then
				hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
			end
		end
	end
end)

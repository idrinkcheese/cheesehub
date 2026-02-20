local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local existing = player:WaitForChild("PlayerGui"):FindFirstChild("CheeseHub")
if existing then existing:Destroy() end

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

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,36,0,36)
close.Position = UDim2.new(1,-95,0.5,-18)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.BackgroundColor3 = Color3.fromRGB(255,80,80)
close.TextColor3 = Color3.new(1,1,1)
close.BorderSizePixel = 0
close.Parent = titleBar
Instance.new("UICorner",close).CornerRadius = UDim.new(1,0)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

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
	collapse.Text = collapsed and "+" or "-"
	local targetSize = collapsed and UDim2.new(0.55,0,0,80) or UDim2.new(0.55,0,0.6,0)
	local tween = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize})
	tween:Play()
	local holderTween = TweenService:Create(holder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = collapsed and 1 or 0})
	holderTween:Play()
	task.delay(0.15, function() holder.Visible = not collapsed end)
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
		if value and hum then hum.WalkSpeed = value end
	end
end)

local infJump = false
createToggle("Infinite Jump",function(e) infJump = e end)
UIS.JumpRequest:Connect(function()
	if infJump then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
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
		if tool:IsA("Tool") then tool.Parent = char end
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
createToggle("(PC ONLY) TP Click",function(e) tpClick = e end)
UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	if tpClick and input.UserInputType == Enum.UserInputType.MouseButton1 then
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then
			local mouse = player:GetMouse()
			if mouse and mouse.Hit then hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0)) end
		end
	end
end)

local dragging = false
local dragStart = Vector2.zero
local startPos = UDim2.new()
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
titleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- TP to Player
local tpBox = Instance.new("TextBox")
tpBox.Size = UDim2.new(1,0,0,50)
tpBox.BackgroundColor3 = DARK
tpBox.TextColor3 = WHITE
tpBox.PlaceholderText = "Enter Player Name"
tpBox.Font = Enum.Font.Gotham
tpBox.TextSize = 17
tpBox.BorderSizePixel = 0
tpBox.ClearTextOnFocus = false
tpBox.Parent = holder
Instance.new("UICorner",tpBox).CornerRadius = UDim.new(0,16)

createButton("TP to Player", function()
	local targetName = tpBox.Text
	local targetPlayer = Players:FindFirstChild(targetName)
	if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		hrp.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
	end
end)

-- TP to All
createButton("TP to All", function()
	local others = {}
	for _,p in pairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			table.insert(others, p)
		end
	end
	spawn(function()
		for _,p in ipairs(others) do
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				hrp.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
				task.wait(1.2)
			end
		end
	end)
end)

-- Super Fast Spin
local spinning = false
createToggle("Spin", function(state) spinning = state end)
RunService.RenderStepped:Connect(function()
	if spinning then
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(30), 0)
	end
end)

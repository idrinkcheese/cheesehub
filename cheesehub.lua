print("PEEPEEPOOPOO")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
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
main.Size = UDim2.new(0.55, 0, 0.6, 0)
main.Position = UDim2.new(0.225, 0, 0.2, 0)
main.BackgroundColor3 = ORANGE
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 24)

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, -20, 0, 60)
titleBar.Position = UDim2.new(0, 10, 0, 10)
titleBar.BackgroundColor3 = DARK
titleBar.BorderSizePixel = 0
titleBar.Parent = main
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 20)

local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(1, -160, 1, -20)
titleContainer.Position = UDim2.new(0, 10, 0, 10)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = titleBar

local cheese = Instance.new("TextLabel")
cheese.Size = UDim2.new(0, 110, 1, 0)
cheese.BackgroundTransparency = 1
cheese.Text = "Cheese"
cheese.Font = Enum.Font.GothamBold
cheese.TextSize = 26
cheese.TextColor3 = WHITE
cheese.Parent = titleContainer

local hub = Instance.new("TextLabel")
hub.Size = UDim2.new(0, 70, 0, 36)
hub.Position = UDim2.new(0, 115, 0.5, -18)
hub.BackgroundColor3 = ORANGE
hub.Text = "Hub"
hub.Font = Enum.Font.GothamBold
hub.TextSize = 22
hub.TextColor3 = BLACK
hub.Parent = titleContainer
Instance.new("UICorner", hub).CornerRadius = UDim.new(0, 10)

local collapse = Instance.new("TextButton")
collapse.Size = UDim2.new(0, 36, 0, 36)
collapse.Position = UDim2.new(1, -50, 0.5, -18)
collapse.Text = "-"
collapse.Font = Enum.Font.GothamBold
collapse.TextSize = 20
collapse.BackgroundColor3 = ORANGE
collapse.TextColor3 = BLACK
collapse.BorderSizePixel = 0
collapse.Parent = titleBar
Instance.new("UICorner", collapse).CornerRadius = UDim.new(1, 0)

local holder = Instance.new("ScrollingFrame")
holder.Size = UDim2.new(1, -20, 1, -90)
holder.Position = UDim2.new(0, 10, 0, 80)
holder.CanvasSize = UDim2.new(0,0,0,0)
holder.ScrollBarImageColor3 = DARK
holder.BackgroundTransparency = 1
holder.Parent = main
holder.AutomaticCanvasSize = Enum.AutomaticSize.None
holder.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 12)
layout.Parent = holder

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	holder.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

local collapsed = false
collapse.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	holder.Visible = not collapsed
	main.Size = collapsed and UDim2.new(0.55,0,0,80) or UDim2.new(0.55,0,0.6,0)
	collapse.Text = collapsed and "+" or "-"
end)

local function createButton(name, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 50)
	button.BackgroundColor3 = DARK
	button.TextColor3 = WHITE
	button.Text = name
	button.Font = Enum.Font.Gotham
	button.TextSize = 17
	button.BorderSizePixel = 0
	button.Parent = holder
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 16)
	button.MouseButton1Click:Connect(callback)
end

local function createToggle(name, callback)
	local state = false
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 50)
	button.BackgroundColor3 = DARK
	button.TextColor3 = WHITE
	button.Text = name .. "  [OFF]"
	button.Font = Enum.Font.Gotham
	button.TextSize = 17
	button.BorderSizePixel = 0
	button.Parent = holder
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 16)
	button.MouseButton1Click:Connect(function()
		state = not state
		button.Text = name .. (state and "  [ON]" or "  [OFF]")
		callback(state)
	end)
end

createToggle("Speed", function(enabled)
	hum.WalkSpeed = enabled and 80 or 16
end)

local infJump = false
createToggle("Infinite Jump", function(enabled)
	infJump = enabled
end)

UIS.JumpRequest:Connect(function()
	if infJump then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local flying = false
local bv, bg
local speed = 80

createToggle("Fly", function(enabled)
	flying = enabled
	if flying then
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1,1,1)*999999
		bv.Parent = hrp
		bg = Instance.new("BodyGyro")
		bg.MaxTorque = Vector3.new(1,1,1)*999999
		bg.CFrame = hrp.CFrame
		bg.Parent = hrp
		hum.PlatformStand = true
	else
		if bv then bv:Destroy() end
		if bg then bg:Destroy() end
		hum.PlatformStand = false
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if flying and bv and bg then
		local cam = workspace.CurrentCamera
		bg.CFrame = cam.CFrame
		local moveDir = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir += cam.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= cam.CFrame.UpVector end
		bv.Velocity = moveDir * speed
	end
end)

createButton("Equip All Tools", function()
	for _,tool in pairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent = char
		end
	end
end)

createButton("TP To All", function()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			hrp.CFrame = plr.Character.HumanoidRootPart.CFrame
			task.wait(0.3)
		end
	end
end)

local tpBox = Instance.new("TextBox")
tpBox.Size = UDim2.new(1,0,0,50)
tpBox.BackgroundColor3 = DARK
tpBox.TextColor3 = WHITE
tpBox.PlaceholderText = "Enter a Username to Teleport"
tpBox.Font = Enum.Font.Gotham
tpBox.TextSize = 17
tpBox.BorderSizePixel = 0
tpBox.Parent = holder
Instance.new("UICorner", tpBox).CornerRadius = UDim.new(0,16)

tpBox.FocusLost:Connect(function(enter)
	if enter then
		local target = Players:FindFirstChild(tpBox.Text)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			hrp.CFrame = target.Character.HumanoidRootPart.CFrame
		end
	end
end)

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0, 110, 0, 36)
discordBtn.Position = UDim2.new(1, -200, 0.5, -18)
discordBtn.Text = "Discord"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 14
discordBtn.BackgroundColor3 = ORANGE
discordBtn.TextColor3 = BLACK
discordBtn.BorderSizePixel = 0
discordBtn.Parent = titleBar
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 12)

setclipboard = setclipboard or toclipboard or set_clipboard

discordBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("discord.gg/NyeQD2zcHX")
	end
	local popup = Instance.new("TextLabel")
	popup.Size = UDim2.new(0,300,0,60)
	popup.Position = UDim2.new(0.5,-150,0.5,-30)
	popup.BackgroundColor3 = DARK
	popup.TextColor3 = WHITE
	popup.Text = "Copied to Clipboard!"
	popup.Font = Enum.Font.GothamBold
	popup.TextSize = 20
	popup.Parent = gui
	Instance.new("UICorner", popup).CornerRadius = UDim.new(0,20)
	task.wait(1.2)
	popup:Destroy()
end)

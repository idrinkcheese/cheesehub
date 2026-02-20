-- yo what u doin here?
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

local gui = Instance.new("ScreenGui")
gui.Name = "CheeseHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0.55, 0, 0.6, 0)
main.Position = UDim2.new(0.225, 0, 0.2, 0)
main.BackgroundColor3 = ORANGE
main.BorderSizePixel = 0
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
cheese.TextColor3 = BLACK
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

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 120, 1, 0)
version.Position = UDim2.new(0, 190, 0, 0)
version.BackgroundTransparency = 1
version.Text = "v0.0.1"
version.Font = Enum.Font.Gotham
version.TextSize = 18
version.TextColor3 = BLACK
version.Parent = titleContainer

local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0, 110, 0, 36)
discordBtn.Position = UDim2.new(1, -240, 0.5, -18)
discordBtn.Text = "Discord"
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextSize = 14
discordBtn.BackgroundColor3 = ORANGE
discordBtn.TextColor3 = BLACK
discordBtn.BorderSizePixel = 0
discordBtn.Parent = titleBar
Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 12)

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 36, 0, 36)
close.Position = UDim2.new(1, -50, 0.5, -18)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 16
close.BackgroundColor3 = ORANGE
close.TextColor3 = BLACK
close.BorderSizePixel = 0
close.Parent = titleBar
Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)

setclipboard = setclipboard or toclipboard or set_clipboard
discordBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("discord.gg/NyeQD2zcHX")
	end
end)

close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

local holder = Instance.new("Frame")
holder.Size = UDim2.new(1, -20, 1, -90)
holder.Position = UDim2.new(0, 10, 0, 80)
holder.BackgroundTransparency = 1
holder.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 12)
layout.Parent = holder

local function createButton(name, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 50)
	button.BackgroundColor3 = DARK
	button.TextColor3 = Color3.new(1,1,1)
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
	button.TextColor3 = Color3.new(1,1,1)
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
local bv

createToggle("Fly", function(enabled)
	flying = enabled
	if flying then
		bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1,1,1)*999999
		bv.Velocity = Vector3.new(0,0,0)
		bv.Parent = hrp
		hum.PlatformStand = true
	else
		if bv then bv:Destroy() end
		hum.PlatformStand = false
	end
end)

UIS.InputChanged:Connect(function()
	if flying and bv then
		bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
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
tpBox.TextColor3 = Color3.new(1,1,1)
tpBox.PlaceholderText = "Teleport to player..."
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

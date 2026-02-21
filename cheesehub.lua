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

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1,0,0,45)
searchBox.BackgroundColor3 = DARK
searchBox.TextColor3 = WHITE
searchBox.PlaceholderText = "Search..."
searchBox.Font = Enum.Font.Gotham
searchBox.TextSize = 16
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.Parent = holder
Instance.new("UICorner",searchBox).CornerRadius = UDim.new(0,16)

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

local function tpToPlayer()
	local inputName = string.lower(tpBox.Text)
	if inputName == "" then return end
	
	local targetPlayer = nil
	
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= player and string.find(string.lower(plr.Name), inputName, 1, true) then
			targetPlayer = plr
			break
		end
	end
	
	if not targetPlayer then
		warn("Player not found")
		return
	end
	
	local targetChar = targetPlayer.Character or targetPlayer.CharacterAdded:Wait()
	local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
	if not targetHRP then
		warn("Target HRP missing")
		return
	end
	
	if not player.Character then return end
	hrp = player.Character:WaitForChild("HumanoidRootPart")
	
	hrp.CFrame = targetHRP.CFrame + Vector3.new(0,3,0)
end


tpBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		tpToPlayer()
	end
end)

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

local spinning = false
createToggle("Spin", function(state) spinning = state end)
RunService.RenderStepped:Connect(function()
	if spinning then
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(30), 0)
	end
end)

local Camera = workspace.CurrentCamera
local ESPEnabled = false
local ESPObjects = {}

local function clearESP()
	for _,v in pairs(ESPObjects) do
		if v.highlight then v.highlight:Destroy() end
		if v.billboard then v.billboard:Destroy() end
		if v.tracer then v.tracer:Destroy() end
	end
	table.clear(ESPObjects)
end

local function createESP(plr)
	if plr == player then return end
	if not plr.Character then return end
	
	local char = plr.Character
	local hrpTarget = char:FindFirstChild("HumanoidRootPart")
	local humTarget = char:FindFirstChildOfClass("Humanoid")
	if not hrpTarget or not humTarget then return end

	local highlight = Instance.new("Highlight")
	highlight.FillTransparency = 1
	highlight.OutlineColor = Color3.fromRGB(255,153,0)
	highlight.OutlineTransparency = 0
	highlight.Parent = char

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0,200,0,50)
	billboard.AlwaysOnTop = true
	billboard.StudsOffset = Vector3.new(0,3,0)
	billboard.Parent = hrpTarget

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1,1,1)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = billboard

	local tracer = Instance.new("Frame")
	tracer.AnchorPoint = Vector2.new(0.5,0)
	tracer.BackgroundColor3 = ORANGE
	tracer.BorderSizePixel = 0
	tracer.Parent = gui

	ESPObjects[plr] = {
		highlight = highlight,
		billboard = billboard,
		label = label,
		tracer = tracer,
		hum = humTarget,
		hrp = hrpTarget
	}
end

local function setupPlayer(plr)
	plr.CharacterAdded:Connect(function()
		task.wait(1)
		if ESPEnabled then
			createESP(plr)
		end
	end)
	if plr.Character and ESPEnabled then
		createESP(plr)
	end
end

for _,plr in pairs(Players:GetPlayers()) do
	if plr ~= player then
		setupPlayer(plr)
	end
end

Players.PlayerAdded:Connect(setupPlayer)

RunService.RenderStepped:Connect(function()
	if not ESPEnabled then return end
	
	for plr,data in pairs(ESPObjects) do
		if not plr.Parent or not data.hrp or not data.hrp.Parent then
			continue
		end
		
		local pos, onScreen = Camera:WorldToViewportPoint(data.hrp.Position)
		
		local distance = math.floor((hrp.Position - data.hrp.Position).Magnitude)
		local health = math.floor(data.hum.Health)
		data.label.Text = plr.Name.." | "..health.." HP | "..distance.."m"
		
		if onScreen then
			data.tracer.Visible = true
			local bottom = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
			local target = Vector2.new(pos.X,pos.Y)
			local magnitude = (target - bottom).Magnitude
			
			data.tracer.Size = UDim2.new(0,2,0,magnitude)
			data.tracer.Position = UDim2.new(0,bottom.X,0,bottom.Y)
			data.tracer.Rotation = math.deg(math.atan2(target.Y-bottom.Y,target.X-bottom.X)) + 90
		else
			data.tracer.Visible = false
		end
	end
end)

createToggle("ESP", function(state)
	ESPEnabled = state
	
	if not state then
		clearESP()
	else
		for _,plr in pairs(Players:GetPlayers()) do
			if plr ~= player then
				createESP(plr)
			end
		end
	end
end)

local xrayEnabled = false
local XRayParts = {}

local function setPartTransparency(part, transparency)
	if not part:IsA("BasePart") then return end
	if part:IsDescendantOf(player.Character) then return end
	if part.Name == "HumanoidRootPart" then return end
	
	if not XRayParts[part] then
		XRayParts[part] = part.LocalTransparencyModifier
	end
	
	part.LocalTransparencyModifier = transparency
end

local function clearXRay()
	for part, original in pairs(XRayParts) do
		if part and part.Parent then
			part.LocalTransparencyModifier = original
		end
	end
	table.clear(XRayParts)
end

createToggle("X-Ray", function(state)
	xrayEnabled = state
	
	if not state then
		clearXRay()
		return
	end
	
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			setPartTransparency(obj, 0.7)
		end
	end
end)

workspace.DescendantAdded:Connect(function(obj)
	if xrayEnabled and obj:IsA("BasePart") then
		setPartTransparency(obj, 0.7)
	end
end)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

createButton("Tools", function()
	for _, tool in pairs(ReplicatedStorage:GetDescendants()) do
		if tool:IsA("Tool") then
			tool:Clone().Parent = player.Backpack
		end
	end
	
	for _, tool in pairs(Lighting:GetDescendants()) do
		if tool:IsA("Tool") then
			tool:Clone().Parent = player.Backpack
		end
	end
end)

local Lighting = game:GetService("Lighting")

local brightEnabled = false
local originalLighting = {}

createToggle("Bright", function(state)
	brightEnabled = state
	
	if state then
		originalLighting.Brightness = Lighting.Brightness
		originalLighting.ClockTime = Lighting.ClockTime
		originalLighting.FogEnd = Lighting.FogEnd
		originalLighting.GlobalShadows = Lighting.GlobalShadows
		originalLighting.Ambient = Lighting.Ambient
		originalLighting.OutdoorAmbient = Lighting.OutdoorAmbient
		
		Lighting.Brightness = 5
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.fromRGB(255,255,255)
		Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
		
	else
		for property, value in pairs(originalLighting) do
			if Lighting[property] ~= nil then
				Lighting[property] = value
			end
		end
	end
end)

createToggle("Noclip", function(state)
	noclipEnabled = state
	
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end
	
	if state then
		noclipConnection = RunService.Stepped:Connect(function()
			if not char then return end
			
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			if not humanoid then return end
			
			local isGrounded = humanoid.FloorMaterial ~= Enum.Material.Air
			
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					if isGrounded then
						part.CanCollide = true
					else
						part.CanCollide = false
					end
				end
			end
		end)
	else
		if char then
			for _, part in pairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
		end
	end
end)

local function updateSearch()
	local query = string.lower(searchBox.Text)

	for _, child in pairs(holder:GetChildren()) do
		if (child:IsA("TextButton") or child:IsA("TextBox")) and child ~= searchBox then
			
			local text = ""

			if child:IsA("TextButton") then
				text = string.lower(string.gsub(child.Text, "%s%[.*%]", ""))
			elseif child:IsA("TextBox") then
				text = string.lower(child.PlaceholderText or "")
			end

			child.Visible = (query == "" or string.find(text, query, 1, true))
		end
	end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(updateSearch)

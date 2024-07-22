-- INIT
script.Name = "Plugin"

-- GET SERVICES
local _ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")
local TweenService = game:GetService("TweenService")

-- Main Variables
local ver = "1.0a"

local urlTmpl = "https://assetdelivery.roblox.com/v1/asset/?id="
local urlBtnDB = false
local urlBtnCD = 3
local assetIdsGet = false

local validProps = {
	"ActivatedCursorIcon",
	"AnimationId",
	"AssetId",
	"BottomImage",
	"ColorMap",
	"CursorIcon",
	"Graphic",
	"HoverImage",
	"Image",
	"MeshId",
	"MetalnessMap",
	"MidImage",
	"MoonTextureId",
	"NormalMap",
	"PantsTemplate",
	"RoughnessMap",
	"ShirtTemplate",
	"SkyboxBk",
	"SkyboxDn",
	"SkyboxFt",
	"SkyboxLf",
	"SkyboxRt",
	"SkyboxUp",
	"SoundId",
	"SunTextureId",
	"Texture",
	"TextureID",
	"TextureId",
	"TopImage",
	"Video",
}

local idPatterns = {
	"?id=",
	"id://",
	"asset://",
}

-- Tween Informations
local lblTweens = {
	TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
}

local lblInPositions = {
	UDim2.new(0.403,0,0.337,0),
	UDim2.new(0.409,0,0.3,0)
}

local lblOutPositions = {
	UDim2.new(0.403,0,1.05,0),
	UDim2.new(0.409,0,-0.25,0)
}

-- Toolbar & Toggle Button
local toolbar = plugin:CreateToolbar("Asset Downloader")
local initBtn = toolbar:CreateButton("Asset Downloader","Get AssetDelivery URLs of assets (v"..ver..")","rbxassetid://18421300700")
initBtn.ClickableWhenViewportHidden = true

-- DockWidget Intializer
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float, -- initilized in floating panel
	false, -- Widget will be intially enabled
	false, -- Don't override the previous enabled state
	518, -- Default width of the floating window
	341, -- Default height of the floating window
	518, -- Minimum width of the floating window
	341 -- Minimum height of the floating window
)

-- Create new widget UI
local mainWidget = plugin:CreateDockWidgetPluginGui("downloaderWidget",widgetInfo)
mainWidget.Title = "Asset Downloader v"..ver -- Widget title

-- MAIN UI INIT
-- Generated by GUI to Lua v0.7 by @LwgoDev

local UI = {}

-- // StarterGui.assetDownloaderSketch.Frame \\ --
UI["1"] = Instance.new("Frame", mainWidget)
UI["1"]["AnchorPoint"] = Vector2.new(0.5,0.5)
UI["1"]["BorderSizePixel"] = 0
UI["1"]["BackgroundColor3"] = Color3.fromRGB(77, 77, 77)
UI["1"]["Size"] = UDim2.new(1, 0, 1, 0)
UI["1"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
UI["1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)

-- // StarterGui.assetDownloaderSketch.Frame.ScrollingFrame \\ --
UI["2"] = Instance.new("ScrollingFrame", UI["1"])
UI["2"]["Active"] = true
UI["2"]["BorderSizePixel"] = 0
UI["2"]["CanvasSize"] = UDim2.new(0, 0, 4, 0)
UI["2"]["BackgroundColor3"] = Color3.fromRGB(104, 104, 104)
UI["2"]["Size"] = UDim2.new(0.94981, 0, 0.70088, 0)
UI["2"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0)
UI["2"]["Position"] = UDim2.new(0.02896, 0, 0.04851, 0)
UI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)

-- // StarterGui.assetDownloaderSketch.Frame.ScrollingFrame.TextBox \\ --
UI["3"] = Instance.new("TextBox", UI["2"])
UI["3"]["TextColor3"] = Color3.fromRGB(196, 196, 196)
UI["3"]["BorderSizePixel"] = 0
UI["3"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["3"]["TextWrapped"] = true
UI["3"]["TextSize"] = 32
UI["3"]["TextYAlignment"] = Enum.TextYAlignment.Top
UI["3"]["BackgroundColor3"] = Color3.fromRGB(128, 128, 128)
UI["3"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["3"]["RichText"] = false
UI["3"]["MultiLine"] = true
UI["3"]["Size"] = UDim2.new(1, 0, 1, 0)
UI["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["3"]["ClearTextOnFocus"] = false
UI["3"]["Text"] = [[]]

-- // StarterGui.assetDownloaderSketch.Frame.titleLbl \\ --
UI["4"] = Instance.new("TextLabel", UI["1"])
UI["4"]["TextWrapped"] = true
UI["4"]["BorderSizePixel"] = 0
UI["4"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["4"]["TextScaled"] = true
UI["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["4"]["TextSize"] = 14
UI["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["4"]["TextColor3"] = Color3.fromRGB(178, 178, 178)
UI["4"]["BackgroundTransparency"] = 1
UI["4"]["Size"] = UDim2.new(0.45174, 0, 0.10557, 0)
UI["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["4"]["Text"] = [[Asset Downloader]]
UI["4"]["Name"] = [[titleLbl]]
UI["4"]["Position"] = UDim2.new(0.02896, 0, 0.81232, 0)

-- // StarterGui.assetDownloaderSketch.Frame.creditLbl \\ --
UI["5"] = Instance.new("TextLabel", UI["1"])
UI["5"]["TextWrapped"] = true
UI["5"]["ZIndex"] = 3
UI["5"]["BorderSizePixel"] = 0
UI["5"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["5"]["TextScaled"] = true
UI["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["5"]["TextSize"] = 14
UI["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["5"]["TextColor3"] = Color3.fromRGB(178, 178, 178)
UI["5"]["BackgroundTransparency"] = 1
UI["5"]["Size"] = UDim2.new(0.45174, 0, 0.05572, 0)
UI["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["5"]["Text"] = [[by SkylarZYX]]
UI["5"]["Name"] = [[creditLbl]]
UI["5"]["Position"] = UDim2.new(0.02896, 0, 0.91789, 0)

-- // StarterGui.assetDownloaderSketch.Frame.clrTextBtn \\ --
UI["6"] = Instance.new("TextButton", UI["1"])
UI["6"]["BorderSizePixel"] = 0
UI["6"]["TextSize"] = 14
UI["6"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["6"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
UI["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["6"]["Size"] = UDim2.new(0.20077, 0, 0.07331, 0)
UI["6"]["Name"] = [[clrTextBtn]]
UI["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["6"]["Text"] = [[Clear Text]]
UI["6"]["Position"] = UDim2.new(0.77606, 0, 0.81232, 0)

-- // StarterGui.assetDownloaderSketch.Frame.statusLbl \\ --
UI["7"] = Instance.new("TextLabel", UI["1"])
UI["7"]["BorderSizePixel"] = 0
UI["7"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["7"]["TextSize"] = 14
UI["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["7"]["BackgroundTransparency"] = 1
UI["7"]["Size"] = UDim2.new(0.31467, 0, 0.07331, 0)
UI["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["7"]["Text"] = [[Select instance(s)...]]
UI["7"]["Name"] = [[statusLbl]]
UI["7"]["Position"] = UDim2.new(0.25483, 0, 0.90909, 0)

-- // StarterGui.assetDownloaderSketch.Frame.urlBtn \\ --
UI["8"] = Instance.new("TextButton", UI["1"])
UI["8"]["BorderSizePixel"] = 0
UI["8"]["TextSize"] = 14
UI["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["8"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
UI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["8"]["Size"] = UDim2.new(0.20077, 0, 0.07331, 0)
UI["8"]["Name"] = [[urlBtn]]
UI["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["8"]["Text"] = [[Get URL(s)]]
UI["8"]["Position"] = UDim2.new(0.77606, 0, 0.90029, 0)

-- // StarterGui.assetDownloaderSketch.Frame.propBox \\ --
UI["9"] = Instance.new("TextBox", UI["1"])
UI["9"]["CursorPosition"] = -1
UI["9"]["TextColor3"] = Color3.fromRGB(199, 199, 199)
UI["9"]["BorderSizePixel"] = 2
UI["9"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["9"]["TextWrapped"] = true
UI["9"]["TextSize"] = 14
UI["9"]["Name"] = [[propBox]]
UI["9"]["TextScaled"] = true
UI["9"]["BackgroundColor3"] = Color3.fromRGB(58, 58, 58)
UI["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["9"]["ClearTextOnFocus"] = false
UI["9"]["Size"] = UDim2.new(0.25097, 0, 0.07331, 0)
UI["9"]["Position"] = UDim2.new(0.50193, 0, 0.82698, 0)
UI["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["9"]["Text"] = [[]]

-- // StarterGui.assetDownloaderSketch.Frame.propLbl \\ --
UI["a"] = Instance.new("TextLabel", UI["1"])
UI["a"]["BorderSizePixel"] = 0
UI["a"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["a"]["TextSize"] = 14
UI["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
UI["a"]["BackgroundTransparency"] = 1
UI["a"]["Size"] = UDim2.new(0.12934, 0, 0.04399, 0)
UI["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["a"]["Text"] = [[AssetId Property Name:]]
UI["a"]["Name"] = [[propLbl]]
UI["a"]["Position"] = UDim2.new(0.50193, 0, 0.76833, 0)

-- // StarterGui.assetDownloaderSketch.Frame.Splash \\ --
UI["b"] = Instance.new("Frame", UI["1"])
UI["b"]["ZIndex"] = 2
UI["b"]["BorderSizePixel"] = 0
UI["b"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
UI["b"]["Size"] = UDim2.new(1, 0, 1, 0)
UI["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["b"]["Name"] = [[Splash]]

-- // StarterGui.assetDownloaderSketch.Frame.Splash.titleLbl \\ --
UI["c"] = Instance.new("TextLabel", UI["b"])
UI["c"]["TextWrapped"] = true
UI["c"]["ZIndex"] = 2
UI["c"]["BorderSizePixel"] = 0
UI["c"]["TextXAlignment"] = Enum.TextXAlignment.Left
UI["c"]["TextTransparency"] = 1
UI["c"]["TextScaled"] = true
UI["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["c"]["TextSize"] = 14
UI["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
UI["c"]["TextColor3"] = Color3.fromRGB(224, 224, 224)
UI["c"]["BackgroundTransparency"] = 1
UI["c"]["Size"] = UDim2.new(0.37645, 0, 0.08798, 0)
UI["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["c"]["Text"] = [[Asset Downloader (v]]..ver..[[)]]
UI["c"]["Name"] = [[titleLbl]]
UI["c"]["Position"] = UDim2.new(0.31467, 0, 0.6305, 0)

-- // StarterGui.assetDownloaderSketch.Frame.Splash.drive \\ --
UI["d"] = Instance.new("ImageLabel", UI["b"])
UI["d"]["ZIndex"] = 2
UI["d"]["BorderSizePixel"] = 0
UI["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["d"]["ScaleType"] = Enum.ScaleType.Fit
UI["d"]["Image"] = [[rbxassetid://18421325655]]
UI["d"]["Size"] = UDim2.new(0.19305, 0, 0.29326, 0)
UI["d"]["Visible"] = false
UI["d"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["d"]["BackgroundTransparency"] = 1
UI["d"]["Name"] = [[drive]]
UI["d"]["Position"] = UDim2.new(0.403, 0, 1.05, 0)

-- // StarterGui.assetDownloaderSketch.Frame.Splash.downArrow \\ --
UI["e"] = Instance.new("ImageLabel", UI["b"])
UI["e"]["ZIndex"] = 3
UI["e"]["BorderSizePixel"] = 0
UI["e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
UI["e"]["ScaleType"] = Enum.ScaleType.Fit
UI["e"]["Image"] = [[rbxassetid://18421327478]]
UI["e"]["Size"] = UDim2.new(0.18726, 0, 0.18726, 0)
UI["e"]["Visible"] = false
UI["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
UI["e"]["BackgroundTransparency"] = 1
UI["e"]["Name"] = [[downArrow]]
UI["e"]["Position"] = UDim2.new(0.409, 0, -0.25, 0)

--[[local mainUI = Instance.new("Frame")
mainUI.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
mainUI.BorderSizePixel = 0
mainUI.AnchorPoint = Vector2.new(0.5,0.5)
mainUI.Size = UDim2.new(1,0,1,0)
mainUI.Position = UDim2.new(0.5,0,0.5,0)
mainUI.SizeConstraint = Enum.SizeConstraint.RelativeXY
mainUI.Parent = mainWidget
-- ScrollingFrame Init
local scrollFrm = Instance.new("ScrollingFrame")
scrollFrm.BackgroundColor3 = Color3.fromRGB(103, 103, 103)
scrollFrm.BorderSizePixel = 0
scrollFrm.AnchorPoint = Vector2.new(0,0)
scrollFrm.Size = UDim2.new(0.95,0,0.721,0)
scrollFrm.CanvasSize = UDim2.new(0,0,4,0)
scrollFrm.Position = UDim2.new(0.029,0,0.049,0)
scrollFrm.SizeConstraint = Enum.SizeConstraint.RelativeXY
scrollFrm.Interactable = true
scrollFrm.Parent = mainUI
-- clrTextBtn Init
local clrText = Instance.new("TextButton")
clrText.Name = "clrTextBtn" hardcoding it is too tedious for me, need plugin :) --]] 

-- Utils

local function getProperty(obj,propName)
	return ({pcall(function()if(typeof(obj[propName])=="Instance")then error("")end end)})[1]
end

-- Main Functions

local function resetStatus(status)
	status.Text = "Select instance(s)..."
end

local function clearTxt(txt,status)
	txt.Text = ""
	status.Text = "Cleared Text!"
	task.wait(1)
	resetStatus(status)
end

local function getAssetIds(prop,status)
	local assetIds = {}
	local valid = false
	for i=1,#validProps do
		if prop == validProps[i] then
			valid = true
			for i,v in pairs(Selection:Get()) do
				status.Text = "Searching " ..v.Name .."..."
				if getProperty(v,prop) then
					if typeof(v[prop]) == "string" then
						if v[prop] ~= "" then
							table.insert(assetIds,v[prop])
						end
					end
				else
					for j,k in pairs(v:GetDescendants()) do
						if getProperty(k,prop) then
							if typeof(k[prop]) == "string" then
								if k[prop] ~= "" then
									table.insert(assetIds,k[prop])
								end
							end
						end
					end
				end
			end
			if #assetIds == 0 then
				status.Text = "No assetids found!"
			else
				status.Text = "Assetids found!"
			end
		end
	end
	if valid == false then
		status.Text = "The property, "..prop..", is not recognized as an asset."
	end
	assetIdsGet = true
	return assetIds
end

--[[ local function isolateIdOld(id)
	print(id)
	if string.find(id,"rbxasset://") then
		print("localassetpath")
		id = string.gsub(id,"rbxasset://","")
	elseif string.find(id,"rbxassetid://") then
		print("serverassetpath")
		id = string.gsub(id,"rbxassetid://","")
	elseif string.find(id,"assetdelivery.roblox.com") then
		print("assetdelivery")
		id = string.gsub(id,"https://assetdelivery.roblox.com/v1/asset/?id=","")
	elseif string.find(id,"www.roblox.com") then
		print("oldasseturl")
		id = string.gsub(id,"www.roblox.com","")
	end
	return id
end 

apparently string.find() and string.gsub() have a max limit of characters for the patterns which is why this method is commented out and replaced with a more reliable method --]]

-- string.split() my beloved (thank you, Luau string library)
local function isolateId(id)
	for i=1,#idPatterns do
		if string.match(id,idPatterns[i]) then
			local splitted = string.split(id,idPatterns[i])
			id = splitted[2]
		end
	end
	return id
end

local function resetSplash()
	if mainWidget.Enabled == true then
		UI["b"].BackgroundTransparency = 1
		UI["b"].Visible = false
		UI["d"].Position = lblOutPositions[1]
		UI["e"].Position = lblOutPositions[2]
		for i,v in pairs(UI["b"]:GetChildren()) do
			if getProperty(v,"ImageTransparency") then
				v.ImageTransparency = 1
			elseif getProperty(v,"TextTransparency") then
				v.TextTransparency = 1
			end
			v.Visible = false
		end
	elseif mainWidget.Enabled == false then
		UI["b"].BackgroundTransparency = 0
		UI["b"].Visible = true
		UI["d"].Position = lblOutPositions[1]
		UI["e"].Position = lblOutPositions[2]
		for i,v in pairs(UI["b"]:GetChildren()) do
			if getProperty(v,"ImageTransparency") then
				v.ImageTransparency = 1
			elseif getProperty(v,"TextTransparency") then
				v.TextTransparency = 1
			end
			v.Visible = false
		end
	end
end

local function tweenSplash()
	UI["b"].BackgroundTransparency = 0
	UI["b"].Visible = true
	for i,v in pairs(UI["b"]:GetChildren()) do
		if getProperty(v,"ImageTransparency") then
			v.ImageTransparency = 0
		elseif getProperty(v,"TextTransparency") then
			v.TextTransparency = 1
		end
		v.Visible = true
	end
	TweenService:Create(UI["d"],lblTweens[1],{Position = lblInPositions[1]}):Play()
	TweenService:Create(UI["e"],lblTweens[1],{Position = lblInPositions[2]}):Play()
	task.wait(0.5)
	TweenService:Create(UI["c"],lblTweens[1],{TextTransparency = 0}):Play()
	task.wait(1)
	TweenService:Create(UI["b"],lblTweens[1],{BackgroundTransparency = 1}):Play()
	for i,v in pairs(UI["b"]:GetChildren()) do
		if getProperty(v,"ImageTransparency") then
			TweenService:Create(v,lblTweens[1],{ImageTransparency = 1}):Play()
		elseif getProperty(v,"TextTransparency") then
			TweenService:Create(v,lblTweens[1],{TextTransparency = 1}):Play()
		end
	end
	task.wait(0.5)
	resetSplash()
end

local function writeUrl(id,txtBox,prevTxt)
	txtBox.Text = prevTxt.. urlTmpl.. id.. "\n"
end

local function onInitClicked()
	-- print("clicked!")
	if mainWidget.Enabled == false then
		mainWidget.Enabled = true
		tweenSplash()
	elseif mainWidget.Enabled == true then
		mainWidget.Enabled = false
		resetSplash()
	end
end

initBtn.Click:Connect(onInitClicked)

UI["6"].MouseButton1Click:Connect(function() 
	clearTxt(UI["3"],UI["7"]) 
end)

UI["8"].MouseButton1Click:Connect(function()
	if urlBtnDB == false then
		urlBtnDB = true
		local assetIds = getAssetIds(UI["9"].Text,UI["7"])
		repeat task.wait() until assetIdsGet == true
		for i=1,#assetIds do
			local id = isolateId(assetIds[i])
			print(id)
			writeUrl(id,UI["3"],UI["3"].Text)
		end
		task.wait(urlBtnCD)
		resetStatus(UI["7"])
		assetIdsGet = false
		urlBtnDB = false
	end
end)

if mainWidget.Enabled == false then
	resetSplash()
elseif mainWidget.Enabled == true then
	resetSplash()
	tweenSplash()
end
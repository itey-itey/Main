--[[
    Global Executor Chat Platform - DEBUG VERSION
    Full-featured Discord-like chat platform with comprehensive UI and backend integration.
    Created by BDG Software - ROBLOX EXECUTOR COMPATIBLE
    
    DEBUG VERSION - Enhanced error handling and logging to identify UI issues
    
    Usage: loadstring(game:HttpGet("YOUR_URL/GlobalExecutorChat_Debug_Version.lua"))()
]]

-- ============================================================================
-- GLOBAL EXECUTOR CHAT PLATFORM - DEBUG VERSION
-- ============================================================================

print("🚀 Starting Global Executor Chat Platform (DEBUG VERSION)...")

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

print("✅ All services loaded successfully")

-- Global variables for better compatibility
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

print("✅ Player and PlayerGui loaded:", LocalPlayer.Name)

-- HTTP Request function setup for different executors (ENHANCED WITH DELTA)
local httpRequest = nil
local executorName = "Unknown"

-- Enhanced executor detection with Delta support
local function setupHttpRequest()
    print("🔍 Detecting executor...")
    
    -- Delta Executor
    if getgenv and getgenv().request then
        httpRequest = getgenv().request
        executorName = "Delta"
        print("✅ Delta Executor detected")
    -- Delta (alternative detection)
    elseif Delta and Delta.request then
        httpRequest = Delta.request
        executorName = "Delta"
        print("✅ Delta Executor detected (alternative method)")
    -- Synapse X
    elseif syn and syn.request then
        httpRequest = syn.request
        executorName = "Synapse X"
        print("✅ Synapse X detected")
    -- KRNL
    elseif http_request then
        httpRequest = http_request
        executorName = "KRNL"
        print("✅ KRNL detected")
    -- Script-Ware
    elseif request then
        httpRequest = request
        executorName = "Script-Ware"
        print("✅ Script-Ware detected")
    -- Fluxus
    elseif fluxus and fluxus.request then
        httpRequest = fluxus.request
        executorName = "Fluxus"
        print("✅ Fluxus detected")
    -- Oxygen U
    elseif http and http.request then
        httpRequest = http.request
        executorName = "Oxygen U"
        print("✅ Oxygen U detected")
    -- Sentinel
    elseif Sentinel and Sentinel.request then
        httpRequest = Sentinel.request
        executorName = "Sentinel"
        print("✅ Sentinel detected")
    -- ProtoSmasher
    elseif ProtoSmasher and ProtoSmasher.request then
        httpRequest = ProtoSmasher.request
        executorName = "ProtoSmasher"
        print("✅ ProtoSmasher detected")
    -- JJSploit/Default
    elseif game:GetService("HttpService").RequestAsync then
        httpRequest = function(options)
            return game:GetService("HttpService"):RequestAsync(options)
        end
        executorName = "JJSploit/Default"
        print("✅ JJSploit/Default detected")
    else
        error("❌ No compatible HTTP request method found! Please use a supported executor.")
    end
    
    print("🎯 Using executor: " .. executorName)
end

-- File system compatibility check
local hasFileSystem = false
local function checkFileSystem()
    local success = pcall(function()
        if isfolder and makefolder and writefile and readfile and delfile and isfile then
            hasFileSystem = true
            print("✅ File system supported")
        else
            print("⚠️ File system not supported - using memory storage")
        end
    end)
    
    if not success then
        print("⚠️ File system check failed - using memory storage")
    end
end

-- Initialize compatibility with error handling
local function safeInitialize()
    local success, error = pcall(function()
        setupHttpRequest()
        checkFileSystem()
    end)
    
    if not success then
        print("❌ Initialization failed:", error)
        return false
    end
    
    return true
end

if not safeInitialize() then
    error("❌ Failed to initialize executor compatibility!")
end

-- ============================================================================
-- PROFESSIONAL UI THEME SYSTEM
-- ============================================================================

local UITheme = {
    -- Modern Discord-like Dark Theme
    Colors = {
        Primary = Color3.fromRGB(32, 34, 37),      -- Dark background
        Secondary = Color3.fromRGB(47, 49, 54),    -- Lighter dark
        Tertiary = Color3.fromRGB(64, 68, 75),     -- Even lighter
        Accent = Color3.fromRGB(88, 101, 242),     -- Discord blue
        AccentHover = Color3.fromRGB(71, 82, 196), -- Darker blue
        Success = Color3.fromRGB(67, 181, 129),    -- Green
        Warning = Color3.fromRGB(250, 166, 26),    -- Orange
        Error = Color3.fromRGB(237, 66, 69),       -- Red
        Text = Color3.fromRGB(255, 255, 255),      -- White text
        TextSecondary = Color3.fromRGB(185, 187, 190), -- Gray text
        TextMuted = Color3.fromRGB(114, 118, 125), -- Muted text
        Border = Color3.fromRGB(60, 63, 69),       -- Border color
        Hover = Color3.fromRGB(64, 68, 75),        -- Hover state
        Input = Color3.fromRGB(64, 68, 75),        -- Input background
        Online = Color3.fromRGB(67, 181, 129),     -- Online status
        Away = Color3.fromRGB(250, 166, 26),       -- Away status
        Offline = Color3.fromRGB(116, 127, 141),   -- Offline status
    },
    
    -- Typography
    Fonts = {
        Primary = Enum.Font.Gotham,
        Secondary = Enum.Font.GothamMedium,
        Bold = Enum.Font.GothamBold,
        Code = Enum.Font.RobotoMono
    },
    
    -- Sizing
    Sizes = {
        CornerRadius = UDim.new(0, 8),
        SmallCornerRadius = UDim.new(0, 4),
        BorderSize = 1,
        Padding = 12,
        SmallPadding = 8,
        LargePadding = 16,
        HeaderHeight = 50,
        SidebarWidth = 240,
        MessageHeight = 60,
        InputHeight = 44
    },
    
    -- Animations
    Animations = {
        Fast = 0.15,
        Medium = 0.25,
        Slow = 0.4,
        EaseStyle = Enum.EasingStyle.Quart,
        EaseDirection = Enum.EasingDirection.Out
    }
}

print("✅ UI Theme loaded")

-- ============================================================================
-- ENHANCED LOCAL STORAGE SYSTEM
-- ============================================================================

local LocalStorage = {}

-- Create workspace folder for GlobalChat
local function ensureWorkspaceFolder()
    if not hasFileSystem then
        return false
    end
    
    local success, result = pcall(function()
        if not isfolder("GlobalChat") then
            makefolder("GlobalChat")
        end
        if not isfolder("GlobalChat/Config") then
            makefolder("GlobalChat/Config")
        end
        if not isfolder("GlobalChat/Auth") then
            makefolder("GlobalChat/Auth")
        end
        if not isfolder("GlobalChat/Cache") then
            makefolder("GlobalChat/Cache")
        end
        return true
    end)
    
    return success
end

function LocalStorage:Initialize()
    print("💾 Initializing Local Storage...")
    self.hasFileSystem = ensureWorkspaceFolder()
    self.memoryStorage = {}
    print("💾 Local Storage initialized (File System: " .. (self.hasFileSystem and "Available" or "Memory Only") .. ")")
end

function LocalStorage:SaveConfig(config)
    local success, configData = pcall(function()
        return HttpService:JSONEncode(config)
    end)
    
    if not success then
        warn("❌ Failed to encode config data")
        return false
    end
    
    if self.hasFileSystem then
        local success = pcall(function()
            writefile("GlobalChat/Config/user_config.json", configData)
        end)
        if success then
            print("💾 Config saved to file")
            return true
        end
    end
    
    -- Fallback to memory
    self.memoryStorage.config = config
    print("💾 Config saved to memory")
    return true
end

function LocalStorage:LoadConfig()
    if self.hasFileSystem then
        local success, result = pcall(function()
            if isfile("GlobalChat/Config/user_config.json") then
                local data = readfile("GlobalChat/Config/user_config.json")
                return HttpService:JSONDecode(data)
            end
            return nil
        end)
        
        if success and result then
            print("📂 Config loaded from file")
            return result
        end
    end
    
    -- Fallback to memory
    if self.memoryStorage.config then
        print("📂 Config loaded from memory")
        return self.memoryStorage.config
    end
    
    return nil
end

function LocalStorage:SaveAuth(authData)
    local success, data = pcall(function()
        return HttpService:JSONEncode(authData)
    end)
    
    if not success then
        warn("❌ Failed to encode auth data")
        return false
    end
    
    if self.hasFileSystem then
        local success = pcall(function()
            writefile("GlobalChat/Auth/credentials.json", data)
        end)
        if success then
            print("🔐 Auth data saved to file")
            return true
        end
    end
    
    -- Fallback to memory
    self.memoryStorage.auth = authData
    print("🔐 Auth data saved to memory")
    return true
end

function LocalStorage:LoadAuth()
    if self.hasFileSystem then
        local success, result = pcall(function()
            if isfile("GlobalChat/Auth/credentials.json") then
                local data = readfile("GlobalChat/Auth/credentials.json")
                return HttpService:JSONDecode(data)
            end
            return nil
        end)
        
        if success and result then
            print("🔐 Auth data loaded from file")
            return result
        end
    end
    
    -- Fallback to memory
    if self.memoryStorage.auth then
        print("🔐 Auth data loaded from memory")
        return self.memoryStorage.auth
    end
    
    return nil
end

function LocalStorage:ClearAuth()
    if self.hasFileSystem then
        pcall(function()
            if isfile("GlobalChat/Auth/credentials.json") then
                delfile("GlobalChat/Auth/credentials.json")
            end
        end)
    end
    
    self.memoryStorage.auth = nil
    print("🗑️ Auth data cleared")
end

-- ============================================================================
-- SIMPLE TEST UI FUNCTION
-- ============================================================================

local function createTestUI()
    print("🧪 Creating test UI to verify basic functionality...")
    
    local success, error = pcall(function()
        -- Create test GUI
        local testGui = Instance.new("ScreenGui")
        testGui.Name = "GlobalChatTest"
        testGui.ResetOnSpawn = false
        testGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        testGui.Parent = PlayerGui
        
        -- Test frame
        local testFrame = Instance.new("Frame")
        testFrame.Name = "TestFrame"
        testFrame.Size = UDim2.new(0, 400, 0, 200)
        testFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
        testFrame.BackgroundColor3 = UITheme.Colors.Primary
        testFrame.BorderSizePixel = 0
        testFrame.Parent = testGui
        
        -- Add corner radius
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UITheme.Sizes.CornerRadius
        corner.Parent = testFrame
        
        -- Test label
        local testLabel = Instance.new("TextLabel")
        testLabel.Size = UDim2.new(1, 0, 0.5, 0)
        testLabel.Position = UDim2.new(0, 0, 0, 0)
        testLabel.BackgroundTransparency = 1
        testLabel.Text = "🧪 UI Test Successful!\nExecutor: " .. executorName
        testLabel.TextColor3 = UITheme.Colors.Success
        testLabel.TextSize = 16
        testLabel.Font = UITheme.Fonts.Bold
        testLabel.TextWrapped = true
        testLabel.Parent = testFrame
        
        -- Test button
        local testButton = Instance.new("TextButton")
        testButton.Size = UDim2.new(0.8, 0, 0, 40)
        testButton.Position = UDim2.new(0.1, 0, 0.6, 0)
        testButton.BackgroundColor3 = UITheme.Colors.Success
        testButton.BorderSizePixel = 0
        testButton.Text = "✅ Continue to Setup"
        testButton.TextColor3 = UITheme.Colors.Text
        testButton.TextSize = 14
        testButton.Font = UITheme.Fonts.Primary
        testButton.Parent = testFrame
        
        -- Add corner radius to button
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UITheme.Sizes.CornerRadius
        buttonCorner.Parent = testButton
        
        print("✅ Test UI created successfully!")
        
        -- Button click handler
        testButton.MouseButton1Click:Connect(function()
            print("🔘 Test button clicked - proceeding to main setup...")
            testGui:Destroy()
            -- Continue with main setup
            spawn(function()
                wait(0.5)
                showMainSetup()
            end)
        end)
        
        return true
    end)
    
    if not success then
        print("❌ Failed to create test UI:", error)
        return false
    end
    
    return true
end

-- ============================================================================
-- SIMPLIFIED SETUP WIZARD
-- ============================================================================

function showMainSetup()
    print("🧙 Starting main setup wizard...")
    
    local success, error = pcall(function()
        -- Create modal
        local modal = Instance.new("Frame")
        modal.Name = "SetupModal"
        modal.Size = UDim2.new(1, 0, 1, 0)
        modal.Position = UDim2.new(0, 0, 0, 0)
        modal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        modal.BackgroundTransparency = 0.5
        modal.BorderSizePixel = 0
        modal.ZIndex = 1000
        modal.Parent = PlayerGui
        
        -- Create modal content
        local content = Instance.new("Frame")
        content.Name = "ModalContent"
        content.Size = UDim2.new(0, 500, 0, 400)
        content.Position = UDim2.new(0.5, -250, 0.5, -200)
        content.BackgroundColor3 = UITheme.Colors.Secondary
        content.BorderSizePixel = 0
        content.ZIndex = 1001
        content.Parent = modal
        
        -- Add corner radius
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UITheme.Sizes.CornerRadius
        corner.Parent = content
        
        -- Title
        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Size = UDim2.new(1, 0, 0, 50)
        title.Position = UDim2.new(0, 0, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "🌟 Welcome to Global Executor Chat"
        title.TextColor3 = UITheme.Colors.Text
        title.TextSize = 20
        title.Font = UITheme.Fonts.Bold
        title.Parent = content
        
        -- Subtitle
        local subtitle = Instance.new("TextLabel")
        subtitle.Name = "Subtitle"
        subtitle.Size = UDim2.new(1, 0, 0, 30)
        subtitle.Position = UDim2.new(0, 0, 0, 50)
        subtitle.BackgroundTransparency = 1
        subtitle.Text = "Detected Executor: " .. executorName
        subtitle.TextColor3 = UITheme.Colors.Success
        subtitle.TextSize = 14
        subtitle.Font = UITheme.Fonts.Primary
        subtitle.Parent = content
        
        -- Platform selection
        local platformLabel = Instance.new("TextLabel")
        platformLabel.Size = UDim2.new(1, 0, 0, 30)
        platformLabel.Position = UDim2.new(0, 0, 0, 100)
        platformLabel.BackgroundTransparency = 1
        platformLabel.Text = "Select your platform:"
        platformLabel.TextColor3 = UITheme.Colors.Text
        platformLabel.TextSize = 16
        platformLabel.Font = UITheme.Fonts.Primary
        platformLabel.Parent = content
        
        -- Platform buttons
        local platforms = {
            {name = "Roblox", icon = "🎮"},
            {name = "Discord", icon = "💬"},
            {name = "Web", icon = "🌐"},
            {name = "Mobile", icon = "📱"}
        }
        
        for i, platform in ipairs(platforms) do
            local platformBtn = Instance.new("TextButton")
            platformBtn.Name = "Platform" .. i
            platformBtn.Size = UDim2.new(0.45, 0, 0, 60)
            platformBtn.Position = UDim2.new((i-1) % 2 * 0.5 + 0.025, 0, 0, 140 + math.floor((i-1) / 2) * 80)
            platformBtn.BackgroundColor3 = UITheme.Colors.Accent
            platformBtn.BorderSizePixel = 0
            platformBtn.Text = platform.icon .. " " .. platform.name
            platformBtn.TextColor3 = UITheme.Colors.Text
            platformBtn.TextSize = 16
            platformBtn.Font = UITheme.Fonts.Primary
            platformBtn.Parent = content
            
            -- Add corner radius
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UITheme.Sizes.CornerRadius
            btnCorner.Parent = platformBtn
            
            -- Click handler
            platformBtn.MouseButton1Click:Connect(function()
                print("🔘 Selected platform:", platform.name)
                modal:Destroy()
                showQuickSetup(platform.name)
            end)
        end
        
        print("✅ Main setup UI created successfully!")
    end)
    
    if not success then
        print("❌ Failed to create main setup:", error)
        -- Fallback to simple message
        createFallbackMessage("Setup failed: " .. tostring(error))
    end
end

function showQuickSetup(platform)
    print("⚡ Starting quick setup for platform:", platform)
    
    local success, error = pcall(function()
        -- Create quick setup modal
        local modal = Instance.new("Frame")
        modal.Name = "QuickSetupModal"
        modal.Size = UDim2.new(1, 0, 1, 0)
        modal.Position = UDim2.new(0, 0, 0, 0)
        modal.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        modal.BackgroundTransparency = 0.5
        modal.BorderSizePixel = 0
        modal.ZIndex = 1000
        modal.Parent = PlayerGui
        
        -- Create modal content
        local content = Instance.new("Frame")
        content.Name = "ModalContent"
        content.Size = UDim2.new(0, 400, 0, 300)
        content.Position = UDim2.new(0.5, -200, 0.5, -150)
        content.BackgroundColor3 = UITheme.Colors.Secondary
        content.BorderSizePixel = 0
        content.ZIndex = 1001
        content.Parent = modal
        
        -- Add corner radius
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UITheme.Sizes.CornerRadius
        corner.Parent = content
        
        -- Title
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 40)
        title.Position = UDim2.new(0, 0, 0, 10)
        title.BackgroundTransparency = 1
        title.Text = "🔐 Quick Setup"
        title.TextColor3 = UITheme.Colors.Text
        title.TextSize = 18
        title.Font = UITheme.Fonts.Bold
        title.Parent = content
        
        -- Register button
        local registerBtn = Instance.new("TextButton")
        registerBtn.Size = UDim2.new(1, -40, 0, 50)
        registerBtn.Position = UDim2.new(0, 20, 0, 70)
        registerBtn.BackgroundColor3 = UITheme.Colors.Success
        registerBtn.BorderSizePixel = 0
        registerBtn.Text = "📝 Create New Account"
        registerBtn.TextColor3 = UITheme.Colors.Text
        registerBtn.TextSize = 14
        registerBtn.Font = UITheme.Fonts.Primary
        registerBtn.Parent = content
        
        local regCorner = Instance.new("UICorner")
        regCorner.CornerRadius = UITheme.Sizes.CornerRadius
        regCorner.Parent = registerBtn
        
        -- Login button
        local loginBtn = Instance.new("TextButton")
        loginBtn.Size = UDim2.new(1, -40, 0, 50)
        loginBtn.Position = UDim2.new(0, 20, 0, 130)
        loginBtn.BackgroundColor3 = UITheme.Colors.Accent
        loginBtn.BorderSizePixel = 0
        loginBtn.Text = "🔑 Login to Existing Account"
        loginBtn.TextColor3 = UITheme.Colors.Text
        loginBtn.TextSize = 14
        loginBtn.Font = UITheme.Fonts.Primary
        loginBtn.Parent = content
        
        local loginCorner = Instance.new("UICorner")
        loginCorner.CornerRadius = UITheme.Sizes.CornerRadius
        loginCorner.Parent = loginBtn
        
        -- Guest button
        local guestBtn = Instance.new("TextButton")
        guestBtn.Size = UDim2.new(1, -40, 0, 50)
        guestBtn.Position = UDim2.new(0, 20, 0, 190)
        guestBtn.BackgroundColor3 = UITheme.Colors.TextMuted
        guestBtn.BorderSizePixel = 0
        guestBtn.Text = "👤 Continue as Guest"
        guestBtn.TextColor3 = UITheme.Colors.Text
        guestBtn.TextSize = 14
        guestBtn.Font = UITheme.Fonts.Primary
        guestBtn.Parent = content
        
        local guestCorner = Instance.new("UICorner")
        guestCorner.CornerRadius = UITheme.Sizes.CornerRadius
        guestCorner.Parent = guestBtn
        
        -- Button handlers
        registerBtn.MouseButton1Click:Connect(function()
            print("🔘 Register button clicked")
            modal:Destroy()
            showRegisterForm(platform)
        end)
        
        loginBtn.MouseButton1Click:Connect(function()
            print("🔘 Login button clicked")
            modal:Destroy()
            showLoginForm(platform)
        end)
        
        guestBtn.MouseButton1Click:Connect(function()
            print("🔘 Guest button clicked")
            modal:Destroy()
            createGuestSession(platform)
        end)
        
        print("✅ Quick setup UI created successfully!")
    end)
    
    if not success then
        print("❌ Failed to create quick setup:", error)
        createFallbackMessage("Quick setup failed: " .. tostring(error))
    end
end

function showRegisterForm(platform)
    print("📝 Showing registration form for platform:", platform)
    createFallbackMessage("Registration form would appear here.\nPlatform: " .. platform .. "\nExecutor: " .. executorName)
end

function showLoginForm(platform)
    print("🔑 Showing login form for platform:", platform)
    createFallbackMessage("Login form would appear here.\nPlatform: " .. platform .. "\nExecutor: " .. executorName)
end

function createGuestSession(platform)
    print("👤 Creating guest session for platform:", platform)
    createFallbackMessage("Guest session created!\nPlatform: " .. platform .. "\nExecutor: " .. executorName .. "\n\nChat interface would load here.")
end

function createFallbackMessage(message)
    print("📢 Creating fallback message:", message)
    
    local success, error = pcall(function()
        -- Create fallback GUI
        local fallbackGui = Instance.new("ScreenGui")
        fallbackGui.Name = "GlobalChatFallback"
        fallbackGui.ResetOnSpawn = false
        fallbackGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        fallbackGui.Parent = PlayerGui
        
        -- Fallback frame
        local fallbackFrame = Instance.new("Frame")
        fallbackFrame.Name = "FallbackFrame"
        fallbackFrame.Size = UDim2.new(0, 500, 0, 300)
        fallbackFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
        fallbackFrame.BackgroundColor3 = UITheme.Colors.Primary
        fallbackFrame.BorderSizePixel = 0
        fallbackFrame.Parent = fallbackGui
        
        -- Add corner radius
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UITheme.Sizes.CornerRadius
        corner.Parent = fallbackFrame
        
        -- Message label
        local messageLabel = Instance.new("TextLabel")
        messageLabel.Size = UDim2.new(1, -40, 1, -80)
        messageLabel.Position = UDim2.new(0, 20, 0, 20)
        messageLabel.BackgroundTransparency = 1
        messageLabel.Text = message
        messageLabel.TextColor3 = UITheme.Colors.Text
        messageLabel.TextSize = 14
        messageLabel.Font = UITheme.Fonts.Primary
        messageLabel.TextWrapped = true
        messageLabel.TextYAlignment = Enum.TextYAlignment.Top
        messageLabel.Parent = fallbackFrame
        
        -- Close button
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 100, 0, 40)
        closeButton.Position = UDim2.new(0.5, -50, 1, -60)
        closeButton.BackgroundColor3 = UITheme.Colors.Error
        closeButton.BorderSizePixel = 0
        closeButton.Text = "Close"
        closeButton.TextColor3 = UITheme.Colors.Text
        closeButton.TextSize = 14
        closeButton.Font = UITheme.Fonts.Primary
        closeButton.Parent = fallbackFrame
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UITheme.Sizes.CornerRadius
        closeCorner.Parent = closeButton
        
        closeButton.MouseButton1Click:Connect(function()
            fallbackGui:Destroy()
        end)
        
        print("✅ Fallback message created successfully!")
    end)
    
    if not success then
        print("❌ Failed to create fallback message:", error)
        -- Last resort - print to console
        print("🆘 LAST RESORT MESSAGE:", message)
    end
end

-- ============================================================================
-- MAIN INITIALIZATION (DEBUG VERSION)
-- ============================================================================

local function initializeDebugVersion()
    print("🚀 Initializing Global Executor Chat Platform (DEBUG VERSION)...")
    
    local success, error = pcall(function()
        -- Initialize local storage
        LocalStorage:Initialize()
        print("✅ Local Storage initialized")
        
        -- Check for existing config
        local existingConfig = LocalStorage:LoadConfig()
        if existingConfig and existingConfig.setupComplete then
            print("✅ Setup already completed, would load chat interface...")
            createFallbackMessage("Setup already completed!\nUser: " .. (existingConfig.username or "Unknown") .. "\nExecutor: " .. executorName .. "\n\nChat interface would load here.")
            return
        end
        
        print("🚀 No existing setup found, starting fresh setup...")
        
        -- Start with test UI first
        if not createTestUI() then
            print("❌ Test UI failed, trying main setup directly...")
            showMainSetup()
        end
    end)
    
    if not success then
        print("❌ Initialization failed:", error)
        createFallbackMessage("Initialization failed!\nError: " .. tostring(error) .. "\nExecutor: " .. executorName)
    end
end

-- Start the debug version
print("🎬 Starting debug initialization...")
initializeDebugVersion()

print("🌟 Global Executor Chat Platform (DEBUG VERSION) loaded!")
print("🎯 Executor: " .. executorName)
print("📱 If you see this message but no UI, check the console for errors.")

return {
    executor = executorName,
    initialized = true,
    debug = true
}
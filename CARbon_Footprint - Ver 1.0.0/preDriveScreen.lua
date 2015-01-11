local composer = require( "composer" )

local widget = require "widget"
composer.removeScene( "driveScreen", false )
composer.removeScene( "postDriveScreen", false )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view

carMakerGroup = display.newGroup()
sceneGroup:insert( carMakerGroup )

local background = display.newRect( 0, 0, 1080, 1920 )
background.x = _W*0.5
background.y = _H*0.5
sceneGroup:insert(background)


local preDriveHeader = display.newImage("assets/menus/preDriveHeader.png", true)
preDriveHeader.anchorY = 0
preDriveHeader.anchorX = 0.5
preDriveHeader.x = _W*0.5
sceneGroup:insert(preDriveHeader)


local gcAmountText = display.newText( "0", 0, 0, native.systemFont, 80 )
gcAmountText.x = _W*0.5 - 100
gcAmountText.y =  380
gcAmountText:setFillColor( 0/255, 102/255, 0/255 )
gcAmountText.anchorX = 0.5
gcAmountText.text = myGreenCoin
sceneGroup:insert(gcAmountText)






local function goToRedeemScreen (event)
	if event.phase == "ended" then
		composer.gotoScene( "redeemScreen", "fade", 400 )
	end
end

local redeemButton = widget.newButton
{
	width = 830,
	height = 238,
	defaultFile = "assets/buttons/redeem.png",
	overFile = "assets/buttons/redeemPress.png",
	onEvent = goToRedeemScreen
}

redeemButton.x = _W*0.5
redeemButton.y = _H*0.5+ 600
sceneGroup:insert(redeemButton)

--[[
local backButton = display.newImage("assets/backArrow.png", true)
backButton.x = 90
backButton.y = 80
sceneGroup:insert(backButton)

local function goBack (event)
	if event.phase == "began" then
		composer.gotoScene( "manufacturerSelectScreen", "fade", 400 )
	end
end

backButton:addEventListener( "touch", goBack )
--]]



local function goToDriveScreen (event)
	if event.phase == "ended" then
		composer.gotoScene( "driveScreen", "fade", 400 )
	end
end


local startDriveButton = widget.newButton
{
	width = 642,
	height = 642,
	defaultFile = "assets/buttons/driveButton.png",
	overFile = "assets/buttons/driveButtonPress.png",
	onEvent = goToDriveScreen
}

startDriveButton.x = _W*0.5
startDriveButton.y = _H*0.5
sceneGroup:insert(startDriveButton)

---------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------





-- Tries to automatically log in the user without displaying the login screen if the user doesn't want to login
gameNetwork.request("login",
{
	userInitiated = false
	})

	local left = display.screenOriginX
	local top = display.screenOriginY
	local width = display.viewableContentWidth - display.viewableContentWidth/100
	local size = display.viewableContentHeight/15
	local buttonTextSize = display.viewableContentWidth/20


	local loginLogoutButton
	local function loginLogoutListener(event)
		local function loginListener(event1)
			-- Checks to see if there was an error with the login.
			if event1.isError then
				loginLogoutButton:setLabel("Login")
			else
				loginLogoutButton:setLabel("Logout")
			end
		end

		if gameNetwork.request("isConnected") then
			gameNetwork.request("logout")
			loginLogoutButton:setLabel("Login")
		else
			-- Tries to login the user, if there is a problem then it will try to resolve it. eg. Show the log in screen.
			gameNetwork.request("login",
			{
				listener = loginListener,
				userInitiated = true
				})
			end
		end


		--login button
		local loginLogoutButton = widget.newButton
		{
			top = display.screenOriginY + display.viewableContentHeight - size,
			left = left,
			width = width,
			height = size,
			label = "Login",
			fontSize = buttonTextSize,
			onRelease = loginLogoutListener,
		}
		sceneGroup:insert(loginLogoutButton)
		--sceneGroup:insert(loginLogoutButton)

		-- Checks if the auto login worked and if it did then change the text on the button
		if gameNetwork.request("isConnected") then
			loginLogoutButton:setLabel("Logout")
		end




end

-- "scene:destroy()"
function scene:destroy( event )

	local sceneGroup = self.view

	-- Called prior to the removal of scene's view ("sceneGroup").
	-- Insert code here to clean up the scene.
	-- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene

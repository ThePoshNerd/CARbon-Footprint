local composer = require( "composer" )

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


local header = display.newImage("assets/menus/driveHeader.png", true)
header.anchorY = 0
header.anchorX = 0
header.x = 0
header.y = 0
sceneGroup:insert(header)



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


local startDriveButton = display.newImage("assets/driveButton.png", true)
startDriveButton.x = _W*0.5
startDriveButton.y = _H*0.5
sceneGroup:insert(startDriveButton)


local function goToDriveScreen (event)
	if event.phase == "began" then
		composer.gotoScene( "driveScreen", "fade", 400 )
	end
end

startDriveButton:addEventListener( "touch", goToDriveScreen )

---------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------


local widget = require "widget"



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
		loginLogoutButton = widget.newButton
		{
			top = display.screenOriginY + display.viewableContentHeight - size,
			left = left,
			width = width,
			height = size,
			label = "Login",
			fontSize = buttonTextSize,
			onRelease = loginLogoutListener,
		}
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

local composer = require( "composer" )
local widget = require "widget"


composer.removeScene( "preDriveScreen", false )
composer.removeScene( "postDriveScreen", false )


local save5Achieve = "CgkI-_Shl70OEAIQAg"
local save10Achieve = "CgkI-_Shl70OEAIQAw"
local save20Achieve = "CgkI-_Shl70OEAIQBA"

local drive25Achieve = "CgkI-_Shl70OEAIQBQ"
local drive50Achieve = "CgkI-_Shl70OEAIQBg"


local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view



	local redeemMenu = display.newImage("assets/menus/redeemGreenCoin.png", true)
	redeemMenu.anchorY = 0.5
	redeemMenu.anchorX = 0.5
	redeemMenu.y = _H*0.5
	redeemMenu.x = _W*0.5
	sceneGroup:insert(redeemMenu)


	local gcAmountText = display.newText( "0", 0, 0, native.systemFont, 80 )
	gcAmountText.x = _W*0.5 - 100
	gcAmountText.y =  380
	gcAmountText:setFillColor( 0/255, 102/255, 0/255 )
	gcAmountText.anchorX = 0.5
	gcAmountText.text = myGreenCoin
	sceneGroup:insert(gcAmountText)

	local backButton = display.newImage("assets/backArrow.png", true)
	backButton.x = 90
	backButton.y = 80
	sceneGroup:insert(backButton)





	local popShade = display.newRect( 0, 0, 1080, 1920 )
	popShade.x = _W*0.5
	popShade.y = _H*0.5
	popShade:setFillColor( 0, 0, 0 )
	popShade.alpha = 0
	sceneGroup:insert(popShade)

	local starbucksPopup = display.newImage("assets/menus/starbucksPop.png", true)
	starbucksPopup.anchorY = 0.5
	starbucksPopup.anchorX = 0.5
	starbucksPopup.y = _H*0.5
	starbucksPopup.x = _W*0.5
	starbucksPopup.alpha = 0

	sceneGroup:insert(starbucksPopup)





	local function openPopup (event)
		if event.phase == "ended" then

			transition.to( openPopButton, { time=250, delay = 0, alpha=0 } )
			transition.to( popShade, { time=250, delay = 0, alpha=0.9 } )
			transition.to( allDoneButton, { time=250, delay = 0, alpha=1 } )
			transition.to( starbucksPopup, { time=250, delay = 0, alpha=1 } )
		end
	end

	openPopButton = widget.newButton
	{
		width = 323,
		height = 115,
		defaultFile = "assets/buttons/100gc.png",
		overFile = "assets/buttons/100gcPress.png",
		onEvent = openPopup
	}

	openPopButton.x = _W*0.5 +5
	openPopButton.y = _H*0.5 - 185
	sceneGroup:insert(openPopButton)






	local function closePopup (event)
		if event.phase == "ended" then

			myGreenCoin = myGreenCoin - 100
			gcAmountText.text = myGreenCoin

			transition.to( openPopButton, { time=250, delay = 0, alpha=1 } )
			transition.to( popShade, { time=250, delay = 0, alpha=0 } )
			transition.to( allDoneButton, { time=250, delay = 0, alpha=0 } )
			transition.to( starbucksPopup, { time=250, delay = 0, alpha=0 } )
		end
	end

	allDoneButton = widget.newButton
	{
		width = 580,
		height = 115,
		defaultFile = "assets/buttons/allDone.png",
		overFile = "assets/buttons/allDonePress.png",
		onEvent = closePopup
	}

	allDoneButton.x = _W*0.5
	allDoneButton.y = _H*0.5+ 500
	allDoneButton.alpha = 0
	sceneGroup:insert(allDoneButton)





	local function goBack (event)
		if event.phase == "began" then
			allDoneButton:removeSelf()
			openPopButton:removeSelf()
			composer.gotoScene( "postDriveScreen", "fade", 400 )
		end
	end

	backButton:addEventListener( "touch", goBack )
	---------------------------------------
	---------------------------------------------------------------------------------
	---------------------------------------------------------------------------------
	-- FUNCTIONS
	---------------------------------------------------------------------------------
	---------------------------------------------------------------------------------
	---------------------------------------






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

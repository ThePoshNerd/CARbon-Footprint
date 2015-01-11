local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view


	slideGroup = display.newGroup()
	carGroup = display.newGroup()

	sceneGroup:insert( slideGroup )
	sceneGroup:insert( carGroup )




-----------------------------------------------------------
----------------Car Manufacturers-----------------------------
-----------------------------------------------------------


local carTypeMenu = display.newImage("assets/menus/carType/nissanLeafMenu.png", true)
carTypeMenu.anchorY = 0.5
carTypeMenu.anchorX = 0.5
carTypeMenu.y = _H*0.5
carTypeMenu.x = _W*0.5
slideGroup:insert(carTypeMenu)



local vehicle1 = display.newImage("assets/cars/nissan-leaf.png", true)
vehicle1.anchorY = 0
vehicle1.anchorx = 0
vehicle1.y = _H*0.5 - 350
vehicle1.x = _W*0.5
vehicle1.yScale = 1.5
vehicle1.xScale = 1.5
vehicle1.MPG = 113.5
vehicle1.name = "Nissan Leaf"
vehicle1.directory = "assets/cars/nissan-leaf.png"
carGroup:insert(vehicle1)

local vehicle2 = display.newImage("assets/cars/nissan-altima.png", true)
vehicle2.anchorY = 0
vehicle2.anchorx = 0
vehicle2.y = _H*0.5 - 250
vehicle2.x = _W*0.5 + 1080
vehicle2.yScale = 1.2
vehicle2.xScale = 1.2
vehicle2.MPG = 32.5
vehicle2.name = "Nissan Altima"
vehicle2.directory = "assets/cars/nissan-altima.png"
carGroup:insert(vehicle2)

local vehicle3 = display.newImage("assets/cars/nissan-frontier.png", true)
vehicle3.anchorY = 0
vehicle3.anchorx = 0
vehicle3.y = _H*0.5 - 350
vehicle3.x = _W*0.5 + 1080*2
vehicle3.yScale = 1
vehicle3.xScale = 1
vehicle3.MPG = 21
vehicle3.name = "Nissan Frontier"
vehicle3.directory = "assets/cars/nissan-frontier.png"
carGroup:insert(vehicle3)


vehicleMPG = 0







local preDriveButton = display.newImage("assets/checkmark.png", true)
preDriveButton.x = 990
preDriveButton.y = 80
sceneGroup:insert(preDriveButton)

local function goToDriveScreen (event)
	if event.phase == "began" then
		composer.gotoScene( "preDriveScreen", "fade", 400 )
	end
end

preDriveButton:addEventListener( "touch", goToDriveScreen )




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






---------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------





-----------------------------------------------------------
----------------Swipe Function-----------------------------
-----------------------------------------------------------

local swipeTouchObj = display.newRect( 0, 0, 1080, 1920 )
swipeTouchObj.x = _W*0.5
swipeTouchObj.y = _H*0.5
swipeTouchObj.alpha = 0.1
sceneGroup:insert(swipeTouchObj)


menuPos = 1
local lastPos = 0

local function saveGrpPos( event )
	beginGrpPos = carGroup.x
	--print(beginGrpPos)
end
timer.performWithDelay(0, saveGrpPos, 1)

local function transStop( event )
	if movement ~= nil then
		transition.cancel(movement)
	end
end

local xThreshold = 100

function screenSwipe( event )
local eventX = event.x
local phase = event.phase
if "began" == phase then
timer.performWithDelay(0, transStop, 1)
movePointX = 0
lastPos = eventX


elseif "moved" == phase then
movePointX = (event.x - event.xStart)
--print("X Moved: "..movePointX)
local dist = eventX-lastPos
carGroup.x = carGroup.x+(dist)
lastPos = eventX



elseif "ended" == phase or "cancelled" == phase then
--swipeTouchObj.alpha = 0

if movePointX < -xThreshold and menuPos == 1 then
	movement = transition.to(  carGroup, {  time=500, x = -1080, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos + 1
	print("The Main Menu is at Screen " .. menuPos)


elseif movePointX < -xThreshold and menuPos == 2 then
	movement = transition.to(  carGroup, {  time=500, x = -1080*2, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos + 1
	print("The Main Menu is at Screen " .. menuPos)



elseif movePointX > xThreshold and menuPos == 2 then
	movement = transition.to(  carGroup, {  time=500, x = 0, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos - 1
	print("The Main Menu is at Screen " .. menuPos)


elseif movePointX > xThreshold and menuPos == 3 then
	movement = transition.to(  carGroup, {  time=500, x = -1080, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos - 1
	print("The Main Menu is at Screen " .. menuPos)



else
	--print(beginGrpPos)

	--This is what causes the screen to 'spring' back when you're at the first or lst screen
	--
	if menuPos == 1 then
		transition.to(  carGroup, {  time=500, x = 0, transition = easing.outQuad } )
		elseif menuPos == 2 then
			transition.to(  carGroup, {  time=500, x = -1080, transition = easing.outQuad } )
			elseif menuPos == 3 then
				transition.to(  carGroup, {  time=500, x = -2160, transition = easing.outQuad } )
			end
		end
	end
end

swipeTouchObj:addEventListener( "touch", screenSwipe )


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

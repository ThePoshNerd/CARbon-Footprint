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

carGroup = display.newGroup()
sceneGroup:insert( carGroup )




-----------------------------------------------------------
----------------Car Manufacturers-----------------------------
-----------------------------------------------------------



local swipeTouchObj = display.newRect( 0, 0, 1080, 1920 )
swipeTouchObj.x = _W*0.5
swipeTouchObj.y = _H*0.5
swipeTouchObj.alpha = 0.1
sceneGroup:insert(swipeTouchObj)

local nissanLogo = display.newImage("assets/carLogos/nissan.png", true)
nissanLogo.anchorY = 0
nissanLogo.anchorx = 0
nissanLogo.y = 100
nissanLogo.x = _W*0.5
sceneGroup:insert(nissanLogo)

local vehicle1 = display.newImage("assets/cars/nissan-leaf.png", true)
vehicle1.anchorY = 0
vehicle1.anchorx = 0
vehicle1.y = _H*0.5
vehicle1.x = _W*0.5
carGroup:insert(vehicle1)




local function goToGPS (event)
	if event.phase == "began" then

	end
end

vehicle1:addEventListener( "touch", goToGPS )













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


menuPos = 1

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

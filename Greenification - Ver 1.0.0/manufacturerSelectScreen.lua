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

carMakeGroup = display.newGroup()
sceneGroup:insert( carMakeGroup )




-----------------------------------------------------------
----------------Car Manufacturers-----------------------------
-----------------------------------------------------------


local teslaButton = display.newRect( 0, 0, 1080, 340 )
teslaButton.x = _W*0.5
teslaButton.y = 345
teslaButton.alpha = 0.1
sceneGroup:insert(teslaButton)

local nissanButton = display.newRect( 0, 0, 1080, 340 )
nissanButton.x = _W*0.5
nissanButton.y = 345*2
nissanButton.alpha = 0.1
sceneGroup:insert(nissanButton)

local hondaButton = display.newRect( 0, 0, 1080, 340 )
hondaButton.x = _W*0.5
hondaButton.y = 345*3
hondaButton.alpha = 0.1
sceneGroup:insert(hondaButton)


local carMakeMenu = display.newImage("assets/menus/carMake.png", true)
carMakeMenu.anchorY = 0.5
carMakeMenu.anchorX = 0.5
carMakeMenu.y = _H*0.5
carMakeMenu.x = _W*0.5
carMakeGroup:insert(carMakeMenu)





local function goToNissanSelect (event)
	if event.phase == "began" then
		composer.gotoScene( "nissanSelectScreen", "fade", 400 )
	end
end

nissanButton:addEventListener( "touch", goToNissanSelect )

local function goToToyotaSelect (event)
	if event.phase == "began" then
		composer.gotoScene( "toyotaSelectScreen", "fade", 400 )
	end
end

--toyotaLogo:addEventListener( "touch", goToToyotaSelect )



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
	beginGrpPos = carMakeGroup.x
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
carMakeGroup.x = carMakeGroup.x+(dist)
lastPos = eventX



elseif "ended" == phase or "cancelled" == phase then
--swipeTouchObj.alpha = 0

if movePointX < -xThreshold and menuPos == 1 then
	movement = transition.to(  carMakeGroup, {  time=500, x = -1080, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos + 1
	print("The Main Menu is at Screen " .. menuPos)


elseif movePointX < -xThreshold and menuPos == 2 then
	movement = transition.to(  carMakeGroup, {  time=500, x = -1080*2, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos + 1
	print("The Main Menu is at Screen " .. menuPos)



elseif movePointX > xThreshold and menuPos == 2 then
	movement = transition.to(  carMakeGroup, {  time=500, x = 0, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos - 1
	print("The Main Menu is at Screen " .. menuPos)


elseif movePointX > xThreshold and menuPos == 3 then
	movement = transition.to(  carMakeGroup, {  time=500, x = -1080, transition = easing.outQuad, onComplete = saveGrpPos } )
	menuPos = menuPos - 1
	print("The Main Menu is at Screen " .. menuPos)



else
	--print(beginGrpPos)

	--This is what causes the screen to 'spring' back when you're at the first or lst screen
	--
	if menuPos == 1 then
		transition.to(  carMakeGroup, {  time=500, x = 0, transition = easing.outQuad } )
		elseif menuPos == 2 then
			transition.to(  carMakeGroup, {  time=500, x = -1080, transition = easing.outQuad } )
			elseif menuPos == 3 then
				transition.to(  carMakeGroup, {  time=500, x = -2160, transition = easing.outQuad } )
			end
		end
	end
end

--swipeTouchObj:addEventListener( "touch", screenSwipe )


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

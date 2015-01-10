local composer = require( "composer" )

local scene = composer.newScene()


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view




	local myMap = native.newMapView( 0, 0, 320, 480 )
	myMap.x = display.contentCenterX
	myMap.y = display.contentCenterY

	local locationTable  = myMap:getUserLocation()
	local locationtxt = display.newText( "My location is: ", 0, 0, native.systemFont, 16 )
	locationtxt.x = display.contentCenterX
	locationtxt.y = display.contentCenterY+ 500

	if ( locationTable.errorCode ) then
		locationtxt.text = locationtxt.text .. locationTable.errorMessage
	else
		locationtxt.text = locationtxt.text .. locationTable.latitude .. ", " ..locationTable.longitude
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

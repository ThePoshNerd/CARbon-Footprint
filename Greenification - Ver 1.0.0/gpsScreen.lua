local composer = require( "composer" )

local scene = composer.newScene()


-- "scene:create()"
function scene:create( event )

	local sceneGroup = self.view



	local fuelPrice = 2.75
	local milesDriven = 48

	local estimatedMPG = 24
	local estimatedFuelUsed
	local estimatedSpentOnFuel



		local function calcMPG()




			print("Estimated MPG: " .. estimatedMPG )

			estimatedFuelUsed = milesDriven/estimatedMPG
			print("Estimated Fuel Used: " .. estimatedFuelUsed .. " Gallons")

			estimatedSpentOnFuel = fuelPrice*estimatedFuelUsed
			print("Estimated Amount Spent on Fuel: " .. "$" .. estimatedSpentOnFuel )



		end

		calcMPG()





		--average
		--highest
		--lowest


		--leaderboards - highest mpg average over 50 miles, highest mpg over 100 miles
		-- achievements - Save $5, Save $10, Save $20, Save $50, Drive 50 miles using Greenification

		---coupons also pop up when you get Achievements













		function calcDist(lat1, lon1, lat2, lon2)
			lat1 = 37.989150
			lat2 = 37.997519
			lon1 = -122.076264
			lon2 = -121.715381

			dlon = lon2-lon1
			dlat = lat2-lat1

			a = math.pow(math.sin(dlat/2),2) + math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon/2),2)
			c = 2 * math.asin(math.sqrt(a))
			dist = 58.9 * c      -- multiply by 0.621371 to convert to miles
			print(dist)
			return dist
		end

		calcDist()



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

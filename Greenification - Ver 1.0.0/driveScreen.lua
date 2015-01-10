local composer = require( "composer" )

local scene = composer.newScene()

local save5Achieve = "CgkI-_Shl70OEAIQAg"
local save10Achieve = "CgkI-_Shl70OEAIQAw"
local save20Achieve = "CgkI-_Shl70OEAIQBA"

local drive25Achieve = "CgkI-_Shl70OEAIQBQ"
local drive50Achieve = "CgkI-_Shl70OEAIQBg"

local effUnder50Board = "CgkI-_Shl70OEAIQCQ"
local effOver50Board = "CgkI-_Shl70OEAIQAQ"
local moneySavedBoard = "CgkI-_Shl70OEAIQCA"


-- "scene:create()"
function scene:create( event )

  local sceneGroup = self.view








  local background = display.newRect( 0, 0, 1080, 1920 )
  background.x = _W*0.5
  background.y = _H*0.5
  sceneGroup:insert(background)

  local driveMenu = display.newImage("assets/menus/driveMenu.png", true)
  driveMenu.anchorY = 0.5
  driveMenu.anchorX = 0.5
  driveMenu.y = _H*0.5
  driveMenu.x = _W*0.5
  sceneGroup:insert(driveMenu)

  local endDriveButton = display.newImage("assets/checkmark.png", true)
  endDriveButton.x = 990
  endDriveButton.y = 80
  sceneGroup:insert(endDriveButton)


  local footprintText = display.newText( "0", 0, 0, native.systemFont, 200 )
  footprintText.x = _W*0.5
  footprintText.y = _H*0.5 - 570
  footprintText:setFillColor( 1, 1, 1 )
  footprintText.anchorX = 0.5
  sceneGroup:insert(footprintText)


  local moneySavedText = display.newText( "0", 0, 0, native.systemFont, 100 )
  moneySavedText.x = _W*0.5
  moneySavedText.y = _H*0.5 - 25
  moneySavedText:setFillColor( 1, 1, 1 )
  moneySavedText.anchorX = 0.5
  sceneGroup:insert(moneySavedText)

  local mpgText = display.newText( "0", 0, 0, native.systemFont, 100 )
  mpgText.x = _W*0.5 + 380
  mpgText.y = _H*0.5 - 20
  mpgText:setFillColor( .3, .3, .3 )
  mpgText.anchorX = 0.5
  sceneGroup:insert(mpgText)


  local milesDrivenText = display.newText( "0", 0, 0, native.systemFont, 100 )
  milesDrivenText.x = _W*0.5 - 380
  milesDrivenText.y = _H*0.5 - 20
  milesDrivenText:setFillColor( .3, .3, .3 )
  milesDrivenText.anchorX = 0.5
  sceneGroup:insert(milesDrivenText)







  local fuelPrice = 2.75
  local milesDriven = 0
  local mpgAverage = 0
  local mpgAverageTemp = 0

  local estimatedMPG = vehicleMPG or 55
  local estimatedFuelUsed
  local estimatedSpentOnFuel

  local simulatedMPG
  local simulatedFuelUsed
  local simulatedSpentOnFuel
  local simulatedFootprint = 0

  local moneyDifference
  local moneyDifferenceTemp = 0
  local moneyDifferenceRounded = 0



  local function achievementListener()

    if milesDriven == 25 then
      gameNetwork.request("unlockAchievement",
      {
        achievement =
        {
          identifier = drive25Achieve
        }
        })
      end

      if milesDriven == 50 then
        gameNetwork.request("unlockAchievement",
        {
          achievement =
          {
            identifier = drive50Achieve
          }
        })
      end
  end



  local function addSavings()

    local digits = 2
    local shift = 10 ^ digits


    moneyDifferenceRounded = math.floor( moneyDifference*shift + 0.5 )/shift
    moneyDifferenceTemp = moneyDifferenceTemp + moneyDifferenceRounded

    moneySavedText.text = ("$" .. moneyDifferenceTemp)

    if estimatedFuelUsed > simulatedFuelUsed then
      print("Total Savings: " .. "$" .. moneyDifferenceRounded)

    elseif estimatedFuelUsed < simulatedFuelUsed then
      print("Total Lost: " .. "$" .. math.abs(moneyDifferenceRounded))
    end
  end



  local function calcMPG()

    milesDriven = milesDriven + 1
    milesDrivenText.text = milesDriven

    if milesDriven >= 2 then

      --Actual Fuel Math Functions

      --print("Estimated MPG: " .. estimatedMPG )

      estimatedFuelUsed = milesDriven/estimatedMPG
      --print("Estimated Fuel Used: " .. estimatedFuelUsed .. " Gallons")
      --Exact number from the car's data

      estimatedSpentOnFuel = fuelPrice*estimatedFuelUsed --Exact Amount Spent of Fuel
      --print("Estimated Amount Spent on Fuel: " .. "$" .. estimatedSpentOnFuel )


      --Random Fuel Math Functions

      simulatedFuelUsed = math.random(100*estimatedFuelUsed*0.95, 100*estimatedFuelUsed*1.02) / 100
      --print("Simulated Fuel Used: " .. simulatedFuelUsed .. " Gallons")
      --Fudged number to show variation

      simulatedSpentOnFuel = fuelPrice*simulatedFuelUsed --Fudged Amount Spent of Fuel
      --print("Simulated Amount Spent on Fuel: " .. "$" .. simulatedSpentOnFuel )

      simulatedMPG = milesDriven/simulatedFuelUsed
      --print("Simulated MPG: " .. simulatedMPG )

      mpgText.text = math.round(simulatedMPG*10)*0.1



      simulatedFootprint = simulatedFootprint + math.random(1, 3)/1000

      footprintText.text = (simulatedFootprint .. " Tons" )



      mpgAverageTemp = mpgAverageTemp + simulatedMPG

      moneyDifference = (estimatedSpentOnFuel - simulatedSpentOnFuel)
      addSavings()
      achievementListener()
    end

  end

  calcMPG()
  local calcMpgTimer = timer.performWithDelay(1000, calcMPG, 0) --After every mile





    --average
    --highest
    --lowest


    --leaderboards - highest mpg average over 50 miles, highest mpg over 100 miles
    -- achievements - Save $5, Save $10, Save $20, Save $50, Drive 50 miles using Greenification

    ---coupons also pop up when you get Achievements


  local function postToLeaderboard(event)
    if event.phase == "began" then
      timer.cancel(calcMpgTimer)

      mpgAverage = math.round(mpgAverageTemp/milesDriven*10)*0.1
      print(mpgAverage)


      if milesDriven >= 2 and milesDriven <= 50 then
        gameNetwork.request("setHighScore",
        {
          localPlayerScore =
          {
            category = effUnder50Board, -- Id of the leaderboard to submit the score into
            value = mpgAverage -- The score to submit
          }
        })
      end

      if milesDriven >= 51 and milesDriven <= 100 then
          gameNetwork.request("setHighScore",
          {
            localPlayerScore =
            {
              category = effOver50Board, -- Id of the leaderboard to submit the score into
              value = mpgAverage -- The score to submit
            }
          })
      end

      --Publish Money Saved
      gameNetwork.request("setHighScore",
      {
        localPlayerScore =
        {
          category = moneySavedBoard, -- Id of the leaderboard to submit the score into
          value = moneyDifferenceTemp -- The score to submit
        }
      })
      print(moneyDifferenceTemp)

      composer.gotoScene( "postDriveScreen", "fade", 400 )
    end
  end


  endDriveButton:addEventListener( "touch", postToLeaderboard )








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

    --calcDist()



    local myMap = native.newMapView( 0, 0, 950, 480 )
    myMap.x = _H*0.5
    myMap.y = 1360
    myMap:setCenter( 36.999385, -122.053060 )

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

local composer = require( "composer" )
composer.removeScene( "preDriveScreen", false )
local scene = composer.newScene()

local save5Achieve = "CgkI-_Shl70OEAIQAg"
local save10Achieve = "CgkI-_Shl70OEAIQAw"
local save20Achieve = "CgkI-_Shl70OEAIQBA"

local drive25Achieve = "CgkI-_Shl70OEAIQBQ"
local drive50Achieve = "CgkI-_Shl70OEAIQBg"

local economyVeh5 = "CgkI-_Shl70OEAIQCw"
local economyVeh25 = "CgkI-_Shl70OEAIQCg"
local economyVeh50 = "CgkI-_Shl70OEAIQCQ"
local electricVeh = "CgkI-_Shl70OEAIQAQ"
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


  local footprintText = display.newText( "0", 0, 0, native.systemFont, 140 )
  footprintText.x = _W*0.5
  footprintText.y = _H*0.5 - 510
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



  local myMap = native.newMapView( 0, 0, 950, 480 )
  myMap.x = 540
  myMap.y = 1600
  myMap:setCenter( 36.999385, -122.053060 )
  sceneGroup:insert(myMap)






  local fuelPrice = 3.89
  local milesDriven = 0
  local mpgAverage = 0
  local mpgAverageTemp = 0

  local estimatedMPG =  7
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



  local function postToLeaderboard(event)

print(simulatedFootprintRounded)
    footprintAverage = simulatedFootprintRounded/milesDriven
    print(footprintAverage)

    if milesDriven == 5 then
      gameNetwork.request("setHighScore",
      {
        localPlayerScore =
        {
          category = economyVeh5, -- Id of the leaderboard to submit the score into
          value = simulatedFootprintRounded -- The score to submit
        }
        })
      end

      if milesDriven == 25 then
        gameNetwork.request("setHighScore",
        {
          localPlayerScore =
          {
            category = economyVeh25, -- Id of the leaderboard to submit the score into
            value = simulatedFootprintRounded -- The score to submit
          }
          })
        end

    if milesDriven == 50 then
      gameNetwork.request("setHighScore",
      {
        localPlayerScore =
        {
          category = economyVeh50, -- Id of the leaderboard to submit the score into
          value = simulatedFootprintRounded -- The score to submit
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
        --]]
        --Publish Money Saved

        moneySavedToSubmit = moneyDifferenceTemp*1000000
        gameNetwork.request("setHighScore",
        {
          localPlayerScore =
          {
            category = moneySavedBoard, -- Id of the leaderboard to submit the score into
            value = moneySavedToSubmit -- The score to submit
          }
          })
          print(moneySavedToSubmit)

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


  local speedNotif1 = display.newImage("assets/slowDown1.png", true)
  speedNotif1.anchorY = 0.5
  speedNotif1.anchorX = 0.5
  speedNotif1.y = _H*0.5
  speedNotif1.x = _W*0.5
  speedNotif1.alpha = 0
  sceneGroup:insert(speedNotif1)

  local speedNotif2 = display.newImage("assets/slowDown2.png", true)
  speedNotif2.anchorY = 0.5
  speedNotif2.anchorX = 0.5
  speedNotif2.y = _H*0.5
  speedNotif2.x = _W*0.5
  speedNotif2.alpha = 0
  sceneGroup:insert(speedNotif2)



  local function slowDownNotif()
    chooseSpeedNotif = math.random(10)

    if simulatedMPG < estimatedMPG then
      myMap.y = 3048
      if chooseSpeedNotif > 5 then
        transition.to( speedNotif1, { time=500, alpha=1} )
      else
        transition.to( speedNotif2, { time=500, alpha=1} )
    end

    else
      myMap.y = 1600
      transition.to( speedNotif1, { time=500, alpha=0} )
      transition.to( speedNotif2, { time=500, alpha=0} )

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

      simulatedMPG = math.random(100*milesDriven/estimatedFuelUsed*0.98, 100*milesDriven/estimatedFuelUsed*1.05) / 100

      print("Simulated MPG: " .. simulatedMPG )


      simulatedFuelUsed = milesDriven/simulatedMPG
      print("Simulated Fuel Used: " .. simulatedFuelUsed .. " Gallons")
      --Fudged number to show variation

      simulatedSpentOnFuel = fuelPrice*simulatedFuelUsed --Fudged Amount Spent of Fuel
      --print("Simulated Amount Spent on Fuel: " .. "$" .. simulatedSpentOnFuel )


      mpgText.text = math.round(simulatedMPG*10)*0.1



      simulatedFootprint = (simulatedFuelUsed/milesDriven  )         --*0.000453592 --http://www.eia.gov/tools/faqs/faq.cfm?id=307&t=11

      print(simulatedFootprint .. "ttest")



      local digits = 2
      local shift = 10 ^ digits

      simulatedFootprintRounded = ((math.floor( simulatedFootprint*shift + 0.5 )/shift)*milesDriven)

      footprintText.text = ((math.floor( (simulatedFootprintRounded*22.38) *shift + 0.5 )/shift) )



      mpgAverageTemp = mpgAverageTemp + simulatedMPG

      moneyDifference = (estimatedSpentOnFuel - simulatedSpentOnFuel)

      slowDownNotif()
      addSavings()
      achievementListener()
      postToLeaderboard()
    end

  end

  calcMPG()
  local calcMpgTimer = timer.performWithDelay(2000, calcMPG, 0) --After every mile





    --average
    --highest
    --lowest


    --leaderboards - highest mpg average over 50 miles, highest mpg over 100 miles
    -- achievements - Save $5, Save $10, Save $20, Save $50, Drive 50 miles using Greenification

    ---coupons also pop up when you get Achievements
local function endDrive (event)
    if event.phase == "began" then
      timer.cancel(calcMpgTimer)
      myMap:removeSelf()
      myGreenCoinEarned = 100
      myGreenCoin = myGreenCoin + myGreenCoinEarned
      composer.gotoScene( "postDriveScreen", "fade", 400 )
    end
  end

  endDriveButton:addEventListener( "touch", endDrive )










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
--[[
    local etst = display.newRect( 0, 0, 950, 480 )
    etst.x = _W*0.5
    etst.y = 1600
    sceneGroup:insert(etst)
--]]

    --[[
    local locationTable  = myMap:getUserLocation()
    local locationtxt = display.newText( "My location is: ", 0, 0, native.systemFont, 16 )
    locationtxt.x = display.contentCenterX
    locationtxt.y = display.contentCenterY+ 500

    if ( locationTable.errorCode ) then
      locationtxt.text = locationtxt.text .. locationTable.errorMessage
    else
      locationtxt.text = locationtxt.text .. locationTable.latitude .. ", " ..locationTable.longitude
    end
--]]

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

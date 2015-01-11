
display.setStatusBar( display.HiddenStatusBar )

_W = display.contentWidth
_H = display.contentHeight

gameNetwork = require "gameNetwork"
gameNetwork.init("google")

local composer = require "composer"

local splash = display.newImage("assets/splashLogo.png", true)
splash.anchorY = 0.5
splash.anchorX = 0.5
splash.y = _H*0.5
splash.x = _W*0.5
--carMakeGroup:insert(splash)

myGreenCoin = 0

local function carMakerScreen (event)
  splash:removeSelf()
  composer.gotoScene( "postDriveScreen", "fade", 400 )
end
transition.to( splash, { time=50, delay = 0, alpha=0, onComplete = carMakerScreen } )



--
--[[

ramUsage = display.newText( "0", 0, 0, native.systemFont, 100 )
ramUsage.x = _W*0.5+ 500 ; ramUsage.y = _H*0.5-500
ramUsage:setFillColor( 1, 1, 1 )
ramUsage.anchorX = 0

function memoryUsageTest()
  print("Memory USAGE: "..(system.getInfo("textureMemoryUsed")/1000000).." mb");
  ramUsage.text = (system.getInfo("textureMemoryUsed")/1000000)
end
--timer.performWithDelay(1000, memoryUsageTest, 0)
--]]

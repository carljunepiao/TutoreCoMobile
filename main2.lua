local composer = require("composer")
local scene = composer.newScene()
local myApp = require( "myapp" ) 
widget = require("widget")
require("newNavigationBar")
require("newPanel")

-------------------------------------------------------------------------------
--I DONT KNOW, I JUST COPIED THIS CODE IN THE INTARNIT!
if (display.pixelHeight/display.pixelWidth) > 1.5 then
    myApp.isTall = true
end

if display.contentWidth > 320 then
    myApp.is_iPad = true
end

-- display.setStatusBar( display.HiddenStatusBar )

math.randomseed(os.time())

-----------------------------------------------------------------------------------------
--LOAD IMAGES AND FONTS
local tabBarBackgroundFile = "images/tabbarBack1.png"
local tabBarLeft = "images/tabBar_tabSelectedLeft7.png"
local tabBarMiddle = "images/tabBar_tabSelectedMiddle7.png"
local tabBarRight = "images/tabBar_tabSelectedRight7.png"

myApp.topBarBg = "images/topBarBg7.png"

local iconInfo = {
    width = 40,
    height = 40,
    numFrames = 20,
    sheetContentWidth = 200,
    sheetContentHeight = 160
}

myApp.icons = graphics.newImageSheet("images/ios7icons.png", iconInfo)
myApp.font = "fonts/Roboto-Light.ttf"
myApp.fontBold = "fonts/Roboto-Regular.ttf"
myApp.fontItalic = "fonts/Roboto-LightItalic.ttf"
myApp.fontBoldItalic = "fonts/Roboto-Italic.ttf"

myApp.theme = "widget_theme_ios7"

if system.getInfo("platformName") == "Android" then
    myApp.topBarBg = "images/topBarBg7.png"

else
    local coronaBuild = system.getInfo("build")
    if tonumber(coronaBuild:sub(6,12)) < 1206 then
        myApp.theme = "widget_theme_ios"
    end

end
widget.setTheme(myApp.theme)

-----------------------------------------------------------------------------------------
------------------------------------------TAB BAR----------------------------------------
--Create an array for tabbars
myApp.tabBar = {}
-----------------------------------------------------------------------------------------
--EVENTS FOR TAB BAR BUTTONS
function myApp.showScreen1()
    myApp.tabBar:setSelected(1)
    composer.removeHidden()
    composer.gotoScene("findTutor", {time=250, effect="crossFade"})
    return true
end

function myApp.showScreen2(event)
    myApp.tabBar:setSelected(2)
    composer.removeHidden()
    composer.gotoScene("findTutee", {time=250, effect="crossFade"})
    return true
end

function myApp.showScreen3()
    myApp.tabBar:setSelected(3)
    local options = {
        pageTitle = "View Tutor"
    }
    composer.removeHidden()
    composer.gotoScene("viewTutor", {time=250, effect="crossFade", params = options})
    return true
end

-------------------------------------------------------------------------------------------
--EVENTS FOR BUTTONS IN NAVIGATION BAR
function handleMenuButton(event)
   if ( event.phase == "ended" ) then
      print( "Button 1" )
        panel:show()
        panel:toFront()
        composer.removeScene( "findTutor", true ) --Removes the scenes
   end
   return true
end

function handleLogoButton(event)
   if ( event.phase == "ended" ) then
      print( "Button Logo Clicked" )
        -- panel:show()
        -- panel:toFront()
   end
   return true
end

--SHOW TAB BUTTONS
local tabButtons = {
    {
        label = "Look for Tutor",
        defaultFile = "images/iconTutor.png",
        overFile = "images/iconTutore.png",
        labelColor = { 
            default = { 255/255, 255/255, 255/255 }, 
            over = {  0.698039, 0.133333, 0.133333  }
        },
        width = 32,
        height = 29,
        onPress = myApp.showScreen1,
        selected = true,
    },
    {
        label = "Look for Tutee",
        defaultFile = "images/iconTutee.png",
        overFile = "images/iconTuteer.png",
        labelColor = { 
            default = { 255/255, 255/255, 255/255 }, 
            over = { 0.698039, 0.133333, 0.133333 }
        },
        width = 32,
        height = 29,
        onPress = myApp.showScreen2,
    },
    {
        label = "View Tutors",
        defaultFile = "images/menu.png",
        overFile = "images/iconTutor.png",
        labelColor = { 
            default = { 255/255, 255/255, 255/255 }, 
            over = { 0.698039, 0.133333, 0.133333}
        },
        width = 32,
        height = 28,
        onPress = myApp.showScreen3,
    },
}

--CREATE TAB BAR
myApp.tabBar = widget.newTabBar{
    top =  display.contentHeight - 50,
    left = 0,
    width = display.contentWidth,
    
    tabSelectedLeftFile = tabBarLeft,      -- New
    tabSelectedRightFile = tabBarRight,    -- New
    tabSelectedMiddleFile = tabBarMiddle,      -- New
    tabSelectedFrameWidth = 20,                                         -- New
    tabSelectedFrameHeight = 50,                                        -- New    
    buttons = tabButtons,
    height = 50,
    backgroundFile="images/tabbarBack1.png"
}
---------------------------------------------------------------------------------------------
------------------------------------------SLIDE PANEL----------------------------------------
panel = widget.newPanel
{
    location = "left",
    onComplete = panelTransDone,
    width = display.contentWidth*0.8,
    height = display.contentHeight,
    speed = 500,
    inEasing = easing.outBack,
    outEasing = easing.outCubic
}

panel.background = display.newRect( 0, 0, 360, 568 )
panel.background:setFillColor( 0.3, 0.3, 0.3, 0.9 )
panel:insert( panel.background )

panel.item1 = display.newText( "Item1", 0, 0, native.systemFontBold, 10 )
panel.item1:setFillColor( 1, 1, 0 )
panel:insert( panel.item1 )


---------------------------------------------------------------------------------------------
------------------------------------------NAVIGATION BAR-------------------------------------
local navBar = widget.newNavigationBar({
   background =  "images/tabbarBack1.png",
   titleColor = {255/255, 215/255, 0},
   menuButton = {
      onEvent = handleMenuButton,
      width = 35,
      height = 30,
      defaultFile = "images/hamburger.png",
      overFile = "images/showbutton_over1.png",
    },
    logoButton = {
      onEvent = handleLogoButton,
      width = 150,
      height = 40,
      defaultFile = "tutorecoicon_horizontal.png",
    },
   includeStatusBar = true
})


function scene:create( event )
    local sceneGroup = self.view
    composer.gotoScene("findTutor", {time=250, effect="crossFade"})
end


scene:addEventListener( "create" )

return scene
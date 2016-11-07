function widget.newNavigationBar( options )
   local customOptions = options or {}
   local opt = {}

   opt.left = customOptions.left or nil
   opt.top = customOptions.top or nil
   opt.width = customOptions.width or display.contentWidth
   opt.height = customOptions.height or 50
   
   if ( customOptions.includeStatusBar == nil ) then
      opt.includeStatusBar = true  -- assume status bars for business apps
   else
      opt.includeStatusBar = customOptions.includeStatusBar
   end
 
   -- Determine the amount of space to adjust for the presense of a status bar
   local statusBarPad = 0
   if ( opt.includeStatusBar ) then
      statusBarPad = display.topStatusBarContentHeight
   end
 
   opt.x = customOptions.x or display.contentCenterX
   opt.y = customOptions.y or (opt.height + statusBarPad) * 0.5
   opt.id = customOptions.id
   opt.isTransluscent = customOptions.isTransluscent or true
   opt.background = customOptions.background
   opt.backgroundColor = customOptions.backgroundColor
   opt.title = customOptions.title or ""
   opt.titleColor = customOptions.titleColor or { 0, 0, 0 }
   opt.font = customOptions.font or native.systemFontBold
   opt.fontSize = customOptions.fontSize or 18
   opt.menuButton = customOptions.menuButton or nil
   opt.logoButton = customOptions.logoButton or nil
 
   -- If "left" and "top" parameters are passed, calculate the X and Y
   if ( opt.left ) then
      opt.x = opt.left + opt.width * 0.5
   end
   if ( opt.top ) then
      opt.y = opt.top + (opt.height + statusBarPad) * 0.5
   end

   local barContainer = display.newGroup()
   local background = display.newRect( barContainer, opt.x, opt.y, opt.width, opt.height + statusBarPad )
   if ( opt.background ) then
      background.fill = { type="image", filename=opt.background }
   elseif ( opt.backgroundColor ) then
      background.fill = opt.backgroundColor
   else
      background.fill = { 1, 1, 1 } 
   end

   if ( opt.title ) then 
      local title = display.newText( opt.title, background.x, background.y + statusBarPad * 0.5, opt.font, opt.fontSize )
      title:setFillColor( unpack(opt.titleColor) )
      barContainer:insert( title )
   end

   local menuButton
   if ( opt.menuButton ) then
      if ( opt.menuButton.defaultFile ) then  -- construct an image button
         menuButton = widget.newButton({
            id = opt.menuButton.id,
            width = opt.menuButton.width,
            height = opt.menuButton.height,
            baseDir = opt.menuButton.baseDir,
            defaultFile = opt.menuButton.defaultFile,
            overFile = opt.menuButton.overFile,
            onEvent = opt.menuButton.onEvent
            })
      else  -- else, construct a text button
         menuButton = widget.newButton({
            id = opt.menuButton.id,
            label = opt.menuButton.label,
            onEvent = opt.menuButton.onEvent,
            font = opt.menuButton.font or opt.font,
            fontSize = opt.fontSize,
            labelColor = opt.menuButton.labelColor or { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            labelAlign = "left",
            })
      end
      menuButton.x = 15 + menuButton.width * 0.5
      menuButton.y = 45
      barContainer:insert( menuButton )  -- insert button into container group
   end
 
   local logoButton
   if ( opt.logoButton ) then
      if ( opt.logoButton.defaultFile ) then  -- construct an image button
         logoButton = widget.newButton({
            id = opt.logoButton.id,
            width = opt.logoButton.width,
            height = opt.logoButton.height,
            baseDir = opt.logoButton.baseDir,
            defaultFile = opt.logoButton.defaultFile,
            overFile = opt.logoButton.overFile,
            onEvent = opt.logoButton.onEvent
            })
      else  -- else, construct a text button
         logoButton = widget.newButton({
            id = opt.logoButton.id,
            label = opt.logoButton.label or "Default",
            onEvent = opt.logoButton.onEvent,
            font = opt.menuButton.font or opt.font,
            fontSize = opt.fontSize,
            labelColor = opt.logoButton.labelColor or { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            labelAlign = "right",
            })
      end
      logoButton.x = display.contentWidth - ( 80 + logoButton.width * 0.5 )
      logoButton.y = 45
      barContainer:insert( logoButton )  -- insert button into container group
    end
 
    return barContainer
end
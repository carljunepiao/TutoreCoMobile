local widget = require( "widget" )
 
local myText = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque semper mollis erat a interdum. Praesent tristique diam in nulla varius, nec aliquet mauris posuere. Suspendisse pretium risus lacus, commodo lacinia sapien dictum et. Sed non varius felis. Curabitur elementum tortor non libero pulvinar, at convallis lectus varius. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur sit amet nunc congue, molestie erat vel, facilisis turpis. Morbi vitae diam ligula. Suspendisse purus turpis, commodo in aliquam id, lobortis a sapien. Sed at libero porta, aliquam odio nec, porta dui. In a congue velit. Aliquam ac quam feugiat, ultricies metus nec, porta neque. Phasellus posuere mollis magna, ac vestibulum ligula congue id. Pellentesque imperdiet aliquam lacus, ac pellentesque dui eleifend nec. Suspendisse auctor vehicula facilisis. Pellentesque id massa tincidunt neque luctus varius.
 
Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas sit amet dapibus nulla. Suspendisse ut risus nulla. Maecenas varius elit non faucibus fermentum. Fusce rhoncus, nisl et varius tristique, enim felis egestas purus, et feugiat lorem urna a augue. Maecenas non pulvinar tortor. Aenean condimentum nibh id eros fringilla viverra. Fusce condimentum urna ut volutpat porttitor. Nunc tincidunt congue ligula.
 
Duis placerat felis varius, convallis massa sed, volutpat magna. Sed vitae viverra neque. Integer ac sollicitudin libero, at ornare purus. Aliquam egestas hendrerit tellus. Aliquam eu elit vitae lorem lacinia tempus. Proin vel dictum mi. Maecenas porttitor, justo a dictum volutpat, nisl libero dictum ligula, vitae posuere urna elit a quam. Nam arcu metus, semper suscipit pellentesque ac, tempor ut arcu. Vestibulum eu nibh erat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed semper sollicitudin lorem, vel commodo libero commodo eget. Proin lacinia euismod elit vitae porttitor. Proin ipsum neque, dictum at dictum eu, egestas malesuada turpis. Nulla eros lectus, adipiscing eget velit sed, malesuada aliquam ipsum. Curabitur et egestas massa. Vestibulum luctus est est, tincidunt viverra nisi vulputate id.
 
Integer lobortis tellus eu ligula viverra egestas. Quisque commodo, massa vel pretium imperdiet, nisl enim euismod justo, sed ultricies lacus mi ut nisi. Maecenas molestie vitae magna non interdum. In gravida ornare orci in vulputate. Praesent suscipit lobortis dui ut interdum. Proin pulvinar metus ligula, a malesuada nunc interdum at. Aenean et scelerisque enim. Integer eget congue sapien. Etiam suscipit mauris neque, id semper quam volutpat vel. Proin venenatis dictum felis quis ultricies. Suspendisse feugiat mi congue ante gravida, id accumsan leo mollis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In hac habitasse platea dictumst. Nulla facilisi.
 
Nam arcu mauris, convallis sit amet dictum consequat, imperdiet at mi. Vestibulum velit erat, accumsan sit amet vehicula vitae, tempor id nisi. Quisque eu tellus vulputate nisi vestibulum tincidunt at vitae tellus. Quisque sed pretium nisl. Vivamus a aliquet purus. Integer pulvinar neque in dapibus pharetra. Quisque convallis urna vulputate ligula mattis dictum. Vivamus pharetra molestie nunc, ac rhoncus dolor euismod at. Cras fringilla sollicitudin sapien vel sagittis. Donec dignissim scelerisque mi nec pulvinar. Mauris at metus gravida, lacinia dolor quis, vehicula lacus. Donec a pellentesque tellus. Praesent sit amet lorem nisl. Pellentesque interdum felis quis vehicula vestibulum. Donec ut dolor tortor.
]]
 
local paragraphs = {}
local paragraph
local tmpString = myText
 
local scrollView = widget.newScrollView
{
    top = 0,
    left = 0,
    width = display.contentWidth,
    height = display.contentHeight,
    scrollWidth = display.contentWidth,
    scrollHeight = 8000
}
 
local options = {
    text = "",
    width = 300,
    font = "HelveticaNeue",
    fontSize = 12,
    align = "left"
}
 
local yOffset = 10
 
repeat
    paragraph, tmpString = string.match( tmpString, "([^\n]*)\n(.*)" )
    options.text = paragraph
    paragraphs[#paragraphs+1] = display.newText( options )
    paragraphs[#paragraphs].anchorX = 0
    paragraphs[#paragraphs].anchorY = 0
    paragraphs[#paragraphs].x = 10
    paragraphs[#paragraphs].y = yOffset
    paragraphs[#paragraphs]:setFillColor( 0 )
    scrollView:insert( paragraphs[#paragraphs] )
    yOffset = yOffset + paragraphs[#paragraphs].height
    print( #paragraphs, paragraph )
until tmpString == nil or string.len( tmpString ) == 0
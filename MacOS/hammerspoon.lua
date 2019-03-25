hyper = {"ctrl","cmd"}
hs.window.animationDuration=0

hs.hotkey.bind(hyper, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  if( win:isFullScreen() ) then
    win:setFullScreen(false)
  elseif (f.x == max.x and f.y == max.y and f.h == max.h and f.w == max.w) then
    win:setFullScreen(true)
  else
    win:setFrame(screen:fullFrame())
  end
end)

hs.hotkey.bind(hyper, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  if( win:isFullScreen() ) then
    win:setFullScreen(false)
  elseif (f.x == max.x and f.y == max.y and f.h == max.h and f.w == max.w) then
    win:setFullScreen(true)
  else
    win:setFrame(screen:fullFrame())
  end
end)

hs.hotkey.bind(hyper, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if( win:isFullScreen() ) then
    win:setFullScreen(false)
  else
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  end
end)

hs.hotkey.bind(hyper, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()
  if( win:isFullScreen() ) then
    win:setFullScreen(false)
  else
    f.x = max.x + max.w/2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
  end

end)


hyper2 = {"ctrl","cmd"} -- Resize window
hyper3 = {"ctrl","alt","cmd"} -- Move window to another monitor
hs.window.animationDuration=0 -- Disable animation

hs.hotkey.bind(hyper2, "Up", function()
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

hs.hotkey.bind(hyper2, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if( win:isFullScreen() ) then
    win:setFullScreen(false)
  else
    f.x = max.w / 7
    f.y = max.h / 7
    f.w = max.w / 1.5
    f.h = max.h / 1.5
    win:setFrame(f)
  end
end)

hs.hotkey.bind(hyper2, "Left", function()
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

hs.hotkey.bind(hyper2, "Right", function()
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

function nextScreen()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if( win:isFullScreen() ) then
    win:setFullScreen(false)
  end
  win:moveToScreen(screen:next())
  hs.timer.doAfter(1, function()
    win:setFullScreen(true)
  end)
end

hs.hotkey.bind(hyper3, "Up", nextScreen)
hs.hotkey.bind(hyper3, "Down", nextScreen)
hs.hotkey.bind(hyper3, "Right", nextScreen)
hs.hotkey.bind(hyper3, "Left", nextScreen)

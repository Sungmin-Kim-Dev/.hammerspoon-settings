local workMacro = {}

-- alert 스타일 받아오기
local alertStyle = {}
function workMacro.styleSetup(style)
  alertStyle = style
end

-- 매크로 기능 활성화 상태 추적
local workMacroEnabled = false

-- 메뉴바에 표시
workMacro.workMacroMenubar = hs.menubar.new(true, "workHotkeys")

function workMacro.updateWorkMacroMenubar(enabled)
  if enabled then
    workMacro.workMacroMenubar:setTitle("🟢W")
  else
    workMacro.workMacroMenubar:setTitle("⚫️W")
  end
end

-- 알림 표시 함수
local function showWorkMacroAlert(enabled)
  local message = enabled and "Work Macro ON!" or "Work Macro OFF!"
  return hs.alert.show(message, alertStyle, 1)
end

local function setHotkeysState(workHotkeys, enabled)
  for _, hotkey in ipairs(workHotkeys) do
    if enabled then
      hotkey:enable()
    else
      hotkey:disable()
    end
  end
end

function workMacro.toggleWorkMacros(workHotkeys)
  workMacroEnabled = not workMacroEnabled
  setHotkeysState(workHotkeys, workMacroEnabled)
  showWorkMacroAlert(workMacroEnabled)
  workMacro.updateWorkMacroMenubar(workMacroEnabled)
end

-- -- 매크로 토글 함수
-- function workMacro.toggleWorkMacros(workHotkeys)
--   if workMacroEnabled then
--     for _, hotkey in ipairs(workHotkeys) do
--       hotkey:disable()
--     end
--     workMacroEnabled = false
--   else
--     for _, hotkey in ipairs(workHotkeys) do
--       hotkey:enable()
--     end
--     workMacroEnabled = true
--   end
--   showWorkMacroAlert(workMacroEnabled)
--   workMacro.updateWorkMacroMenubar(workMacroEnabled)
-- end

return workMacro

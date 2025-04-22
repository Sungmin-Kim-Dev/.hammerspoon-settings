local alert = {}

local hyperAlert = nil
local hyperQAlert = nil
local hyperTAlert = nil

-- alert 스타일 받아오기
local alertStyle = {}
function alert.styleSetup(style)
  alertStyle = style
end

function alert.showHyperAlert()
  hyperAlert = hs.alert.show("❇️ Hyper", alertStyle, 'indefinite')
end

function alert.showHyperQAlert()
  hs.alert.closeSpecific(hyperAlert)
  hyperQAlert = hs.alert.show("❇️ Hyper 🟩", alertStyle, 'indefinite')
end

function alert.showHyperTAlert()
  hyperTAlert = hs.alert.show("❇️ Hyper ⌨️", {
    alertStyle,
    atScreenEdge = 2
  }, 'indefinite')
end

function alert.closeHyperTAlert()
  hs.alert.closeSpecific(hyperTAlert)
  hyperTAlert = nil
end

function alert.closeHyperAlert()
  if hyperAlert then
    hs.alert.closeSpecific(hyperAlert)
    -- hs.alert.closeAll(0.3)
    hyperAlert = nil
  end
  if hyperQAlert then
    hs.alert.closeSpecific(hyperQAlert)
    hyperQAlert = nil
    -- alert.showHyperAlert()
  end
end

return alert

-- 하이퍼 키는 Karabiner에서 감지로 바꿈
-- 코드는 상당히 괜찮아서 일단 보관
-- Hyper 키 상태 감지를 위한 변수
-- local hyperMode = false

-- Hyper 키 모드 알림
-- local hyperModeAlert = nil

-- 키 이벤트 감지
-- hyperModeWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
--   local flags = event:getFlags()

--   -- Hyper 키 조합 (Command + Option + Shift + Control)이 눌렸는지 확인
--   local isHyperDown = flags.cmd and flags.alt and flags.shift and flags.ctrl

--   if isHyperDown and not hyperMode then
--     -- Hyper 모드 켜짐
--     hyperMode = true
--     if hyperModeAlert then
--       hyperModeAlert:withdraw()
--     end
--     hyperModeAlert = hs.alert.show("🅷 Hyper!", {}, 'indefinite')
--   elseif not isHyperDown and hyperMode then
--     -- Hyper 모드 꺼짐
--     hyperMode = false
--     if hyperModeAlert then
--       hs.alert.closeSpecific(hyperModeAlert)
--       hyperModeAlert = nil
--     end
--   end

--   return false
-- end)
-- hyperModeWatcher:start()


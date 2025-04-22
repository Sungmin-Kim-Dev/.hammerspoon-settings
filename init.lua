-- 외부 파일 가져오기
local alert = require("hyperAlert")
local macroFunctions = require("macroFunctions")
local workMacro = require("workMacro")

-- alert 스타일 설정
local alertStyle = {
  strokeColor = {
    white = 1,
    alpha = 0.5
  },
  radius = 30,
  fadeOutDuration = 0.3,
  padding = 15
}
-- 각 파일에 alert 스타일 추가
alert.styleSetup(alertStyle)
workMacro.styleSetup(alertStyle)

-- 하이퍼 키 알림
hs.urlevent.bind("showHyperAlert", alert.showHyperAlert)
hs.urlevent.bind("showHyperQAlert", alert.showHyperQAlert)
hs.urlevent.bind("closeHyperAlert", alert.closeHyperAlert)
hs.urlevent.bind("showHyperTAlert", alert.showHyperTAlert)
hs.urlevent.bind("closeHyperTAlert", alert.closeHyperTAlert)

-- workMacro 시작
-- 매크로 핫키 객체를 저장할 테이블
local workHotkeys = {hs.hotkey.bind({}, "`", macroFunctions.openDict):disable(),
                     hs.hotkey.bind({"shift"}, "`", macroFunctions.searchDict):disable(),
                     hs.hotkey.bind({"cmd"}, ";", macroFunctions.googleSearch):disable()}

-- Hyper+W 키를 눌렀을 때 매크로 토글
hs.urlevent.bind("toggleWorkMacros", function()
  workMacro.toggleWorkMacros(workHotkeys)
end)
-- 메뉴바 로딩 시 실행
workMacro.updateWorkMacroMenubar(false)
-- 메뉴바 클릭시 토글
workMacro.workMacroMenubar:setClickCallback(function()
  workMacro.toggleWorkMacros(workHotkeys)
end)

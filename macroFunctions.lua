local macroFunctions = {}
-- 백틱 매크로 함수
-- Safari 열고 네이버 사전 탭으로 이동
function macroFunctions.openDict()
  local currentApp = hs.application.frontmostApplication():name()

  if currentApp == "Safari" then
    -- Safari일 경우 → 이전 앱으로 전환
    -- cmd+tab 누름
    hs.eventtap.event.newKeyEvent({"cmd"}, "tab", true):post()
    hs.eventtap.event.newKeyEvent({"cmd"}, "tab", false):post()
    -- cmd 떼기 (정확하게 modifier 단독으로)
    hs.timer.doAfter(0.1, function()
      hs.eventtap.event.newKeyEvent("cmd", false):post()
    end)

  else
    -- Safari가 아닐 경우 → Safari 실행 후 Cmd+2
    hs.application.launchOrFocus("Safari")
    hs.timer.doAfter(0.5, function()
      hs.eventtap.keyStroke({"cmd"}, "2")
    end)
  end
end

-- 시프트+백틱 매크로:
-- Cmd+C -> 사파리 활성화 -> 두 번째 탭 -> 'a' 입력 후 백스페이스 -> Cmd+V
function macroFunctions.searchDict()
  local steps = {}

  -- 단계 정의
  steps[1] = function()
    -- 복사
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.doAfter(0.3, function()
      steps[2]()
    end)
  end

  steps[2] = function()
    -- 사파리 활성화
    hs.application.launchOrFocus("Safari")
    hs.timer.doAfter(0.5, function()
      steps[3]()
    end)
  end

  steps[3] = function()
    -- 두 번째 탭으로 이동
    hs.eventtap.keyStroke({"cmd"}, "2")
    hs.timer.doAfter(0.3, function()
      steps[4]()
    end)
  end

  steps[4] = function()
    -- 'a' 입력
    hs.eventtap.keyStrokes("a")
    hs.timer.doAfter(0.2, function()
      steps[5]()
    end)
  end

  steps[5] = function()
    -- 백스페이스로 삭제
    hs.eventtap.keyStroke({}, "delete")
    hs.timer.doAfter(0.3, function()
      steps[6]()
    end)
  end

  steps[6] = function()
    -- 붙여넣기 및 검색 실행
    hs.eventtap.keyStroke({"cmd"}, "v")
    hs.eventtap.keyStroke({}, "return")
  end

  -- 시작
  steps[1]()
end

-- 검색 수행 함수
local function performSearch()
  -- Safari의 3번째 탭으로 이동 (Safari에서는 Command+숫자로 탭 전환)
  hs.eventtap.keyStroke({"cmd"}, "3")

  -- 약간의 지연 후 검색 실행
  hs.timer.doAfter(0.2, function()
    -- 주소 표시줄 선택 (Ctrl+L)
    hs.eventtap.keyStroke({"cmd"}, "l")

    -- 새 검색어 붙여넣기 (Command+V)
    hs.eventtap.keyStroke({"cmd"}, "v")

    -- Enter 입력하여 검색 실행
    hs.eventtap.keyStroke({}, "return")
  end)
end

-- 선택한 텍스트로 구글 검색
function macroFunctions.googleSearch()
  -- 현재 선택된 텍스트 복사
  hs.eventtap.keyStroke({"cmd"}, "c")
  -- 복사된 텍스트가 클립보드에 들어갈 시간을 주기 위해 약간 지연
  hs.timer.doAfter(0.1, function()
    -- Safari 앱 활성화
    hs.application.launchOrFocus("Safari")
    hs.timer.doAfter(0.5, performSearch)
  end)
end

return macroFunctions

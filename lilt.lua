-- 릴트 툴 오류 때 썼음
-- hs.hotkey.bind({"control"}, "A", function() -- pagedown
--   -- 첫 번째 반복부터 시작 (카운터 = 1)
--   executeSequence(1)
-- end)
-- 전체 시퀀스를 실행하는 함수
function executeSequence(repeatCount)
  local totalCount = 7 -- 630
  if repeatCount > totalCount then
    print("매크로 ", totalCount, "회 완료.")
    return -- 100번 반복 완료 후 종료
  end
  if repeatCount % 5 == 0 then
    local milestone = "진행 상황: " .. repeatCount .. "/" .. totalCount
    print(milestone)
  end
  if repeatCount == 1 then
    print(totalCount, "매크로 시작")
  end
  -- 현재 마우스 위치 가져오기
  local currentPos = hs.mouse.absolutePosition()

  -- 커서를 오른쪽으로 이동 (예: 10픽셀)
  if repeatCount % 2 == 1 then
    local newPos = {
      x = currentPos.x + 30,
      y = currentPos.y
    }
    hs.eventtap.leftClick(hs.mouse.absolutePosition(newPos))
  else
    local newPos = {
      x = currentPos.x - 30,
      y = currentPos.y
    }
    hs.eventtap.leftClick(hs.mouse.absolutePosition(newPos))
  end

  -- 1. 현재 마우스 위치에서 좌클릭 수행

  -- 1초 딜레이
  hs.timer.doAfter(1, function()
    -- 2. Command+A (전체선택)
    hs.eventtap.keyStroke({"cmd"}, "a")

    -- 1초 딜레이
    hs.timer.doAfter(0.5, function()
      -- 3. Backspace (삭제)
      hs.eventtap.keyStroke({}, "delete")

      -- 1초 딜레이
      hs.timer.doAfter(2, function()
        -- 4. Command+Option+N
        hs.eventtap.keyStroke({"cmd", "alt"}, "n")

        -- 1초 딜레이
        hs.timer.doAfter(1.5, function()
          -- 5. Command+Enter
          hs.eventtap.keyStroke({"cmd"}, "return")

          -- 0.5초 딜레이
          hs.timer.doAfter(2, function()
            -- 6. Command+아래 화살표
            hs.eventtap.keyStroke({"cmd"}, "down")

            -- 한 시퀀스가 완료되면 1.5초 딜레이 후 다음 반복 시작
            hs.timer.doAfter(3, function()
              executeSequence(repeatCount + 1)
            end)
          end)
        end)
      end)
    end)
  end)
end

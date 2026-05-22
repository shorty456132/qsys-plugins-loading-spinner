if Controls then

EzSVG    = require("EzSVG")
rapidjson = require("rapidjson")

local ColorMap = {
  White  = "#FFFFFF",
  Blue   = "#4499FF",
  Green  = "#44FF88",
  Red    = "#FF5555",
  Orange = "#FF8844",
  Cyan   = "#44FFFF"
}

local DOC_SIZE    = 100
local CX, CY      = 50, 50
local INNER_R     = 20
local OUTER_R     = 42
local SPOKE_COUNT = 12
local SPOKE_WIDTH = 4
local FRAME_RATE  = 0.08  -- seconds per frame; full rotation = 12 * 0.08 ≈ 1s

SpinnerStep = 0
IsRunning   = false

AnimTimer     = Timer.New()
DurationTimer = Timer.New()

local function GetSpinnerColor()
  return ColorMap[Properties["Color"].Value] or "#FFFFFF"
end

local function RenderSpinner(running)
  local doc   = EzSVG.Document(DOC_SIZE, DOC_SIZE)
  local color = GetSpinnerColor()

  doc:add(EzSVG.Rect(0, 0, DOC_SIZE, DOC_SIZE)
    :setStyle("fill", "#1C1C1C")
    :setStyle("stroke_width", 0))

  local angleStep = 360 / SPOKE_COUNT
  for i = 0, SPOKE_COUNT - 1 do
    local idx      = (SpinnerStep + i) % SPOKE_COUNT
    local opacity  = running and ((i + 1) / SPOKE_COUNT) or 0.12
    local angleRad = math.rad(idx * angleStep - 90)

    local x1 = CX + math.cos(angleRad) * INNER_R
    local y1 = CY + math.sin(angleRad) * INNER_R
    local x2 = CX + math.cos(angleRad) * OUTER_R
    local y2 = CY + math.sin(angleRad) * OUTER_R

    doc:add(EzSVG.Line(x1, y1, x2, y2)
      :setStyle("stroke", color)
      :setStyle("stroke_width", SPOKE_WIDTH)
      :setStyle("stroke_opacity", opacity)
      :setStyle("stroke_linecap", "round"))
  end

  local svgStr = doc:toString()
  Controls.Display.Legend = rapidjson.encode({
    DrawChrome = false,
    IconData   = Crypto.Base64Encode(svgStr)
  })
end

AnimTimer.EventHandler = function()
  SpinnerStep = (SpinnerStep + 1) % SPOKE_COUNT
  RenderSpinner(true)
end

DurationTimer.EventHandler = function()
  DurationTimer:Stop()
  IsRunning = false
  AnimTimer:Stop()
  RenderSpinner(false)
  Controls.Expired.Value = 1
  print("Spinner: expired after " .. tostring(Properties["Duration"].Value) .. "s")
end

Controls.Start.EventHandler = function()
  IsRunning = true
  SpinnerStep = 0
  AnimTimer:Stop()
  DurationTimer:Stop()
  AnimTimer:Start(FRAME_RATE)
  DurationTimer:Start(Properties["Duration"].Value)
  print("Spinner: started (duration=" .. tostring(Properties["Duration"].Value) .. "s)")
end

RenderSpinner(false)

end

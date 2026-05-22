function GetControls(props)
  local ctrls = {}
  table.insert(ctrls, {
    Name        = "Start",
    ControlType = "Button",
    ButtonType  = "Trigger",
    Count       = 1,
    UserPin     = true,
    PinStyle    = "Input"
  })
  table.insert(ctrls, {
    Name        = "Expired",
    ControlType = "Button",
    ButtonType  = "Trigger",
    Count       = 1,
    UserPin     = true,
    PinStyle    = "Output"
  })
  table.insert(ctrls, {
    Name        = "Display",
    ControlType = "Button",
    ButtonType  = "Toggle",
    Count       = 1,
    UserPin     = false,
    PinStyle    = "None"
  })
  return ctrls
end

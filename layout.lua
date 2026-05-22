function GetControlLayout(props)
  local layout   = {}
  local graphics = {}

  table.insert(graphics, {
    Type     = "GroupBox",
    Text     = "Loading Spinner",
    Position = { 0, 0 },
    Size     = { 200, 225 }
  })

  layout["Display"] = {
    PrettyName  = "Spinner Display",
    Style       = "Button",
    ButtonStyle = "Toggle",
    Position    = { 20, 20 },
    Size        = { 160, 160 }
  }

  layout["Start"] = {
    PrettyName  = "Start",
    Style       = "Button",
    ButtonStyle = "Trigger",
    Legend      = "Start",
    Position    = { 10, 193 },
    Size        = { 85, 24 }
  }

  layout["Expired"] = {
    PrettyName  = "Expired",
    Style       = "Button",
    ButtonStyle = "Trigger",
    Legend      = "Expired",
    Position    = { 105, 193 },
    Size        = { 85, 24 }
  }

  return layout, graphics
end

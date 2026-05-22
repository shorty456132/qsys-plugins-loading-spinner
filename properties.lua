function GetProperties()
  local props = {}
  table.insert(props, {
    Name  = "Duration",
    Type  = "integer",
    Value = 10,
    Min   = 1,
    Max   = 600
  })
  table.insert(props, {
    Name    = "Color",
    Type    = "enum",
    Value   = "White",
    Choices = { "White", "Blue", "Green", "Red", "Orange", "Cyan" }
  })
  return props
end

function RectifyProperties(props)
  return props
end

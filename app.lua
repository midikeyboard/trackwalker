-- Initialize variables to track updates and previous track sector
local lastUpdate = -1e9  -- Set a very low initial value to ensure the first update happens immediately
local previousTrackSector = nil  -- Track the previous track sector, initially set to nil
local titleSize = 88  -- The size of the title text to be drawn
local fontName = 'Notes'  -- The font name to use for drawing the text

-- Return the function that will be executed on every frame
return function(dt)
  -- Update the track sector every second
  -- Check if the current time is more than 1 second past the last update
  if ui.time() > lastUpdate + 1 then
    lastUpdate = ui.time()  -- Update the time of last update to the current time
    -- Get the current track sector based on the car's spline position
    local currentTrackSector = ac.getTrackSectorName(car.splinePosition)
    
    -- Only update the track sector if it has changed
    if currentTrackSector ~= previousTrackSector then
      previousTrackSector = currentTrackSector  -- Store the new track sector as the previous one
      trackSector = currentTrackSector  -- Update the global trackSector variable with the new sector
    end
  end

  -- Ensure trackSector is initialized before trying to render the text
  if trackSector then
    -- Draw the text only if the trackSector has changed or is being rendered for the first time
    -- Push the specified font to the rendering stack
    ui.pushDWriteFont(io.relative('/fonts/'..fontName..'.ttf'))
    -- Render the track sector name text at the current cursor position with the given font size, centered alignment
    ui.dwriteDrawTextClipped(
      trackSector,  -- The text to draw
      titleSize,  -- The size of the text
      ui.getCursor(),  -- The starting position for the text
      ui.windowSize(),  -- The size of the window to constrain the text rendering within
      ui.Alignment.Center,  -- Center the text horizontally
      ui.Alignment.Center,  -- Center the text vertically
      true  -- Clip the text if it exceeds the available space
    )
  end
end

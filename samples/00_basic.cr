require "../sdl"

# Initialize a SDL context for rendering video and ensure it closes when done
SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

# Create a SDL::Window that we can draw to
window = SDL::Window.new("SDL tutorial", 640, 480)

# Keep the application running until this loop exits
loop do
  # Check for interaction from the user
  event = SDL::Event.wait

  # Break the loop if user wants to quit
  case event
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    if event.mod.lctrl? && event.sym.q?
      break
    end
  end

  # Otherwise cover the window surface with white and show it
  window.surface.fill(255, 255, 255)
  window.update
end

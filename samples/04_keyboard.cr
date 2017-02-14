require "../sdl"

# Initialize a SDL context for rendering video and ensure it closes when done
SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

# Create a SDL::Window that we can draw to
window = SDL::Window.new("SDL tutorial", 640, 480)

# Load a set of bitmap images into image buffers in memory
surfaces = {
  default: SDL.load_bmp(File.join(__DIR__, "data", "press.bmp")),
  up:      SDL.load_bmp(File.join(__DIR__, "data", "up.bmp")),
  down:    SDL.load_bmp(File.join(__DIR__, "data", "down.bmp")),
  left:    SDL.load_bmp(File.join(__DIR__, "data", "left.bmp")),
  right:   SDL.load_bmp(File.join(__DIR__, "data", "right.bmp")),
}

# Set which image buffer should be rendered at the start
bmp = surfaces[:default]

# Keep the application running until this loop exits
loop do
  # Check for input from the user
  # NOTE: Slightly more concise form than before
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    # This is a Keyboard Event - if the user just released an arrow key we want
    # to swap out the image buffer so the correct image will be rendered.
    case event.sym
    when .up?
      bmp = surfaces[:up]
    when .down?
      bmp = surfaces[:down]
    when .left?
      bmp = surfaces[:left]
    when .right?
      bmp = surfaces[:right]
    when .q?
      break
    else
      bmp = surfaces[:default]
    end if event.keyup?
  end

  # Blit the relevant image buffer to the window and show it
  bmp.blit(window.surface)
  window.update
end

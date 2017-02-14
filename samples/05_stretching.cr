require "../sdl"

# An example of how you can remove duplication when loading multiple bitmaps
def load_bmp(name, window)
  path = File.join(__DIR__, "data", name)
  SDL.load_bmp(path).convert(window.surface)
end

# Initialize a SDL context for rendering video and ensure it closes when done
SDL.init(SDL::Init::VIDEO)
at_exit { SDL.quit }

# Create a SDL::Window that we can draw to
window = SDL::Window.new("SDL tutorial", 640, 480)

# Create the bitmap image buffer using our helper function
bmp = load_bmp("stretch.bmp", window)

# Keep the application running until this loop exits
loop do
  # Check for input
  case event = SDL::Event.wait
  when SDL::Event::Quit
    break
  when SDL::Event::Keyboard
    if event.keyup? && event.sym.q?
      break
    end
  end

  # Fill background to avoid latent memory artifact rendering
  # You can comment this out to see what it looks like
  # NOTE: We'll see how to do this with a Renderer soon
  window.surface.fill(0, 0, 0)

  # Blit the bitmap with a 20 pixel border and show the result
  bmp.blit_scaled(window.surface, dstrect: SDL::Rect.new(20, 20, 600, 440))
  window.update
end

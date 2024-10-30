import Foundation
import ImGui
import example_glfw_metal

@main
public struct GLFWMetalApp
{
  static func main()
  {
    ImGui.checkVersion()

    // setup context.

    ImGui.CreateContext(nil)
    var io = ImGui.GetIO().pointee
    io.ConfigFlags |= Int32(ImGuiConfigFlags_NavEnableKeyboard.rawValue)
    io.ConfigFlags |= Int32(ImGuiConfigFlags_NavEnableGamepad.rawValue)

    // setup style & font.

    ImGui.StyleColorsDark(nil)

    guard let ttfFile = Bundle.main.path(forResource: "fonts/default.ttf", ofType: nil)
    else { fatalError("could not find default font.") }

    io.Fonts.addFontFromFileTTF(atPath: ttfFile, fontSize: 16)

    // setup window, graphics context, & run event loop.

    if run_example() == .failure {
      fatalError("something terrible happened.")
    }

    print("program completed successfully.")
  }
}

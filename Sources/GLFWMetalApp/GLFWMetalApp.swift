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
    let io = ImGui.GetIO()
    io.pointee.ConfigFlags |= Int32(ImGuiConfigFlags_NavEnableKeyboard.rawValue)
    io.pointee.ConfigFlags |= Int32(ImGuiConfigFlags_NavEnableGamepad.rawValue)
    io.pointee.DisplaySize.x = 800
    io.pointee.DisplaySize.y = 600

    // setup style.

    ImGui.StyleColorsDark(nil)

    // setup window, graphics context, & run event loop.

    if run_example() == .failure {
      fatalError("something terrible happened.")
    }

    print("program completed successfully.")
  }
}

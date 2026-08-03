import Foundation
import ImGui
import example_glfw_metal
import glfw
#if canImport(AppKit)
import AppKit
#endif

@main
public struct GLFWMetalApp
{
  static func main()
  {
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API)
    glfwWindowHint(GLFW_COCOA_RETINA_FRAMEBUFFER, GLFW_TRUE)
    
    ImGui.checkVersion()

    // setup context.

    ImGui.CreateContext(nil)
    let io = ImGui.GetIO()
    io.pointee.ConfigFlags |= Int32(ImGuiConfigFlags_NavEnableKeyboard.rawValue)
    io.pointee.ConfigFlags |= Int32(ImGuiConfigFlags_NavEnableGamepad.rawValue)
    
    #if canImport(AppKit)
      io.pointee.DisplaySize.x = Float(NSScreen.main?.frame.width ?? 800)
      io.pointee.DisplaySize.y = Float(NSScreen.main?.frame.height ?? 600)
    #else
      io.pointee.DisplaySize.x = 800
      io.pointee.DisplaySize.y = 600
    #endif

    // setup style.

    ImGui.StyleColorsDark(nil)
    
    // setup font.

    io.pointee.Fonts.pointee.addFontFromFileTTF(atPath: AppUtils.getFontPath(for: "roboto"), fontSize: 16)

    // setup window, graphics context, & run event loop.

    if run_example() == .failure {
      fatalError("something terrible happened.")
    }

    print("program completed successfully.")
  }
}

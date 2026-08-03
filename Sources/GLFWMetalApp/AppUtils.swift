import Foundation

public enum AppUtils
{
  public static func getFontPath(for fontName: String) -> String
  {
    guard let resourceURL = Bundle.main.resourceURL
    else { fatalError("[glfw metal app] no resources bundle found.") }
    
    var font = resourceURL.appending(path: "\(fontName).ttf")
    
    if !FileManager.default.fileExists(atPath: font.path) {
      let contents = try! FileManager.default.contentsOfDirectory(at: resourceURL, includingPropertiesForKeys: nil)
      guard let bundleURL = contents.first(where: { $0.pathExtension.contains("bundle") })
      else { fatalError("[glfw metal app] the executable is missing its resources bundle directory.") }

      font = bundleURL.appending(path: "Contents/Resources/\(fontName).ttf")
    }
    
    if !FileManager.default.fileExists(atPath: font.path) {
      fatalError("[glfw metal app] font not found: \(font.path)")
    }
    
    return font.path
  }
}

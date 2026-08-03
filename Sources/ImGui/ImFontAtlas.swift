extension ImFontAtlas {
  @discardableResult
  public mutating func addFontFromFileTTF(atPath filepath: String, fontSize: Float) -> UnsafeMutablePointer<ImFont>? {
    var config = ImFontConfig()
    config.OversampleH = 2
    config.OversampleV = 2
    config.PixelSnapH = true
    config.RasterizerDensity = 2
    
    return __AddFontFromFileTTFUnsafe(filepath, fontSize, &config, nil)
  }
}

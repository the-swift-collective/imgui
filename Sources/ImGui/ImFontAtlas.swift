extension ImFontAtlas {
  @discardableResult
  public mutating func addFontFromFileTTF(atPath filepath: String, fontSize: Float) -> UnsafeMutablePointer<ImFont>? {
    __AddFontFromFileTTFUnsafe(filepath, fontSize, nil, nil)
  }
}

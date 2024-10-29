extension UnsafeMutablePointer<ImFontAtlas> {
  @discardableResult
  public func addFontFromFileTTF(atPath filepath: String, fontSize: Float) -> ImFont {
    pointee.addFontFromFileTTF(atPath: filepath, fontSize: fontSize)
  }
}

extension ImFontAtlas {
  private mutating func AddFontFromFileTTFCopy(atPath filepath: String, fontSize: Float) -> ImFont {
    __AddFontFromFileTTFUnsafe(filepath, fontSize, nil, nil).pointee
  }

  public mutating func addFontFromFileTTF(atPath filepath: String, fontSize: Float) -> ImFont {
    AddFontFromFileTTFCopy(atPath: filepath, fontSize: fontSize)
  }
}

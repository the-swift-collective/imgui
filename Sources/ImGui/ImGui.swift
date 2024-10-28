@_exported import imgui_cxx

extension ImGui {
  /// Check that version and structures layouts are matching
  /// between compiled imgui code and caller.
  /// 
  /// Verify ABI compatibility between caller code and the
  /// compiled version of imgui. This helps detects some
  /// build issues.
  @discardableResult
  public static func checkVersion() -> Bool {
    ImGui.DebugCheckVersionAndDataLayout(
      IMGUI_VERSION,
      MemoryLayout<ImGuiIO>.stride,
      MemoryLayout<ImGuiStyle>.stride,
      MemoryLayout<ImVec2>.stride,
      MemoryLayout<ImVec4>.stride,
      MemoryLayout<ImDrawVert>.stride,
      MemoryLayout<ImDrawIdx>.stride
    )
  }
}

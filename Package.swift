// swift-tools-version: 5.10

import Foundation
import PackageDescription

let package = Package(
  name: "imgui",
  platforms: [
    .macOS(.v14),
    .visionOS(.v1),
    .iOS(.v17),
    .tvOS(.v17),
    .watchOS(.v10),
  ],
  products: [
    .library(
      name: "imgui_cxx",
      targets: ["imgui_cxx"]
    ),
    .library(
      name: "ImGui",
      targets: ["ImGui"]
    ),
    .library(
      name: "glfw",
      targets: ["glfw"]
    ),
    .library(
      name: "backend_glfw",
      targets: ["backend_glfw"]
    ),
  ] + Arch.addPlatformProducts(),
  targets: [
    .target(
      name: "imgui_cxx",
      path: "imgui-cxx",
      sources: [
        "imgui_demo.cpp",
        "imgui_draw.cpp",
        "imgui_tables.cpp",
        "imgui_widgets.cpp",
        "imgui.cpp",
      ],
      publicHeadersPath: "."
    ),

    .target(
      name: "glfw",
      path: "glfw",
      exclude: Arch.getGLFWExcludes(),
      sources: [
        "src"
      ],
      cxxSettings: [
        .define(
          "_GLFW_COCOA", to: "1", .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
        .define("_GLFW_X11", to: "1", .when(platforms: [.linux, .android, .openbsd])),
        .define("_GLFW_WIN32", to: "1", .when(platforms: [.windows])),
        .define("GL_SILENCE_DEPRECATION", to: "1"),
        .unsafeFlags(["-fno-objc-arc"]),  // TODO: remove.
      ],
      linkerSettings: [
        .linkedLibrary("opengl32", .when(platforms: [.windows])),
        .linkedLibrary("glut", .when(platforms: [.linux, .android, .openbsd])),
        .linkedLibrary("GL", .when(platforms: [.linux, .android, .openbsd])),
        .linkedLibrary("GLU", .when(platforms: [.linux, .android, .openbsd])),
        .linkedLibrary("m", .when(platforms: [.linux, .android, .openbsd])),
        .linkedLibrary("X11", .when(platforms: [.linux, .android, .openbsd])),
        .linkedLibrary("Xt", .when(platforms: [.linux, .android, .openbsd])),
        .linkedFramework("Cocoa", .when(platforms: [.macOS])),
        .linkedFramework("GLUT", .when(platforms: [.macOS])),
        .linkedFramework(
          "GameController", .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
      ]
    ),

    .target(
      name: "backend_glfw",
      dependencies: [
        .target(name: "glfw"),
        .target(name: "imgui_cxx"),
      ],
      path: "imgui-cxx/backends",
      sources: [
        "imgui_impl_glfw.cpp"
      ],
      publicHeadersPath: "."
    ),

    .target(
      name: "ImGui",
      dependencies: [
        .target(name: "imgui_cxx")
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),

    .testTarget(
      name: "ImGuiTests",
      dependencies: ["ImGui"],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
  ] + Arch.addPlatformExamples(),
  cxxLanguageStandard: .cxx17
)

enum Arch {
  static func getGLFWExcludes() -> [String] {
    var excludes = [
      "src/wl_init.c",
      "src/wl_window.c",
      "src/wl_monitor.c",
      "src/glfw.rc.in",
      "src/CMakeLists.txt",
      "src/mappings.h.in",
    ]
    #if !os(Windows)
      excludes += [
        "src/wgl_context.c",
        "src/win32_init.c",
        "src/win32_joystick.c",
        "src/win32_monitor.c",
        "src/win32_thread.c",
        "src/win32_time.c",
        "src/win32_window.c",
      ]
    #endif /* !os(Windows) */
    #if os(Windows)
      excludes += [
        "src/posix_thread.c"
      ]
    #endif
    #if !os(macOS) && !os(visionOS) && !os(iOS) && !os(tvOS) && !os(watchOS)
      excludes += [
        "src/nsgl_context.m",
        "src/cocoa_init.m",
        "src/cocoa_joystick.m",
        "src/cocoa_window.m",
        "src/cocoa_monitor.m",
        "src/cocoa_time.c",
      ]
    #endif /* !os(macOS) && !os(visionOS) && !os(iOS) && !os(tvOS) && !os(watchOS) */
    #if !os(Linux) && !os(Android) && !os(OpenBSD) && !os(FreeBSD)
      excludes += [
        "src/xkb_unicode.c",
        "src/x11_init.c",
        "src/x11_monitor.c",
        "src/x11_window.c",
        "src/posix_time.c",
        "src/glx_context.c",
        "src/linux_joystick.c",
      ]
    #endif /* !os(Linux) && !os(Android) && !os(OpenBSD) && !os(FreeBSD) */

    return excludes
  }

  static func addPlatformProducts() -> [Product] {
    #if os(macOS)
      [
        .library(
          name: "backend_metal",
          targets: ["backend_metal"]
        ),
        .executable(
          name: "example_glfw_metal",
          targets: ["example_glfw_metal"]
        ),
      ]
    #else
      [
        // todo.
      ]
    #endif
  }

  static func addPlatformExamples() -> [Target] {
    #if os(macOS)
      [
        .target(
          name: "backend_metal",
          dependencies: [
            .target(name: "imgui_cxx")
          ],
          path: "imgui-cxx/backends",
          sources: [
            "imgui_impl_metal.mm"
          ],
          publicHeadersPath: "."
        ),

        .executableTarget(
          name: "example_glfw_metal",
          dependencies: [
            .target(name: "imgui_cxx"),
            .target(name: "backend_glfw"),
            .target(
              name: "backend_metal",
              condition: .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
          ],
          path: "imgui-cxx/examples/example_glfw_metal"
        ),
      ]
    #else
      [
        // todo.
      ]
    #endif
  }
}

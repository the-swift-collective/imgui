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
      name: "imgui_extras",
      targets: ["imgui_extras"]
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
      name: "freetype",
      targets: ["freetype"]
    ),
    .library(
      name: "backend_glfw",
      targets: ["backend_glfw"]
    ),
    .library(
      name: "imgui_freetype",
      targets: ["imgui_freetype"]
    ),
  ] + Arch.addPlatformProducts(),
  dependencies: [
    .package(url: "https://github.com/the-swift-collective/zlib.git", from: "1.3.2")
  ],
  targets: [
    .target(
      name: "imgui_cxx",
      path: "imgui-cxx",
      exclude: [
        "examples"
      ],
      sources: [
        "imgui_demo.cpp",
        "imgui_draw.cpp",
        "imgui_tables.cpp",
        "imgui_widgets.cpp",
        "imgui.cpp",
        "misc/cpp/imgui_stdlib.cpp",
      ],
      publicHeadersPath: ".",
      cxxSettings: [
        .define("IMGUI_ENABLE_FREETYPE", to: "1"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ]
    ),
    
    .target(
      name: "imgui_extras",
      dependencies: [
        .target(name: "imgui_cxx")
      ],
      path: "imgui-extras",
      cxxSettings: [
        .define("IMGUI_ENABLE_FREETYPE", to: "1"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ]
    ),

    .target(
      name: "glfw",
      path: "glfw",
      exclude: Arch.getGLFWExcludes(),
      sources: [
        "src"
      ],
      cxxSettings: [
        .headerSearchPath("."),
        .define("_GLFW_COCOA", to: "1", .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
        .define("_GLFW_X11", to: "1", .when(platforms: [.linux, .openbsd])),
        .define("_GLFW_OSMESA", to: "1", .when(platforms: [.android])),
        .define("_GLFW_WIN32", to: "1", .when(platforms: [.windows])),
        .define("GL_SILENCE_DEPRECATION", to: "1"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
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
        .linkedFramework("GameController", .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
      ]
    ),

    .target(
      name: "freetype",
      dependencies: [
        .product(name: "ZLib", package: "zlib")
      ],
      path: "freetype",
      sources: [
        "src/base/ftsystem.c",
        "src/base/ftinit.c",
        "src/base/ftdebug.c",
        "src/base/ftbase.c",
        "src/base/ftbbox.c",
        "src/base/ftglyph.c",
        "src/base/ftbdf.c",
        "src/base/ftbitmap.c",
        "src/base/ftcid.c",
        "src/base/ftfstype.c",
        "src/base/ftgasp.c",
        "src/base/ftgxval.c",
        "src/base/ftmm.c",
        "src/base/ftotval.c",
        "src/base/ftpatent.c",
        "src/base/ftpfr.c",
        "src/base/ftstroke.c",
        "src/base/ftsynth.c",
        "src/base/fttype1.c",
        "src/base/ftwinfnt.c",
        "src/sfnt/sfnt.c",
        "src/svg/ftsvg.c",
        "src/truetype/truetype.c",
        "src/truetype/ttinterp.c",
        "src/cff/cff.c",
        "src/cid/type1cid.c",
        "src/type1/type1.c",
        "src/type42/type42.c",
        "src/bdf/bdf.c",
        "src/pcf/pcf.c",
        "src/pfr/pfr.c",
        "src/winfonts/winfnt.c",
        "src/smooth/smooth.c",
        "src/raster/raster.c",
        "src/sdf/sdf.c",
        "src/autofit/autofit.c",
        "src/cache/ftcache.c",
        "src/cache/ftccache.c",
        "src/cache/ftcmanag.c",
        "src/cache/ftcmru.c",
        "src/gzip/ftgzip.c",
        "src/lzw/ftlzw.c",
        "src/bzip2/ftbzip2.c",
        "src/gxvalid/gxvalid.c",
        "src/otvalid/otvalid.c",
        "src/psaux/psaux.c",
        "src/pshinter/pshinter.c",
        "src/psnames/psnames.c"
      ],
      publicHeadersPath: "include",
      cSettings: [
        .headerSearchPath("src"),
        .define("FT_USE_AUTOFIT", to: "1"),
        .define("FT_CONFIG_OPTION_USE_ZLIB", to: "1"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ]
    ),

    .target(
      name: "backend_glfw",
      dependencies: [
        .target(name: "glfw"),
        .target(name: "imgui_cxx"),
        .target(name: "imgui_extras"),
      ],
      path: "imgui-cxx/backends",
      sources: [
        "imgui_impl_glfw.cpp"
      ],
      publicHeadersPath: ".",
      cxxSettings: [
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ]
    ),

    .target(
      name: "imgui_freetype",
      dependencies: [
        .target(name: "imgui_cxx"),
        .target(name: "imgui_extras"),
        .target(name: "freetype")
      ],
      path: "imgui-cxx",
      exclude: [
        "misc/freetype/README.md",
        "examples"
      ],
      sources: [
        "misc/freetype"
      ],
      publicHeadersPath: ".",
      cxxSettings: [
        .headerSearchPath("misc/freetype"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ]
    ),

    .target(
      name: "ImGui",
      dependencies: [
        .target(name: "imgui_cxx"),
        .target(name: "imgui_extras"),
        .target(name: "imgui_freetype"),
      ],
      cxxSettings: [
        .define("IMGUI_ENABLE_FREETYPE", to: "1"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),

    .testTarget(
      name: "ImGuiTests",
      dependencies: ["ImGui"],
      cxxSettings: [
        .define("IMGUI_ENABLE_FREETYPE", to: "1"),
        .define("_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH", .when(platforms: [.windows])),
        .define("_ALLOW_KEYWORD_MACROS", to: "1", .when(platforms: [.windows])),
        .define("static_assert(_conditional, ...)", to: "", .when(platforms: [.windows])),
      ],
      swiftSettings: [
        .interoperabilityMode(.Cxx)
      ]
    ),
  ] + Arch.addPlatformBackends(),
  cxxLanguageStandard: .cxx17
)

enum Arch {
  static func getGLFWExcludes() -> [String] {
    var excludes = [
      "src/wl_init.c",
      "src/wl_window.c",
      "src/wl_monitor.c",
      "src/CMakeLists.txt",
      "src/glfw.rc.in",
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
          name: "backend_opengl3",
          targets: ["backend_opengl3"]
        ),
        .library(
          name: "backend_metal",
          targets: ["backend_metal"]
        ),
        .library(
          name: "example_glfw_metal",
          targets: ["example_glfw_metal"]
        ),
        .executable(
          name: "GLFWMetalApp",
          targets: ["GLFWMetalApp"]
        )
      ]
    #elseif os(Windows)
      [
        .library(
          name: "backend_opengl3",
          targets: ["backend_opengl3"]
        ),
        .library(
          name: "backend_win32",
          targets: ["backend_win32"]
        ),
      ]
    #else
    [
      .library(
        name: "backend_opengl3",
        targets: ["backend_opengl3"]
      ),
    ]
    #endif
  }

  static func addPlatformBackends() -> [Target] {
    #if os(macOS)
      [
        .target(
          name: "backend_opengl3",
          dependencies: [
            .target(name: "ImGui")
          ],
          path: "imgui-cxx/backends",
          sources: [
            "imgui_impl_opengl3.cpp"
          ],
          publicHeadersPath: "."
        ),

        .target(
          name: "backend_metal",
          dependencies: [
            .target(name: "ImGui")
          ],
          path: "imgui-cxx/backends",
          sources: [
            "imgui_impl_metal.mm"
          ],
          publicHeadersPath: "."
        ),

        .target(
          name: "example_glfw_metal",
          dependencies: [
            .target(name: "ImGui"),
            .target(name: "backend_glfw"),
            .target(
              name: "backend_metal",
              condition: .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
          ],
          path: "imgui-cxx/examples/example_glfw_metal",
          cxxSettings: [
            .define("IMGUI_ENABLE_FREETYPE", to: "1"),
          ]
        ),

        .executableTarget(
          name: "GLFWMetalApp",
          dependencies: [
            .target(name: "example_glfw_metal")
          ],
          resources: [
            .process("Resources")
          ],
          swiftSettings: [
            .interoperabilityMode(.Cxx)
          ]
        )
      ]
    #elseif os(Windows)
      [
        .target(
          name: "backend_opengl3",
          dependencies: [
            .target(name: "ImGui")
          ],
          path: "imgui-cxx/backends",
          sources: [
            "imgui_impl_opengl3.cpp"
          ],
          publicHeadersPath: "."
        ),
        
        .target(
          name: "backend_win32",
          dependencies: [
            .target(name: "ImGui")
          ],
          path: "imgui-cxx/backends",
          sources: [
            "imgui_impl_win32.cpp"
          ],
          publicHeadersPath: "."
        ),
      ]
    #else
      [
        .target(
          name: "backend_opengl3",
          dependencies: [
            .target(name: "ImGui")
          ],
          path: "imgui-cxx/backends",
          sources: [
            "imgui_impl_opengl3.cpp"
          ],
          publicHeadersPath: "."
        ),
      ]
    #endif
  }
}

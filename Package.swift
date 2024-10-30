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
      publicHeadersPath: ".",
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
        .define(
          "_GLFW_COCOA", to: "1", .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
        .define("_GLFW_X11", to: "1", .when(platforms: [.linux, .android, .openbsd])),
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
        .linkedFramework(
          "GameController", .when(platforms: [.macOS, .iOS, .visionOS, .tvOS, .watchOS])),
      ]
    ),

    .target(
      name: "freetype",
      path: "freetype",
      exclude: [
        "builds",
        "devel",
        "docs",
        "objs",
        "subprojects",
        "tests",
        "src/svg/module.mk",
        "src/svg/rules.mk",
        "src/pcf/module.mk",
        "src/pcf/rules.mk",
        "src/type1/module.mk",
        "src/type1/rules.mk",
        "src/dlg/rules.mk",
        "src/sdf/module.mk",
        "src/sdf/rules.mk",
        "src/cache/rules.mk",
        "src/sfnt/module.mk",
        "src/sfnt/rules.mk",
        "src/winfonts/module.mk",
        "src/winfonts/rules.mk",
        "src/bdf/module.mk",
        "src/bdf/rules.mk",
        "src/smooth/module.mk",
        "src/smooth/rules.mk",
        "src/type42/module.mk",
        "src/type42/rules.mk",
        "src/cff/module.mk",
        "src/cff/rules.mk",
        "src/gzip/rules.mk",
        "src/lzw/rules.mk",
        "src/gxvalid/module.mk",
        "src/gxvalid/rules.mk",
        "src/psaux/module.mk",
        "src/psaux/rules.mk",
        "src/cid/module.mk",
        "src/cid/rules.mk",
        "src/pfr/module.mk",
        "src/pfr/rules.mk",
        "src/otvalid/module.mk",
        "src/otvalid/rules.mk",
        "src/autofit/module.mk",
        "src/autofit/rules.mk",
        "src/pshinter/module.mk",
        "src/pshinter/rules.mk",
        "src/truetype/module.mk",
        "src/truetype/rules.mk",
        "src/raster/module.mk",
        "src/raster/rules.mk",
        "src/psnames/module.mk",
        "src/psnames/rules.mk",
        "src/base/rules.mk",
        "src/bzip2/rules.mk",
        "src/tools",
        "src/pcf/README",
        "src/tools/ftrandom/README",
        "src/bdf/README",
        "src/gxvalid/README",
        "src/gzip/patches/freetype-zlib.diff",
        "src/base/ftver.rc",
        "src/autofit/afblue.hin",
        "src/autofit/afblue.dat",
        "src/autofit/afblue.cin",
        "src/gzip/README.freetype",
        "src/autofit/afblue.c",
        "src/autofit/afcjk.c",
        "src/autofit/afdummy.c",
        "src/autofit/afglobal.c",
        "src/autofit/afhints.c",
        "src/autofit/afindic.c",
        "src/autofit/aflatin.c",
        "src/autofit/afloader.c",
        "src/autofit/afmodule.c",
        "src/autofit/afranges.c",
        "src/autofit/afshaper.c",
        "src/base/ftadvanc.c",
        "src/base/ftbdf.c",
        "src/base/ftcid.c",
        "src/base/ftfstype.c",
        "src/base/ftgasp.c",
        "src/base/ftgxval.c",
        "src/base/ftotval.c",
        "src/base/ftpatent.c",
        "src/base/ftpfr.c",
        "src/base/ftstroke.c",
        "src/base/fttype1.c",
        "src/base/ftwinfnt.c",
        "src/base/ftcalc.c",
        "src/base/ftcolor.c",
        "src/base/ftdbgmem.c",
        "src/base/fterrors.c",
        "src/base/ftfntfmt.c",
        "src/base/ftgloadr.c",
        "src/base/fthash.c",
        "src/base/ftlcdfil.c",
        "src/base/ftmac.c",
        "src/base/ftobjs.c",
        "src/base/ftoutln.c",
        "src/base/ftpsprop.c",
        "src/base/ftrfork.c",
        "src/base/ftsnames.c",
        "src/base/ftstream.c",
        "src/base/fttrigon.c",
        "src/base/ftutil.c",
        "src/sdf/ftsdfrend.c",
        "src/sdf/ftsdfcommon.c",
        "src/sdf/ftbsdf.c",
        "src/sdf/ftsdf.c",
        "src/smooth/ftgrays.c",
        "src/smooth/ftsmooth.c",
        "src/psnames/psmodule.c",
        "src/psaux/afmparse.c",
        "src/psaux/psauxmod.c",
        "src/psaux/t1cmap.c",
        "src/truetype/ttdriver.c",
        "src/pshinter/pshalgo.c",
        "src/cache/ftcbasic.c",
        "src/cache/ftcsbits.c",
        "src/cache/ftcimage.c",
        "src/cache/ftcglyph.c",
        "src/cache/ftccmap.c",
        "src/svg/ftsvg.c",
        "src/raster/ftrend1.c",
        "src/type42/t42drivr.c",
        "src/truetype/ttdriver.c",
        "src/sfnt/sfdriver.c",
        "src/cff/cffdrivr.c",
        "src/lzw/ftzopen.c",
        "src/pshinter/pshmod.c",
        "src/sfnt/pngshim.c",
        "src/sfnt/sfobjs.c",
        "src/sfnt/sfwoff.c",
        "src/sfnt/sfwoff2.c",
        "src/sfnt/ttbdf.c",
        "src/sfnt/ttcolr.c",
        "src/sfnt/ttcpal.c",
        "src/sfnt/ttsvg.c",
        "src/sfnt/ttgpos.c",
        "src/sfnt/ttkern.c",
        "src/sfnt/ttload.c",
        "src/sfnt/ttsbit.c",
        "src/sfnt/woff2tags.c",
        "src/bdf/bdfdrivr.c",
        "src/pfr/pfrdrivr.c",
        "src/cid/cidriver.c",
        "src/gxvalid/gxvmod.c",
        "src/otvalid/otvmod.c",
        "src/raster/ftrend1.c",
        "src/cff/cffdrivr.c",
        "src/cff/cffcmap.c",
        "src/pfr/pfrcmap.c",
        "src/pcf/pcfdrivr.c",
        "src/sfnt/ttcmap.c",
        "src/truetype/ttdriver.c",
        "src/raster/ftraster.c",
        "src/type1/t1driver.c",
        "src/gxvalid/gxvfgen.c"
      ],
      sources: [
        "src"
      ],
      publicHeadersPath: "include",
      cSettings: [
        .headerSearchPath("src"),
        .define("FT_USE_AUTOFIT", to: "1"),
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
        .target(name: "freetype")
      ],
      path: "imgui-cxx",
      exclude: [
        "misc/freetype/README.md"
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
        .target(name: "imgui_freetype")
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
        .library(
          name: "example_glfw_metal",
          targets: ["example_glfw_metal"]
        ),
        .executable(
          name: "GLFWMetalApp",
          targets: ["GLFWMetalApp"]
        )
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
            .copy("Resources/fonts")
          ],
          swiftSettings: [
            .interoperabilityMode(.Cxx)
          ]
        )
      ]
    #else
      [
        // todo.
      ]
    #endif
  }
}

<!-- markdownlint-configure-file {
  "MD013": {
    "code_blocks": false,
    "tables": false
  },
  "MD033": false,
  "MD041": false
} -->

<div align="center">

<h1 align="center">
    ImGui
</h1>

<p align="center">
  <i align="center">Cross platform <b>swift</b> package for the <a href="https://github.com/ocornut/imgui"><b>imgui library</b></a>.</i>
</p>

</div>

<h4 align="center">
  <a href="https://github.com/the-swift-collective/imgui/actions/workflows/swift-ubuntu.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/the-swift-collective/imgui/swift-ubuntu.yml?style=flat-square&label=ubuntu%20&labelColor=E95420&logoColor=FFFFFF&logo=ubuntu">
  </a>
  <a href="https://github.com/the-swift-collective/imgui/actions/workflows/swift-macos.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/the-swift-collective/imgui/swift-macos.yml?style=flat-square&label=macOS&labelColor=000000&logo=apple">
  </a>
  <a href="https://github.com/the-swift-collective/imgui/actions/workflows/swift-windows.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/the-swift-collective/imgui/swift-windows.yml?style=flat-square&label=windows&labelColor=357EC7&logo=gitforwindows">
  </a>
</h4>

<div align="center">

### Demo

</div>


##### To run an imgui example, first install [SwiftBundler](https://swiftbundler.dev/documentation/swiftbundler/installation), and run the following (currently only the **glfw+metal** backend on **macOS**, more coming soon...)
```pwsh
git clone https://github.com/the-swift-collective/imgui.git
cd imgui

swift bundler run
```
> should launch 'example_glfw_metal.app'.

<br/>

<div align="center">

### Usage

</div>

##### To use imgui in swift, add imgui as a package dependency in your project's Package.swift file.
```swift
dependencies: [
  .package(url: "https://github.com/the-swift-collective/imgui.git", branch: "main"),
]
```


##### Then, for any target you'd like, add the imgui product as a target dependency, a complete example.
```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "MyPackage",
  products: [
    .library(
      name: "MyLibrary",
      targets: ["MyLibrary"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/the-swift-collective/imgui.git", branch: "main")
  ],
  targets: [
    .target(
      name: "MyLibrary",
      dependencies: [
        /* add the imgui product as a library dependency. */
        .product(name: "ImGui", package: "imgui"),
      ]
    ),
  ]
)
```

<br>

<hr/>

###### ***the swift collective** - cross platform **swift packages**.*
###### imgui is licensed under the terms of the [MIT License](https://github.com/ocornut/imgui/blob/master/LICENSE.txt).

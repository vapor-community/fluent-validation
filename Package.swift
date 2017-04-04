// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "FluentValidators",
    dependencies: [
        .Package(url: "https://github.com/vapor/fluent.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 0, minor: 2)
    ]
)

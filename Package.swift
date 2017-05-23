// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "FluentValidators",
    dependencies: [
    .Package(url: "https://github.com/vapor/fluent.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 1)
    ]
)

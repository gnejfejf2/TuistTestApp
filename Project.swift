import ProjectDescription



let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UILaunchStoryboardName": "LaunchScreen",
    "NSAppTransportSecurity" : ["NSAllowsArbitraryLoads":true],
    "UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
    "UIUserInterfaceStyle":"Light"
]

let project = Project(
    name: "TuistTest",
    organizationName: "JYKang",
    settings: .settings(configurations: [
        .debug(name: "Debug"),
        .release(name: "Release")
    ]),
    targets: [
        Target(
            name: "TuistApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.jyk.TuistApp",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/TuistApp/Sources/**"],
            resources: ["Targets/TuistApp/Resources/**"],
            dependencies: [
                .external(name: "RxSwift"),
                .external(name: "RxDataSources"),
                .external(name: "RxGesture"),
                .external(name: "Kingfisher"),
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "Swinject"),
                    .target(name: "NetworkPlatform")
            ]
        ),
        Target(
            name: "TuistAppTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jyk.TuistAppTests",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Targets/TuistAppTests/Sources/**"],
            resources : ["Targets/TuistAppTests/Resources/**"],
            dependencies: [
                .target(name: "TuistApp"),
                .target(name: "Domain"),
                .target(name: "NetworkPlatform"),
                .external(name: "RxSwift"),
                .external(name: "RxTest")
            ]
        ),
        
        Target(
            name: "NetworkPlatform",
            platform: .iOS,
            product: .staticLibrary,
            bundleId : "com.jyk.NetworkPlatform",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist : .default,
            sources: ["Targets/NetworkPlatform/Sources/**"],
            dependencies: [
                 .external(name: "RxAlamofire"),
                .external(name: "RxSwift"),
                .target(name: "Domain")
            ]
        ),
        Target(
            name: "NetworkPlatformTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jyk.NetworkPlatformTests",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Targets/NetworkPlatformTests/Sources/**"],
            dependencies: [
                 .target(name: "NetworkPlatform"),
                 .external(name: "RxBlocking")
            ]
        ),
        Target(
            name: "Domain",
            platform: .iOS,
            product: .staticLibrary,
            bundleId : "com.jyk.Domain",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist : .default,
            sources: ["Targets/Domain/Sources/**"],
            dependencies: [
                .external(name: "RxSwift"),
                .external(name: "RxDataSources")
            ]
        ),
        Target(
            name: "DomainTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jyk.DomainTests",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Targets/DomainTests/Sources/**"],
            dependencies: [
                 .target(name: "Domain")
            ]
        ),
        
        
    ],
    schemes: [
        .init(name: "TuistTestApp-Dev", shared: true, hidden: false,
              buildAction: .buildAction(targets: ["TuistTestApp"]),
              testAction: .targets(["TuistTestAppTests"] , configuration: "Debug"),
              runAction: .runAction(configuration: "Debug"),
              archiveAction: .archiveAction(configuration: "Debug"),
              profileAction: .profileAction(configuration: "Debug"),
              analyzeAction: .analyzeAction(configuration: "Debug")
             ),
        .init(name: "TuistTestApp-Prod", shared: true, hidden: false,
              buildAction: .buildAction(targets: ["TuistTestApp"]),
              testAction: .targets(["TuistTestAppTests"] , configuration: "Release"),
              runAction: .runAction(configuration: "Release"),
              archiveAction: .archiveAction(configuration: "Release"),
              profileAction: .profileAction(configuration: "Release"),
              analyzeAction: .analyzeAction(configuration: "Release")
             )
    ]
    
)

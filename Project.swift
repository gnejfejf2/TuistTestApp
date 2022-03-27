import ProjectDescription



let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UILaunchStoryboardName": "LaunchScreen",
    "NSAppTransportSecurity" : ["NSAllowsArbitraryLoads":true],
    "UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
    "UIUserInterfaceStyle":"Light"
    ]

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
    name: "TuistTest",
    organizationName: "JYKang",
    settings: .settings(configurations: [
        .debug(name: "Debug"),
        .release(name: "Release")
    ]),
    targets: [
        Target(
            name: "TuistTestApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.jyk.TuistTestApp",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/TuistTestApp/Sources/**"],
            resources: ["Targets/TuistTestApp/Resources/**"],
            dependencies: [
                .external(name: "RxSwift"),
                .external(name: "RxDataSources"),
                .external(name: "RxGesture"),
                .external(name: "Kingfisher"),
                .external(name: "RxMoya"),
                .external(name: "Moya"),
                .external(name: "SnapKit"),
                .external(name: "Then")
            ]
        ),
        Target(name: "TuistTestAppTests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "com.jyk.TuistTestAppTests",
                    infoPlist: .default,
                    sources: ["Targets/TuistTest/Sources/**"],
                    dependencies: [
//                     // 유닛 테스트의 의존성은 Framework, Library 또는 App으로 설정해야 함.
                     .target(name: "TuistTestApp"),
                     .external(name: "RxSwift"),
                     .external(name: "RxTest")
                     
                    ]),
    ],
    schemes: [
        .init(name: "TuistTestApp-Debug", shared: true, hidden: false,
              buildAction: .buildAction(targets: ["TuistTestApp"]),
              testAction: .targets(["TuistTestAppTests"] , configuration: "Debug"),
              runAction: .runAction(configuration: "Debug"),
              archiveAction: .archiveAction(configuration: "Debug"),
              profileAction: .profileAction(configuration: "Debug"),
              analyzeAction: .analyzeAction(configuration: "Debug")
             ),
        .init(name: "TuistTestApp-Release", shared: true, hidden: false,
              buildAction: .buildAction(targets: ["TuistTestApp"]),
              testAction: .targets(["TuistTestAppTests"] , configuration: "Release"),
              runAction: .runAction(configuration: "Release"),
              archiveAction: .archiveAction(configuration: "Release"),
              profileAction: .profileAction(configuration: "Release"),
              analyzeAction: .analyzeAction(configuration: "Release")
             )
    ]
   
)

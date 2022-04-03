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
        .debug(name: "Dev"),
        .release(name: "Release"),
        .release(name: "Prod")
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
                .external(name: "Then"),
                .external(name: "Swinject")
            ]
        ),
        Target(name: "TuistTestAppTests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "com.jyk.TuistTestAppTests",
                    deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
                    infoPlist: .default,
                    sources: ["Targets/TuistTest/Sources/**"],
                    dependencies: [
//                     // 유닛 테스트의 의존성은 Framework, Library 또는 App으로 설정해야 함.
                     .target(name: "TuistTestApp"),
                     .external(name: "RxSwift"),
                     .external(name: "RxTest"),
                    ]),
    ],
    schemes: [
        .init(name: "TuistTestApp-Dev", shared: true, hidden: false,
              buildAction: .buildAction(targets: ["TuistTestApp"]),
              testAction: .targets(["TuistTestAppTests"] , configuration: "Dev"),
              runAction: .runAction(configuration: "Dev"),
              archiveAction: .archiveAction(configuration: "Dev"),
              profileAction: .profileAction(configuration: "Dev"),
              analyzeAction: .analyzeAction(configuration: "Dev")
             ),
        .init(name: "TuistTestApp-Prod", shared: true, hidden: false,
              buildAction: .buildAction(targets: ["TuistTestApp"]),
              testAction: .targets(["TuistTestAppTests"] , configuration: "Prod"),
              runAction: .runAction(configuration: "Prod"),
              archiveAction: .archiveAction(configuration: "Prod"),
              profileAction: .profileAction(configuration: "Prod"),
              analyzeAction: .analyzeAction(configuration: "Prod")
             )
    ]
   
)

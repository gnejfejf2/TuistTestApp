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
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "Swinject"),
//                .external(name: "Moya"),
//                .external(name: "RxMoya"),
                .target(name: "NetworkPlatform")
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
       
        Target(
            name: "NetworkPlatform",
            platform: .iOS,
            product: .staticLibrary,
            bundleId : "com.jyk.NetworkPlatform",
            deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
            infoPlist : .default,
            sources: ["Targets/NetworkPlatform/Sources/**"],
            dependencies: [
                .external(name: "Moya"),
                .external(name: "RxMoya"),
                .external(name: "RxAlamofire"),
                .external(name: "RxSwift"),
                .external(name: "Alamofire"),
                .target(name: "Domain")
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
//        ,
//        Target(name: "NetworkServiceTests",
//               platform: .iOS,
//               product: .unitTests,
//               bundleId: "com.jyk.NetworkServiceTests",
//               deploymentTarget : .iOS(targetVersion: "13.0.0", devices: .iphone),
//               infoPlist: .default,
//               sources: ["Targets/TuistTest/Sources/**"],
//               dependencies: [
//                //                     // 유닛 테스트의 의존성은 Framework, Library 또는 App으로 설정해야 함.
//                .target(name: "NetworkService")
//               ])
        
        
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

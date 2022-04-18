//
//  Dependencies.swift
//  Config
//
//  Created by 강지윤 on 2022/03/27.
//


import ProjectDescription

let dependencies = Dependencies(
    
    swiftPackageManager: .init([
        .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .upToNextMajor(from: "6.5.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .upToNextMajor(from: "4.0.3")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.2.0")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMajor(from: "15.0.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url : "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2.0.0")),
        .remote(url : "https://github.com/Swinject/Swinject.git" ,  requirement: .upToNextMajor(from: "2.8.0")),
        //        .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.6.0")),
        .remote(url: "https://github.com/RxSwiftCommunity/RxAlamofire.git", requirement: .upToNextMajor(from: "6.1.0")),
    ], baseSettings: .settings(
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ])
    ),
    
    platforms: [.iOS]
)

//
//  SceneDelegate.swift
//  BrandiApp
//
//  Created by 강지윤 on 2022/03/17.
//

import UIKit
//import Network
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

   
//    var networkWindow : UIWindow!
    
    var container : Container = Container()
    
//    let monitor : NWPathMonitor = NWPathMonitor()
    
    var appMainCoordinator : AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
//        networkWindow = UIWindow(windowScene: windowScene)
        
        appMainCoordinator = Assembler.shared.resolver.resolve(AppCoordinator.self, argument: window)
        appMainCoordinator?.start()
        
        getWhatOfNetwork()
        
        
    }

    func getWhatOfNetwork() {
        
//         monitor.start(queue: DispatchQueue.global())
//        networkWindow?.rootViewController = LoadingViewController()
//        networkWindow?.makeKeyAndVisible()
////        networkWindow?
//
//         // [세마포어 선언 : 프로그램 로직을 동기화 구현]
//         let semaphore = DispatchSemaphore(value: 0) // [value 0 값은 대기 상태 선언]
//
//        monitor.pathUpdateHandler = { path in
//            if path.status == .satisfied { // 네트워크가 연결된 경우
//                if path.usesInterfaceType(.wifi) {
//                    print("")
//                    print("===============================")
//                    print("[C_StateCheck >> getWhatOfNetwork() :: 현재 사용중인 네트워크 상태 확인 실시]")
//                    print("[연결 상태 :: \("와이파이")]")
//                    print("===============================")
//                    print("")
//                    semaphore.signal()
//                }
//                else if path.usesInterfaceType(.cellular) {
//                    print("")
//                    print("===============================")
//                    print("[C_StateCheck >> getWhatOfNetwork() :: 현재 사용중인 네트워크 상태 확인 실시]")
//                    print("[연결 상태 :: \("모바일")]")
//                    print("===============================")
//                    print("")
//                    semaphore.signal()
//                }
//            }
//            else { // 네트워크가 연결되지 않은 경우
//                self.networkWindow?.rootViewController = nil
//                semaphore.signal()
//            }
//        }
//        // [세마포어 확인 대기]
//        semaphore.wait()

     }

}



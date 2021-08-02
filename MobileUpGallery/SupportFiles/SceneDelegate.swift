//
//  SceneDelegate.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 20.07.2021.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = ((scene?.delegate as? SceneDelegate)!)
        return sd
    }
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        self.authService = AuthService()
        authService.delegate = self
        let authVC = AuthViewController(nibName: "AuthViewController", bundle: nil)
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    //MARK: - AuthServiceDelegate
    
    func authServiceShouldShow(_ viewController: UIViewController) {
        print(#function)
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        print(#function)
        let galleryVC = GalleryViewController(nibName: "GalleryViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: galleryVC)
        window?.rootViewController = navVC
    }
    
    func authServiceSingiInDidFail() {
        print(#function)
    }
    
    func authServiceLogout() {
        self.authService = AuthService()
        authService.delegate = self
        let authVC = AuthViewController(nibName: "AuthViewController", bundle: nil)
        window?.rootViewController = authVC
        print(#function)
    }
}


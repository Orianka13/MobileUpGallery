//
//  GalleryManager.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 31.07.2021.
//

import Foundation
import UIKit

class GalleryManager {
    
    let authService = AuthService()
    
    func setupTopBar(navigationItem: UINavigationItem) {
        navigationItem.title = "Mobile Up Gallery"
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButton))
        exitButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = exitButton
        
    }
    func backButton(navigationItem: UINavigationItem) {
        let backButton = UIBarButtonItem(image: nil, style: .done, target: self, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    
    @objc func exitButton() {
        authService.logOut()
    }
    func dateFormatter(viewController: PhotoViewController, cellViewModel: PhotoViewModel.Cell ) {
        let date = cellViewModel.date
        let currentDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM YYYY"
        viewController.navigationItem.title = dateFormatter.string(from: currentDate)
    }
    

    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true)
    }
    
}

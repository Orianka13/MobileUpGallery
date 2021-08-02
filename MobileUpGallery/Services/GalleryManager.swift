//
//  GalleryManager.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 31.07.2021.
//

import Foundation
import UIKit
import VK_ios_sdk

class GalleryManager {
    
    let authService = AuthService()
    

    func backButton(navigationItem: UINavigationItem) {
        
        let backButton = UIBarButtonItem(image: nil, style: .done, target: self, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    
 
    func dateFormatter(viewController: PhotoViewController, cellViewModel: PhotoViewModel.Cell ) {
        let date = cellViewModel.date
        let currentDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM YYYY"
        viewController.navigationItem.title = dateFormatter.string(from: currentDate)
    }

    
}

//
//  GalleryManager.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 31.07.2021.
//

import Foundation
import UIKit
import VK_ios_sdk
import WebKit

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
        dateFormatter.locale = Locale(identifier: NSLocalizedString("ru_RU", comment: "ru_RU"))
        dateFormatter.dateFormat = "d MMMM YYYY"
        viewController.navigationItem.title = dateFormatter.string(from: currentDate)
    }
    
    func removeCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}

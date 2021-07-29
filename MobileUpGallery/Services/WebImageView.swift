//
//  WebImageView.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 23.07.2021.
//

import Foundation
import UIKit

class WebImageView: UIImageView {

    func setImageUrl(imageURL: String) {
        
        guard let url = URL(string: imageURL) else { return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            //print("from cache")
            return
        }
        //print("from internet")
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let response = response {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: data)
                        self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cacheResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cacheResponse, for: URLRequest(url: responseURL))
    }
}

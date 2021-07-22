//
//  NetworkService.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 22.07.2021.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getPhoto(){
        var components = URLComponents()
        
        guard let token = authService.token else {
            print("Error - no token")
            return
        }
        
        let params = ["owner_id": API.owner_id, "album_id": API.album_id]
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.photos
        components.queryItems = allParams.map{ URLQueryItem(name: $0, value: $1) }
        
        guard let url = components.url else {
            print("No url")
            return
        }
        print(url)
    }
}

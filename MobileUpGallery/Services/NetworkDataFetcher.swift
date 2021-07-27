//
//  NetworkDataFetcher.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 22.07.2021.
//

import Foundation

protocol DataFetcher {
    func getPhotos(response: @escaping (PhotosItem?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getPhotos(response: @escaping (PhotosItem?) -> Void) {
        let params = ["owner_id": API.owner_id, "album_id": API.album_id]
        networking.request(path: API.photos, params: params) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = decodeJSON(type: PhotosResponseWrapped.self, from: data)
            response(decoded?.response.items.randomElement())
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}

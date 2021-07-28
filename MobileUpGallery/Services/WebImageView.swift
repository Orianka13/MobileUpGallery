//
//  WebImageView.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 23.07.2021.
//

import Foundation
import UIKit

class WebImageView: UIImageView {

    func setImageUrl(imageURL: String){
        guard let url = URL(string: imageURL) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

                if let data = data {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: data)
                }
            }
        }
        dataTask.resume()
    }
}

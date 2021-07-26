//
//  PhotoCell.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 23.07.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    

    @IBOutlet weak var urlView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
//    func set(imageURL: String){
//        guard let url = URL(string: imageURL) else { return }
//        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//                if let data = data, let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.imageView.image = image
//                }
//            }
//        }
//        dataTask.resume()
//    }
}

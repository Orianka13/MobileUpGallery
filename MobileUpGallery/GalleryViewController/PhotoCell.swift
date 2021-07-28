//
//  PhotoCell.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 23.07.2021.
//

import UIKit

protocol PhotoCellViewModel {
    var photoUrlString: String { get }
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var urlView: WebImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: PhotoCellViewModel) {
        urlView.setImageUrl(imageURL: viewModel.photoUrlString)
    }
}

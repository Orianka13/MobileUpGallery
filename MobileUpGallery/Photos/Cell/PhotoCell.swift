//
//  PhotoCell.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 23.07.2021.
//

import UIKit


class PhotoCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())

    
    @IBOutlet weak var imageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set() {
     
    }
    

}

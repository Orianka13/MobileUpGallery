//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 21.07.2021.
//

import UIKit
import VK_ios_sdk

private let reuseIdentifier = "PhotoCell"

class GalleryViewController: UICollectionViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private let photoCell = PhotoCell()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
       
        cell.backgroundColor = .yellow
        
        fetcher.getPhotos { photosResponse in
                    guard let photosResponse = photosResponse else { return }
                    photosResponse.sizes.map { photosUrl in
                        self.set(imageURL: photosUrl.url, imageView: cell.imageView)
                        print(photosUrl.url)
                    }
    }
    
        return cell
    }
    
    func set(imageURL: String, imageView: UIImageView){
        guard let url = URL(string: imageURL) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                }
            }
        }
        dataTask.resume()
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


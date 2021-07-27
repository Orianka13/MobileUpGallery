//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 21.07.2021.
//

import UIKit
import VK_ios_sdk



class GalleryViewController: UICollectionViewController {
    private let reuseIdentifier = "photoCell"

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotoCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        //self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

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


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return 15
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        
        fetcher.getPhotos { photosResponse in
                    guard let photosResponse = photosResponse else { return }
            photosResponse.sizes.map { photosUrl in
                let url = photosUrl.url
             
                        let session = URLSession.shared
                        guard let url = URL(string: url) else { return }
                        session.dataTask(with: url) { data, response, error in
                                    if let data = data, let image = UIImage(data: data) {
                                        DispatchQueue.main.async {
                                            cell.urlView.image = image
                                            //print("а это должна быть фотка - \(image)")
                                    }
                                }
                            }.resume()
                    }
    }
        return cell
    }
    
//    guard let url = URL(string: imageURL) else { return }
//    let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            if let data = data, let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self?.imageView.image = image
//            }
//        }
//    }
//    dataTask.resume()

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

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}

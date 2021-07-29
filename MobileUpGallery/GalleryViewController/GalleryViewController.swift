//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 21.07.2021.
//

import UIKit
import VK_ios_sdk

class GalleryViewController: UICollectionViewController {
    
    private var authService: AuthService!
    
    private let reuseIdentifier = "photoCell"

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private var photoViewModel = PhotoViewModel.init(cells: [])
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotoCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        photoUrl()
        setupTopBar()
        
        authService = SceneDelegate.shared().authService
    }
    
    private func setupTopBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.title = "Mobile Up Gallery"
    
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButton))
        exitButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = exitButton
        
    }
    
    @objc func exitButton() {
        authService.logOut()
        dismiss(animated: true, completion: nil)
    }
    
    func backButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "chevron.backward"), style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    


    func photoUrl() {
            fetcher.getPhotos { photosResponse in
            guard let photosResponse = photosResponse else { return }
            
                photosResponse.items.map { photosUrl in
                let lastItem = photosUrl.sizes.last
                guard let url = lastItem?.url else { return }
                    let cell = PhotoViewModel.Cell.init(photoUrlString: url)
                    self.photoViewModel.cells.append(cell)
                    self.collectionView.reloadData()
            }
    }
    }
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.cells.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let cellViewModel = photoViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoViewController()
        backButton()
        let cellViewModel = photoViewModel.cells[indexPath.row]
        let url = cellViewModel.photoUrlString
        photoVC.photoUrl = url
        navigationController?.pushViewController(photoVC, animated: true)
    }

}

// settings of displaying photoGallery

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

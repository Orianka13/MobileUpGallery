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
    weak var delegate: AuthServiceDelegate?
    
    private let reuseIdentifier = "photoCell"

    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private var photoViewModel = PhotoViewModel.init(cells: [])
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotoCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        photoUrl()
        setupTopBar()
        
        authService = SceneDelegate.shared().authService
    }
    
    private func setupTopBar() {
        self.navigationItem.title = "Mobile Up Gallery"
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButton))
        exitButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = exitButton
        
    }
    
    @objc func exitButton() {
        authService.logOut()
    }
    
    private func backButton() {
        let backButton = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    
    private func dateFormatter(viewController: PhotoViewController, cellViewModel: PhotoViewModel.Cell ) {
        let date = cellViewModel.date
        let currentDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM YYYY"
        viewController.navigationItem.title = dateFormatter.string(from: currentDate)
    }

    private func photoUrl() {
            fetcher.getPhotos { photosResponse in
            guard let photosResponse = photosResponse else { return }
            
                photosResponse.items.map { photosUrl in
                let lastItem = photosUrl.sizes.last
                guard let url = lastItem?.url else { return }
                let date = photosUrl.date
                    let cell = PhotoViewModel.Cell.init(photoUrlString: url, date: date)
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
        
        dateFormatter(viewController: photoVC, cellViewModel: cellViewModel)
        
        navigationController?.pushViewController(photoVC, animated: true)
        
    }

}

// settings of displaying photoGallery

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingWidth = sectionInserts.bottom
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.bottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.bottom
    }
    
    
}

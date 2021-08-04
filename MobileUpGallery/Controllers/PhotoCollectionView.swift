//
//  PhotoCollectionView.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 03.08.2021.
//

import UIKit

class PhotoCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let reuseIdentifier = "photoCell"
    var photoViewModel = PhotoViewModel.init(cells: [])
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        backgroundColor = .white
        let nib = UINib(nibName: "PhotoCell", bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
       
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        cell.activityIndicator.startAnimating()
        
        let cellViewModel = photoViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        
        cell.activityIndicator.stopAnimating()
        cell.activityIndicator.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVC = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        let cellViewModel = photoViewModel.cells[indexPath.row]
        let url = cellViewModel.photoUrlString
        photoVC.photoUrl2 = url
        photoVC.loadViewIfNeeded()
        photoVC.setPhoto2()
    }
}

extension PhotoCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

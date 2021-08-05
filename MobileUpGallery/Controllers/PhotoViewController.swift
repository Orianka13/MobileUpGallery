//
//  PhotoViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 29.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoUrl: String?
    var photoUrl2: String?
    var photoScrollView: PhotoScrollView!
    var photoCollectionView = PhotoCollectionView()
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    @IBOutlet weak var photoImage: WebImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        saveButton()
        setPhoto()
        
        setupPhotoScrollView()
        setupCollectionView()
    }
    
    func setPhoto() {
        guard let photoUrl = photoUrl else {
            showAlert(title: NSLocalizedString("Ошибка", comment: "Ошибка"), message: NSLocalizedString("Ошибка загрузки изображения", comment: "Ошибка загрузки изображения"))
            return }
        photoImage.setImageUrl(imageURL: photoUrl)
    }
    
    private func saveButton() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(loadImage))
        saveButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func loadImage() {
        guard let image = photoImage.image else {
            showAlert(title: NSLocalizedString("Ошибка", comment: "Ошибка"), message: NSLocalizedString("Ошибка получения изображения", comment: "Ошибка получения изображения"))
            return }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, error in
            if bool {
                self.showAlert(title: NSLocalizedString("Сохранено!", comment: "Сохранено!"), message: NSLocalizedString("Изображение сохранено в ваши фотографии.", comment: "Изображение сохранено в ваши фотографии."))
            } else if error != nil {
                self.showAlert(title: NSLocalizedString("Ошибка сохранения", comment: "Ошибка сохранения"), message: error?.localizedDescription ?? NSLocalizedString("Изображение не сохранено", comment: "Изображение не сохранено"))
            }
        }
        present(shareController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func setupPhotoScrollView() {
        photoScrollView = PhotoScrollView(frame: photoImage.bounds)
        view.addSubview(photoScrollView)
        
        photoScrollView.translatesAutoresizingMaskIntoConstraints = false
        photoScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photoScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        let imgRik = UIImage(named: "rik")!
        photoScrollView.set(image: photoImage.image ?? imgRik)
        photoImage.isHidden = true
    }
    
    func setupCollectionView() {
        view.addSubview(photoCollectionView)
        
        photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34).isActive = true
        
        photoCollectionView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        fetcher.getPhotos { photosResponse in
            guard let photosResponse = photosResponse else {
                return }
            
            photosResponse.items.map { photosUrl in
                let lastItem = photosUrl.sizes.last
                guard let url = lastItem?.url else {
                    return }
                let date = photosUrl.date
                let cell = PhotoViewModel.Cell.init(photoUrlString: url, date: date)
                self.photoCollectionView.photoViewModel.cells.append(cell)
                self.photoCollectionView.reloadData()
            }
        }
    }
}



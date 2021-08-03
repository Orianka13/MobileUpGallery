//
//  PhotoViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 29.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoUrl: String?
    var photoScrollView: PhotoScrollView!
    
    
    @IBOutlet weak var photoImage: WebImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        saveButton()
        setPhoto()
        
        setupPhotoScrollView()
    }
    
    private func setPhoto() {
        guard let photoUrl = photoUrl else {
            showAlert(title: "Ошибка", message: "Ошибка загрузки изображения")
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
            showAlert(title: "Ошибка", message: "Ошибка получения изображения")
            return }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, error in
            if bool {
                self.showAlert(title: "Сохранено!", message: "Изображение сохранено в ваши фотографии.")
            } else if error != nil {
                self.showAlert(title: "Ошибка сохранения", message: error?.localizedDescription ?? "Изображение не сохранено")
            }
        }
        present(shareController, animated: true, completion: nil)
        
        //UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //    @objc func image(_ image: WebImageView, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    //        if let error = error {
    //            showAlert(title: "Ошибка сохранения", message: error.localizedDescription)
    //        } else {
    //            showAlert(title: "Сохранено!", message: "Изображение сохранено в ваши фотографии.")
    //        }
    //    }
    
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
        
        photoScrollView.set(image: photoImage.image!)
        photoImage.isHidden = true
    }
}



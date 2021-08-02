//
//  PhotoViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 29.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    var photoUrl: String?

    @IBOutlet weak var photoImage: WebImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhoto()
        saveButton()
    }

    private func setPhoto() {
        guard let photoUrl = photoUrl else { return }
        photoImage.setImageUrl(imageURL: photoUrl)
    }
    
    private func saveButton() {
    
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(loadImage))
        saveButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func loadImage() {
        guard let image = photoImage.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: WebImageView, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "This image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
          present(ac, animated: true)
        }
    }
}



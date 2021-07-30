//
//  PhotoViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 29.07.2021.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImage: WebImageView!
    
    var photoUrl: String?
    
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
    
    @objc private func loadImage() {
        guard let image = photoImage.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

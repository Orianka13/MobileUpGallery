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

    }
    
    private func setPhoto() {
        guard let urlString = photoUrl else { return }
        photoImage.setImageUrl(imageURL: urlString)
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

//
//  PhotoScrollView.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 02.08.2021.
//

import UIKit

class PhotoScrollView: UIScrollView, UIScrollViewDelegate {
    
    var imageZoomView: WebImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerImage()
    }
    
    func set(image: UIImage) {
        
//        imageZoomView?.removeFromSuperview()
//        imageZoomView = nil
        imageZoomView = WebImageView(image: image)
        self.addSubview(imageZoomView)
        
        configurateFor(imageSize: image.size)
    }
    
    func configurateFor(imageSize: CGSize) {
        self.contentSize = imageSize
        
        setCurrentMaxandMinZoomScale()
        self.zoomScale = self.minimumZoomScale
    }
    
    func setCurrentMaxandMinZoomScale() {
        
        let boundsSize = self.bounds.size
        let imageSize = imageZoomView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 3.0
        if minScale < 0.1 {
            maxScale = 0.5
        }
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 1.0
        }
        if minScale >= 0.7 {
            maxScale = max(3.0, minScale)
        }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = maxScale
    }
    
    func centerImage() {
        
        let boundsSize = self.bounds.size
        var frameToCenter = imageZoomView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }

        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
  
        imageZoomView.frame = frameToCenter

    }
    
    //MARK: - UIScrollViewDelegate

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
}


//
//  PhotosPresenter.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 22.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotosPresentationLogic {
  func presentData(response: Photos.Model.Response.ResponseType)
}

class PhotosPresenter: PhotosPresentationLogic {
  weak var viewController: PhotosDisplayLogic?
  
  func presentData(response: Photos.Model.Response.ResponseType) {
  
  }
  
}

//
//  PhotosInteractor.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 22.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotosBusinessLogic {
  func makeRequest(request: Photos.Model.Request.RequestType)
}

class PhotosInteractor: PhotosBusinessLogic {

  var presenter: PhotosPresentationLogic?
  var service: PhotosService?
  
  func makeRequest(request: Photos.Model.Request.RequestType) {
    if service == nil {
      service = PhotosService()
    }
  }
  
}

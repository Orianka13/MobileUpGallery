//
//  PhotosViewController.swift
//  MobileUpGallery
//
//  Created by Олеся Егорова on 22.07.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotosDisplayLogic: class {
  func displayData(viewModel: Photos.Model.ViewModel.ViewModelData)
}

class PhotosViewController: UIViewController, PhotosDisplayLogic {

  var interactor: PhotosBusinessLogic?
  var router: (NSObjectProtocol & PhotosRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = PhotosInteractor()
    let presenter             = PhotosPresenter()
    let router                = PhotosRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: Photos.Model.ViewModel.ViewModelData) {

  }
  
}

//
//  AppNavController.swift
//  HalfModalPresentationController
//
//  Created by Martin Normark on 28/01/16.
//  Copyright © 2016 martinnormark. All rights reserved.
//

import UIKit

class AppNavController: UINavigationController, HalfModalPresentable {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.round([.topLeft,.topRight], corner: 20)
    //self.navigationBar.roundd([.topLeft,.topRight], corner: 20)
  }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isHalfModalMaximized() ? .default : .lightContent
    }
}


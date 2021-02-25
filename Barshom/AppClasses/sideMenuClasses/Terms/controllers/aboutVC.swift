//
//  aboutVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

enum aboutType {
  case about,terms
}
class aboutVC: UIViewController {

  @IBOutlet weak var logoImg: UIImageView!
  
  var type:aboutType?
  
  override func viewDidLoad() {
        super.viewDidLoad()
    if type == .about {
      logoImg.image = #imageLiteral(resourceName: "logo")
    }else {
      logoImg.image = #imageLiteral(resourceName: "shorot")
    }
    
    }
    

   

}

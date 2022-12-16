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
    @IBOutlet weak var textView: UITextView!

  var type:aboutType?
  var userType = "user"
  override func viewDidLoad() {
        super.viewDidLoad()
    var url = ""
    if type != .about
    {
        
            switch userType {
            case "user":
                self.title =  clientMenuType.termsAndConditions.rawValue.localized()
                url = LanguageManager.isArabic ? Constants.APIProvider.getTerms : Constants.APIProvider.getTermsEN
                break;
            case "worker":
                self.title =  driverMenuType.termsAndConditions.rawValue.localized()
                url = LanguageManager.isArabic ? Constants.APIProvider.getTermsDriver : Constants.APIProvider.getTermsDriverEN
                break;
            default:
                self.title =  traderMenuType.termsAndConditions.rawValue.localized()
                url = LanguageManager.isArabic ? Constants.APIProvider.getTermsMarket : Constants.APIProvider.getTermsMarketEN
                break;
            }
        
    }
    else
    {
        self.title =  Resources.Common.about

        url = LanguageManager.isArabic ? Constants.APIProvider.getAbout : Constants.APIProvider.getAboutEN
    }
   
    textView.text = ""
    if type == .about {
      logoImg.image = #imageLiteral(resourceName: "logo")
    }else {
      logoImg.image = #imageLiteral(resourceName: "shorot")
    }
    
    UserService.shared.getTermsAbout(url: url) { (text) in
        self.textView.text = text.html2String
    }
    }
    

   

}

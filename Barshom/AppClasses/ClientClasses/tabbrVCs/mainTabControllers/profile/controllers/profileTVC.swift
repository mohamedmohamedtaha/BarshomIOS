//
//  profileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

class profileTVC: UITableViewController {

  @IBOutlet weak var nameTxt: UILabel!
  @IBOutlet weak var mobileTxt: UILabel!
  @IBOutlet weak var emailTxt: UILabel!
  @IBOutlet weak var cityTxt: UILabel!
  @IBOutlet weak var clientCodeTxt: UILabel!
  @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleUserData()
    }
    func  handleUserData()
    {
        nameTxt.text = UserManager.getUserData!.adv_name!
        mobileTxt.text = UserManager.getUserData!.adv_mobile!
        emailTxt.text = UserManager.getUserData!.adv_email!
        cityTxt.text = UserManager.getUserData!.city_name!
        clientCodeTxt.text = UserManager.getUserData!.adv_user_code!
        img.sd_setImage(with: URL(string: UserManager.getUserData!.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "logoWhite"))

    }
    @IBAction func copyCodeClicked()
    {
        UIPasteboard.general.string = UserManager.getUserData!.adv_user_code!
        AppHelper.showSuccessAlertWithoutButtons(vc: self, message: LanguageManager.isArabic ? "تم نسخ كود العميل" : "Client code copied")
    }
}

//
//  driverProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class driverProfileTVC: UITableViewController {

    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var name2Txt: UILabel!
    @IBOutlet weak var mobileTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var cityTxt: UILabel!
    @IBOutlet weak var driverCodeTxt: UILabel!
    @IBOutlet weak var carTypeTxt: UILabel!
    @IBOutlet weak var bankNameTxt: UILabel!
    @IBOutlet weak var ownerNameTxt: UILabel!
    @IBOutlet weak var accountNumberTxt: UILabel!
    @IBOutlet weak var swiftCodeTxt: UILabel!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var licenseIV: UIImageView!
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
        name2Txt.text =  UserManager.getUserData!.adv_name!
        mobileTxt.text = UserManager.getUserData!.adv_mobile!
        emailTxt.text = UserManager.getUserData!.adv_email!
        cityTxt.text = UserManager.getUserData!.city_name!
        carTypeTxt.text = UserManager.getUserData!.adv_car_type!
        bankNameTxt.text = UserManager.getUserData!.adv_bank_name!
        ownerNameTxt.text = UserManager.getUserData!.adv_owner_name!
        accountNumberTxt.text = UserManager.getUserData!.adv_account_number!
        driverCodeTxt.text = UserManager.getUserData!.adv_user_code!
        swiftCodeTxt.text = UserManager.getUserData!.adv_ipan_number!
        userIV.sd_setImage(with: URL(string: UserManager.getUserData!.imageUrl ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
        licenseIV.sd_setImage(with: URL(string: UserManager.getUserData!.licenseImage ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))

    }
  @IBAction func editPasswordAction(_ sender: UIButton) {
    let vc = editPasswordTVC.instantiate(.Profile)
    self.show(vc, sender: nil)
  }
    @IBAction func copyCodeClicked()
    {
        UIPasteboard.general.string = UserManager.getUserData!.adv_user_code!
        AppHelper.showSuccessAlertWithoutButtons(vc: self, message: LanguageManager.isArabic ? "تم نسخ كود العميل" : "Client code copied")
    }
    @IBAction func editProfileAction(_ sender: UIButton) {
        AppHelper.showInfoAlert(message: LanguageManager.isArabic ? "لتعديل حسابك يرجى فتج تذكرة و ادخال البيانات المراد تحديثها" : "To edit your profile , kindly open a ticket and fill it with the updated info.", confirmBtnTitle: Resources.Common.ok) {
            let packages = complaintListVC.instantiate(.complaint)
            self.show(packages, sender: nil)
        }
    }
}

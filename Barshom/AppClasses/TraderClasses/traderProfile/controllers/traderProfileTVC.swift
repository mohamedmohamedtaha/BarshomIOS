//
//  traderProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

class traderProfileTVC: UITableViewController {

    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var name2Txt: UILabel!
    @IBOutlet weak var mobileTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var cityTxt: UILabel!
    @IBOutlet weak var driverCodeTxt: UILabel!
    @IBOutlet weak var storeTypeTxt: UILabel!
    @IBOutlet weak var addressTxt: UILabel!
    @IBOutlet weak var bankNameTxt: UILabel!
    @IBOutlet weak var ownerNameTxt: UILabel!
    @IBOutlet weak var accountNumberTxt: UILabel!
    @IBOutlet weak var swiftCodeTxt: UILabel!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var commercialIV: UIImageView!
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
//        addressTxt.text = UserManager.getUserData!.adv_map_location!
        storeTypeTxt.text = UserManager.getUserData!.cat_name!
        bankNameTxt.text = UserManager.getUserData!.adv_bank_name!
        ownerNameTxt.text = UserManager.getUserData!.adv_owner_name!
        accountNumberTxt.text = UserManager.getUserData!.adv_account_number!
        driverCodeTxt.text = UserManager.getUserData!.adv_user_code!
        swiftCodeTxt.text = UserManager.getUserData!.adv_ipan_number!
        userIV.sd_setImage(with: URL(string: UserManager.getUserData!.imageUrl ?? "empty"), placeholderImage: UIImage(named: "logoWhite")!)
        licenseIV.sd_setImage(with: URL(string: UserManager.getUserData!.licenseImage ?? "empty"), placeholderImage: UIImage(named: "logoWhite")!)
        commercialIV.sd_setImage(with: URL(string: UserManager.getUserData!.commercialRecordImage ?? "empty"), placeholderImage: UIImage(named: "logoWhite")!)
        getCoordinatesBack(lat: UserManager.getUserData!.getLat().trimmed, lng: UserManager.getUserData!.getLng().trimmed)


    }
    func getCoordinatesBack(lat: String, lng: String) {
        UserService.shared.getPlaceDetails(lat: lat, lng: lng) { (data) in
            if(data.count > 0)
            {
                self.addressTxt.text = data.first!.formatted_address!
            }
        }
    }
    
  @IBAction func editPasswordAction(_ sender: UIButton) {
    let vc = editPasswordTVC.instantiate(.Profile)
    self.show(vc, sender: nil)
  }
    @IBAction func editProfileAction(_ sender: UIButton) {
        AppHelper.showInfoAlert(message: LanguageManager.isArabic ? "لتعديل حسابك يرجى فتج تذكرة و ادخال البيانات المراد تحديثها" : "To edit your profile , kindly open a ticket and fill it with the updated info.", confirmBtnTitle: Resources.Common.ok) {
            let packages = complaintListVC.instantiate(.complaint)
            self.show(packages, sender: nil)
        }
    }

}

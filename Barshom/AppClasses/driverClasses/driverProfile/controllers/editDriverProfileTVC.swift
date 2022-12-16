//
//  editDriverProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit
import DropDown
import PopupDialog
import Photos
import AVFoundation
import MobileCoreServices

class editDriverProfileTVC: UITableViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  @IBOutlet weak var nameTxt: RVTxtFaild!
  @IBOutlet weak var storeTxt: RVTxtFaild!
  @IBOutlet weak var mobileTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var cityTxt: RVTxtFaild!
    @IBOutlet weak var name2Txt: RVTxtFaild!
  @IBOutlet weak var carTypeTxt: RVTxtFaild!
  
  @IBOutlet weak var bankNameTxt: RVTxtFaild!
  @IBOutlet weak var ownerNameTxt: RVTxtFaild!
  @IBOutlet weak var accountNumberTxt: RVTxtFaild!
  @IBOutlet weak var swiftCodeTxt: RVTxtFaild!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var licenseIV: UIImageView!
      var dropDown = DropDown()
      var allCities = [City]()
      var selectedCity : City?
    var selectedImgAttach : Attachment?
    var selectedLicenseImgAttach : Attachment?
    var isUserImg = true
    override func viewDidLoad() {
        super.viewDidLoad()
      nameTxt.AddImage(#imageLiteral(resourceName: "info"))
      storeTxt.AddImage(#imageLiteral(resourceName: "info"))
      mobileTxt.AddImage(#imageLiteral(resourceName: "contact"))
      emailTxt.AddImage(#imageLiteral(resourceName: "email"))
      cityTxt.AddImage(#imageLiteral(resourceName: "locate-1"))
      
      carTypeTxt.AddImage(#imageLiteral(resourceName: "car"))
        getUserData()

    }
    
      func getUserData()
      {
          UserService.shared.getUserData(userID: UserManager.getUserData!.id!) { (data) in
              UserManager.saveUserInfo(user: data as! [String : Any])
              self.handleUserData()
          }
      }
      func  handleUserData()
      {
          selectedCity = City(JSON: ["":""])!
          selectedCity!.city_id = UserManager.getUserData!.adv_city_id
          selectedCity!.city_name = UserManager.getUserData!.city_name
        nameTxt.text = UserManager.getUserData!.adv_name!
        name2Txt.text =  UserManager.getUserData!.adv_name!
        mobileTxt.text = UserManager.getUserData!.adv_mobile!
        emailTxt.text = UserManager.getUserData!.adv_email!
        cityTxt.text = UserManager.getUserData!.city_name!
        carTypeTxt.text = UserManager.getUserData!.adv_car_type!
        bankNameTxt.text = UserManager.getUserData!.adv_bank_name!
        ownerNameTxt.text = UserManager.getUserData!.adv_owner_name!
        accountNumberTxt.text = UserManager.getUserData!.adv_account_number!
        swiftCodeTxt.text = UserManager.getUserData!.adv_ipan_number!
        userIV.sd_setImage(with: URL(string: UserManager.getUserData!.imageUrl ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
        licenseIV.sd_setImage(with: URL(string: UserManager.getUserData!.licenseImage ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
      }
      @IBAction func selectImg()
      {
        isUserImg = true
         showImagePicker()
      }
    @IBAction func selectLicenseImg()
    {
      isUserImg = false
       showImagePicker()
    }
      @IBAction func editClicked()
      {
          var isValid = true
          var errorMessages: [String] = []
          if !ValidationHelper.isValidName(nameTxt.text!) {
              isValid = false
              errorMessages.append(Resources.Login.nameRequired)
          }
          if !ValidationHelper.isValidName(mobileTxt.text!) {
              isValid = false
              errorMessages.append(Resources.Login.mobileRequired)
          }
          if !ValidationHelper.isValidName(emailTxt.text!) {
              isValid = false
              errorMessages.append(Resources.Login.emailOnlyRequired)
          }
          if selectedCity == nil {
              isValid = false
              errorMessages.append(Resources.Login.choosecity)
          }
          
  //        if !ValidationHelper.isValidName(addressTxt.text!) {
  //            isValid = false
  //            errorMessages.append(Resources.Login.familyAddressRequired)
  //        }
          

          if !isValid {
              AppHelper.showErrorAlert(message: errorMessages.joined(separator: "\n"))
          } else {
              var pars = [
                  "name":nameTxt.text!,
                  "mobile":mobileTxt.text!,
                "email":emailTxt.text!,
                "bankName":bankNameTxt.text!,
                "accountName":accountNumberTxt.text!,
                "accountNumber":swiftCodeTxt.text!,
                "ipanNumber":swiftCodeTxt.text!,
                  "cityId":selectedCity!.city_id!,
                  "userType":"worker",
                  "userId":  UserManager.getUserData!.id!
              ] as! [String : Any]
              var imgs = [Attachment]()
              if selectedImgAttach != nil {
                  imgs.append(selectedImgAttach!)
              }
            if selectedLicenseImgAttach != nil {
                imgs.append(selectedLicenseImgAttach!)
            }
              UserService.shared.updateUserProfile(parameters: pars, images: imgs) { (data) in
                  UserManager.saveUserInfo(user: (data as! [String:Any])["return"] as! [String:Any])
                  AppHelper.showSuccessAlert(message: Resources.Common.profileUpdatedSuccessfuly, confirmBtnTitle: Resources.Common.ok) {
                      self.navigationController?.popViewController(animated: true)
                  }
              }
          }
      }
      @IBAction func cityClicked(_ sender: UIButton) {
          dropDown.anchorView = sender
          dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
          dropDown.backgroundColor = UIColor.white
          //dropDown.cellNib = UINib(nibName: "dropdowenCell", bundle: nil)
          dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
              //guard let cell = cell as? dropdowenCell else { return }
              cell.optionLabel.textAlignment = LanguageManager.isArabic ? .right : .left
              
          }
          if allCities.count == 0
          {
              UserService.shared.getCities { (cities) in
                  self.allCities = cities
                  self.showDirectionsMenu(cities: self.allCities)

              }
          }
          else
          {
              self.showDirectionsMenu(cities: allCities)
          }
      }
      func showDirectionsMenu(cities : [City])
      {
          let cit = cities
          self.dropDown.dataSource = cit.map{LanguageManager.isArabic ? $0.city_name! : $0.city_name!}
          self.dropDown.selectionAction = { [self](index: Int, item: String) in
          
                  selectedCity = allCities[index]
                  cityTxt.text = LanguageManager.isArabic ? selectedCity?.city_name! : selectedCity?.city_name!

              
          }
          self.dropDown.show()
      }
      func showImagePicker()
      {
          let title = Resources.Common.addImages
          let message = Resources.Common.imageSource
          
          // Add buttons to dialog
          let popup = PopupDialog(title: title, message: message, preferredWidth: 580)
          
          let libraryBtn = DefaultButton(title: Resources.Common.photoLibrary) {
              
              AppHelper.requestLibraryAcces(vc: self, completionHandler: {
                  self.showImagePickerWithSourceType(.photoLibrary, sender: self.view)
                  
              })
              //            self.initImagePicker(forSourceType: .photoLibrary, trigger: trigger)
          }
          let cameraBtn = DefaultButton(title: Resources.Common.camera) {
              AppHelper.requestCameraAcces(vc: self, completionHandler: {
                  self.showImagePickerWithSourceType(.camera, sender: self.view)
              })
              //            self.initImagePicker(forSourceType: .camera, trigger: trigger)
          }
          let cancelBtn = CancelButton(title: Resources.Common.cancel)  {
              popup.dismiss(animated: true, completion: nil)
          }
          popup.addButtons([libraryBtn, cameraBtn, cancelBtn])
          
          // Present dialog
          self.present(popup, animated: true, completion: nil)
      }
      
      func showImagePickerWithSourceType(_ sourceType: UIImagePickerController.SourceType, sender: UIView?) {
          
          let picker = UIImagePickerController()
          picker.delegate = self
          picker.sourceType = sourceType;
          picker.mediaTypes = [kUTTypeImage as String]
          picker.allowsEditing = false
          DispatchQueue.main.async {
              self.present(picker, animated: true, completion: nil)
          }
      }
      
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          var selectedImage: UIImage?
          if let editedImage = info[.editedImage] as? UIImage {
              selectedImage = editedImage
              picker.dismiss(animated: true) {
                  self.delay(time: 0.1) { [self] in
                    
                    if (isUserImg)
                    {
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"

                    }
                    else
                    {
                        self.selectedLicenseImgAttach = Attachment()
                        self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                        self.licenseIV.image = selectedImage!.handleOrientation()
                        self.selectedLicenseImgAttach!.name = "licenseImage"

                    }
                  }
              }
          } else if let originalImage = info[.originalImage] as? UIImage {
              selectedImage = originalImage
              picker.dismiss(animated: true) {
                self.delay(time: 0.1) { [self] in
                    if (isUserImg)
                    {
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"

                    }
                    else
                    {
                        self.selectedLicenseImgAttach = Attachment()
                        self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                        self.licenseIV.image = selectedImage!.handleOrientation()
                        self.selectedLicenseImgAttach!.name = "licenseImage"

                    }
                  }
              }
              
              
          }
      }
}

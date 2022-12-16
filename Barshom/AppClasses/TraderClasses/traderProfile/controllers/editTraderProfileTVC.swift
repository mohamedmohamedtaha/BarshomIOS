//
//  editTraderProfileTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit
import PopupDialog
import Photos
import AVFoundation
import MobileCoreServices

class editTraderProfileTVC: UITableViewController ,MapVCDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  @IBOutlet weak var nameTxt: RVTxtFaild!
  @IBOutlet weak var storeTxt: RVTxtFaild!
  @IBOutlet weak var mobileTxt: RVTxtFaild!
  @IBOutlet weak var emailTxt: RVTxtFaild!
  @IBOutlet weak var storeTypeTxt: RVTxtFaild!
  
  @IBOutlet weak var bankNameTxt: RVTxtFaild!
  @IBOutlet weak var ownerNameTxt: RVTxtFaild!
  @IBOutlet weak var accountNumberTxt: RVTxtFaild!
  @IBOutlet weak var swiftCodeTxt: RVTxtFaild!
    @IBOutlet weak var userIV: UIImageView!
    @IBOutlet weak var commercialIV: UIImageView!
    @IBOutlet weak var licenseIV: UIImageView!
    @IBOutlet weak var addressBg: UIView!
    @IBOutlet weak var hasAddressBg: UIView!
    @IBOutlet weak var addressLb: UILabel!
    var selectedAddress : Address?
    var imgType = 0
    var selectedImgAttach : Attachment?
    var selectedLicenseImgAttach : Attachment?
    var selectedCommercialImgAttach : Attachment?
    override func viewDidLoad() {
        super.viewDidLoad()
      nameTxt.AddImage(#imageLiteral(resourceName: "info"))
      storeTxt.AddImage(#imageLiteral(resourceName: "store"))
      mobileTxt.AddImage(#imageLiteral(resourceName: "contact"))
      emailTxt.AddImage(#imageLiteral(resourceName: "email"))
      storeTypeTxt.AddImage(#imageLiteral(resourceName: "store"))
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleUserData()
    }
    func  handleUserData()
    {
        nameTxt.text = UserManager.getUserData!.adv_name!
        storeTxt.text =  UserManager.getUserData!.adv_name!
        mobileTxt.text = UserManager.getUserData!.adv_mobile!
        emailTxt.text = UserManager.getUserData!.adv_email!
        
        storeTypeTxt.text = UserManager.getUserData!.cat_name!
        bankNameTxt.text = UserManager.getUserData!.adv_bank_name!
        ownerNameTxt.text = UserManager.getUserData!.adv_owner_name!
        accountNumberTxt.text = UserManager.getUserData!.adv_account_number!
        swiftCodeTxt.text = UserManager.getUserData!.adv_ipan_number!
        userIV.sd_setImage(with: URL(string: UserManager.getUserData!.imageUrl ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
        licenseIV.sd_setImage(with: URL(string: UserManager.getUserData!.licenseImage ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
        commercialIV.sd_setImage(with: URL(string: UserManager.getUserData!.commercialRecordImage ?? "empty"), placeholderImage: #imageLiteral(resourceName: "logoWhite"))
        handleAdress()
        getCoordinatesBack(lat: UserManager.getUserData!.getLat(), lng: UserManager.getUserData!.getLng())
    }

    func handleAdress()
    {
        if selectedAddress != nil {
            self.addressLb.text = selectedAddress!.address
            self.hasAddressBg.isHidden = false
            self.addressBg.isHidden = true
        }
        else
        {
            self.addressLb.text = ""
            self.hasAddressBg.isHidden = true
            self.addressBg.isHidden = false
        }
    }
    @IBAction func addressAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
    func getCoordinatesBack(lat: String, lng: String) {
        UserService.shared.getPlaceDetails(lat: lat, lng: lng) { (data) in
            if(data.count > 0)
            {
            self.selectedAddress = Address(JSON: ["" : ""])!
                self.selectedAddress!.address = data.first!.formatted_address!
                self.selectedAddress!.lat = "\(data.first!.geometry!.location!.lat!)"
                self.selectedAddress!.lng = "\(data.first!.geometry!.location!.lng!)"
                self.handleAdress()
            }
        }
    }
    @IBAction func selectImg()
    {
      imgType = 0
       showImagePicker()
    }
  @IBAction func selectLicenseImg()
  {
    imgType = 1
    showImagePicker()
  }
    @IBAction func selectCommercialImg()
    {
        imgType = 2
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
        
        
        if selectedAddress == nil {
            isValid = false
            errorMessages.append(Resources.Login.familyAddressRequired)
        }
        

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
                "mapLocation":"\(selectedAddress!.lat),\(selectedAddress!.lng)",
                "userType":"company",
                "userId":  UserManager.getUserData!.id!
            ] as! [String : Any]
            var imgs = [Attachment]()
            if selectedImgAttach != nil {
                imgs.append(selectedImgAttach!)
            }
          if selectedLicenseImgAttach != nil {
              imgs.append(selectedLicenseImgAttach!)
          }
            if selectedLicenseImgAttach != nil {
                imgs.append(selectedCommercialImgAttach!)
            }
            UserService.shared.updateUserProfile(parameters: pars, images: imgs) { (data) in
                UserManager.saveUserInfo(user: (data as! [String:Any])["return"] as! [String:Any])
                AppHelper.showSuccessAlert(message: Resources.Common.profileUpdatedSuccessfuly, confirmBtnTitle: Resources.Common.ok) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
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
                    switch imgType
                    {
                        case 0:
                            self.selectedImgAttach = Attachment()
                            self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedImgAttach!.mimeType = "image/jpeg"
                            self.userIV.image = selectedImage!.handleOrientation()
                            self.selectedImgAttach!.name = "imageData"
                        case 1 :
                            self.selectedLicenseImgAttach = Attachment()
                            self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                            self.licenseIV.image = selectedImage!.handleOrientation()
                            self.selectedImgAttach!.name = "licenseImage"
                        case 2:
                            self.selectedCommercialImgAttach = Attachment()
                            self.selectedCommercialImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedCommercialImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedCommercialImgAttach!.mimeType = "image/jpeg"
                            self.commercialIV.image = selectedImage!.handleOrientation()
                            self.selectedCommercialImgAttach!.name = "licenseImage"
                        default:
                            self.selectedImgAttach = Attachment()
                            self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                            self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                            self.selectedImgAttach!.mimeType = "image/jpeg"
                            self.userIV.image = selectedImage!.handleOrientation()
                            self.selectedImgAttach!.name = "imageData"
                    }
                 
                }
            }
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            picker.dismiss(animated: true) {
              self.delay(time: 0.1) { [self] in
                    
                
                switch imgType
                {
                    case 0:
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"
                    case 1 :
                        self.selectedLicenseImgAttach = Attachment()
                        self.selectedLicenseImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedLicenseImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedLicenseImgAttach!.mimeType = "image/jpeg"
                        self.licenseIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "licenseImage"
                    case 2:
                        self.selectedCommercialImgAttach = Attachment()
                        self.selectedCommercialImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedCommercialImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedCommercialImgAttach!.mimeType = "image/jpeg"
                        self.commercialIV.image = selectedImage!.handleOrientation()
                        self.selectedCommercialImgAttach!.name = "commercialRecordImage"
                    default:
                        self.selectedImgAttach = Attachment()
                        self.selectedImgAttach!.data = selectedImage!.handleOrientation().jpegData(compressionQuality: 0.6)!
                        self.selectedImgAttach!.fileName = "\(Date().trimTime.timeIntervalSince1970).jpeg"
                        self.selectedImgAttach!.mimeType = "image/jpeg"
                        self.userIV.image = selectedImage!.handleOrientation()
                        self.selectedImgAttach!.name = "imageData"
                }
                }
            }
            
            
        }
    }
}

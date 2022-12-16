//
//  AddressVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 02/05/2021.
//


import UIKit
import MapKit
import GooglePlaces
import DZNEmptyDataSet

protocol AddressDelegate {
    func getAddress(address : AddressModel) -> Void
}
class AddressVC: UIViewController, MapVCDelegate  {
    
    
    @IBOutlet weak var tableView : UITableView!

    var delegate : AddressDelegate?
    var notificationList = [AddressModel]()


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Resources.Login.useraddress
        tableView.register(UINib(nibName: addressCell.identifier, bundle: nil), forCellReuseIdentifier: addressCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        getNotifications()
    }
    func getNotifications()
    {
        UserService.shared.getUserAddress { (data) in
            self.notificationList = data
            self.tableView.reloadData()
        }
    }
    
    @IBAction func selectActionButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func getCoordinatesBack(lat: String, lng: String) {
        UserService.shared.getPlaceDetails(lat: lat, lng: lng) { (data) in
            if(data.count > 0)
            {
                AppHelper.showAlertWithTextField(textplaceholder: Resources.Common.enterAddressName, title: data[0].formatted_address!, btnTitle: Resources.Common.add) { (text) in
                    let pars = [
                        "addressName": text,
                        "addressText": data[0].formatted_address!,
                        "addressLocation": "\(data.first!.geometry!.location!.lat!),\(data.first!.geometry!.location!.lng!)",
                        "userId": UserManager.getUserData!.id!
                    ]
                    UserService.shared.addUserAddress(pars: pars) { (data) in
                        self.getNotifications()
                    }
                    
                }
         
            }
        }
    }
}

extension AddressVC : cellSelectionDelegate
{
    func selected(index: Int) {
        self.delegate?.getAddress(address: notificationList[index])
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension AddressVC :UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notificationList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(addressCell.self, for: indexPath)
    cell.delegate = self
    cell.configureCell(dat: notificationList[indexPath.row],ind: indexPath.row)
    return cell
  }
}
extension AddressVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return notificationList.count == 0

    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "notification").maskWithColor(color: Color.mainColor!)!
    }

    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform")

        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(M_PI_2), 0.0, 0.0, 1.0))

        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT

        return animation
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = LanguageManager.isArabic ? "لا يوجد عناوين" : "No addresses yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}

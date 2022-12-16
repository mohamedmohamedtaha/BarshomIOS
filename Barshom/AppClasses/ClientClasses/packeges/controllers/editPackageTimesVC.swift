//
//  editPackageTimesVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class editPackageTimesVC: UIViewController {
    @IBOutlet weak var addressBg: UIView!
    @IBOutlet weak var hasAddressBg: UIView!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var durationLb :UILabel!
  @IBOutlet weak var tableView: UITableView!
    var packageData : Package?
    var packageWeeks = [PackageWeek]()
    var address : Address?
  override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
    }
  func handleUI(){
    tableView.register(UINib(nibName: appointmentsHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentsHeaderCell.identifier)
    tableView.register(UINib(nibName: appointmentCell.identifier, bundle: nil), forCellReuseIdentifier: appointmentCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    dateFormatter.locale = Locale(identifier: "en")
    let today = dateFormatter.string(from: date).lowercased()
    
    for i in (0..<(Int(packageData!.package_weeks ?? "0")!))
    {
        var packWeek = PackageWeek(JSON: ["" : ""])!
         packWeek.week = "\(Resources.Common.week) \(i+1)"
        
        var allTimes = packageData!.package_times!
        if i == 0 {
            var dayIndex = -1
            for (index,time) in packageData!.package_times!.enumerated()
            {
                
                if time.day == today {
                    dayIndex = index
                    break
                }
            }
            let times = allTimes
            allTimes = [Package_times]()
            for (ind,tim) in times.enumerated() {
                var newTime = tim
                if ind <= dayIndex {
                    newTime.isAvailable = false
                }
                else
                {
                    newTime.isAvailable = true
                }
                allTimes.append(newTime)
            }
        }
         packWeek.times = allTimes
         packageWeeks.append(packWeek)
    }
    durationLb.text = "\(Resources.Common.duration) \(packageData!.package_period!) \(Resources.Common.days)"
    handleAddress()
    self.tableView.reloadData()
    
  }
    func handleAddress()
    {
        if address != nil {
            self.addressLb.text = address!.address
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
    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitAction(_ sender: UIButton) {
        if address == nil {
            AppHelper.showInfoAlert(message: Resources.Common.chooseDeliveryAddress)
            return
        }
        var pars = [
            "packageId": packageData!.package_id!,
            "address": address!.address,
            "location": "\(address!.lat),\(address!.lng)"
        ]
        var count = 0
        for(index,i) in packageWeeks.enumerated()
        {
            for(j,time) in  i.times.enumerated()
            {
                if time.isDaySelected {
                    pars.updateValue("1", forKey: "times[\(index)][\(time.day!)]")
                    count += 1
                }
                if time.isMidSelected {
                    pars.updateValue("2", forKey: "times[\(index)][\(time.day!)]")
                    count += 1
                }
                if time.isNightSelected {
                    pars.updateValue("3", forKey: "times[\(index)][\(time.day!)]")
                    count += 1
                }
            }
        }
        if count == 0
        {
            AppHelper.showInfoAlert(message: Resources.Common.choosePeriods)
            return
        }
        if count > Int(packageData!.package_delivery_times ?? "0")!
        {
            AppHelper.showInfoAlert(message: Resources.Common.invalidDeliveryTimes)
            return
        }
        let vc = UIStoryboard(name: AppStoryboard.Cart.rawValue, bundle: nil).instantiateViewController(withIdentifier: "paymentTypeActionVC")  as! paymentTypeActionVC
        vc.pars = pars
        vc.totalPrice = Double(packageData!.package_price!) ?? 0
        vc.isPackage =  true
        vc.type = .bank
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    @IBAction func addressAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Location", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationViewController") as! SelectLocationViewController
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
    }
}

extension editPackageTimesVC:UITableViewDataSource,UITableViewDelegate ,appointmentCellDelegate,MapVCDelegate{
    func getCoordinatesBack(lat: String, lng: String) {
        UserService.shared.getPlaceDetails(lat: lat, lng: lng) { (data) in
            if(data.count > 0)
            {
                self.address = Address(JSON: ["" : ""])!
                self.address!.address = data.first!.formatted_address!
                self.address!.lat = "\(data.first!.geometry!.location!.lat!)"
                self.address!.lng = "\(data.first!.geometry!.location!.lng!)"
                self.handleAddress()
                self.tableView.reloadData()
            }
        }
    }
    
    

   
    func dayClicked(index: IndexPath) {
        
        for (ind,i) in packageWeeks[index.section].times.enumerated()
        {
            if ind == index.row-1
            {
                packageWeeks[index.section].times[ind].isDaySelected = !packageWeeks[index.section].times[ind].isDaySelected
                packageWeeks[index.section].times[ind].isNightSelected = false
                packageWeeks[index.section].times[ind].isMidSelected = false

            }
            else
            {
                packageWeeks[index.section].times[ind].isDaySelected = false
                packageWeeks[index.section].times[ind].isNightSelected = false
                packageWeeks[index.section].times[ind].isMidSelected = false


            }
        }
        self.tableView.reloadData()
    }
    func midClicked(index: IndexPath) {
        
        for (ind,i) in packageWeeks[index.section].times.enumerated()
        {
            if ind == index.row-1
            {
                packageWeeks[index.section].times[ind].isDaySelected = false
                packageWeeks[index.section].times[ind].isNightSelected = false
                packageWeeks[index.section].times[ind].isMidSelected = !packageWeeks[index.section].times[ind].isMidSelected

            }
            else
            {
                packageWeeks[index.section].times[ind].isDaySelected = false
                packageWeeks[index.section].times[ind].isNightSelected = false
                packageWeeks[index.section].times[ind].isMidSelected = false


            }
        }
        self.tableView.reloadData()
    }
    func nightClicked(index: IndexPath) {
        
        for (ind,i) in packageWeeks[index.section].times.enumerated()
        {
            if ind == index.row-1
            {
                packageWeeks[index.section].times[ind].isNightSelected = !packageWeeks[index.section].times[ind].isNightSelected
                packageWeeks[index.section].times[ind].isDaySelected = false
                packageWeeks[index.section].times[ind].isMidSelected = false

            }
            else
            {
                packageWeeks[index.section].times[ind].isNightSelected = false
                packageWeeks[index.section].times[ind].isDaySelected = false
                packageWeeks[index.section].times[ind].isMidSelected = false


            }
        }
        
        self.tableView.reloadData()
    }
  func numberOfSections(in tableView: UITableView) -> Int {
    return packageWeeks.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return packageWeeks[section].times.count+1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: appointmentsHeaderCell.identifier, for: indexPath) as! appointmentsHeaderCell
      cell.titleLb.textColor = Color.mainColor
        cell.cellConfigration(packageWeeks[indexPath.section].week!)
      return cell
    }else {
      let cell = tableView.dequeueReusableCell(withIdentifier: appointmentCell.identifier, for: indexPath) as!
        appointmentCell
        cell.currentIndex = indexPath
        cell.showClicks = true
        cell.delegate = self
        cell.cellConfigration(packageData: packageWeeks[indexPath.section].times[indexPath.row-1])
      return cell
    }
  }
}

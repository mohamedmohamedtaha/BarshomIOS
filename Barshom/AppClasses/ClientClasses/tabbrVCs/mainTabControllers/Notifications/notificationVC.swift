//
//  notificationVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit
import DZNEmptyDataSet

class notificationVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var notificationList = [Notifications]()
  override func viewDidLoad() {
        super.viewDidLoad()
    
    tableView.register(UINib(nibName: notificationCell.identifier, bundle: nil), forCellReuseIdentifier: notificationCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNotifications()
    }
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(rootVC!,type:.client)
  }

    func getNotifications()
    {
        UserService.shared.getUserNotifications { (data) in
            self.notificationList = data
            self.tableView.reloadData()
        }
    }
}

extension notificationVC : cellSelectionDelegate
{
    func selected(index: Int) {
        UserService.shared.deleteNotification(notId: notificationList[index].notify_id!) { (data) in
            self.getNotifications()
        }
    }
    
}
extension notificationVC :UITableViewDataSource,UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notificationList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(notificationCell.self, for: indexPath)
    cell.delegate = self
    cell.configureCell(dat: notificationList[indexPath.row],ind: indexPath.row)
    return cell
  }
}
extension notificationVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
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
        let text = LanguageManager.isArabic ? "لا يوجد إشعارات" : "No notifications yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}


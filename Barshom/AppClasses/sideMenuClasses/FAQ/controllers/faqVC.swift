//
//  faqVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 29/03/2021.
//



import UIKit
import DZNEmptyDataSet

class faqVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var notificationList = [FAQ]()
  override func viewDidLoad() {
        super.viewDidLoad()
    self.title = Resources.Common.faq
    tableView.register(UINib(nibName: faqCell.identifier, bundle: nil), forCellReuseIdentifier: faqCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNotifications()
    }
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self,type:.client)
  }

    func getNotifications()
    {
        UserService.shared.getFAQ { (data) in
            self.notificationList = data
            self.tableView.reloadData()
        }
    }
}

extension faqVC : cellSelectionDelegate
{
    func selected(index: Int) {
        self.notificationList[index].isSelected = !self.notificationList[index].isSelected
        self.tableView.beginUpdates()
        self.tableView.reloadData()
        self.tableView.endUpdates()
    }
    
}
extension faqVC :UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return notificationList.count
    }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueCell(faqCell.self, for: indexPath)
    cell.delegate = self
    cell.configureCell(dat: notificationList[indexPath.section],ind: indexPath.section)
    return cell
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if notificationList[indexPath.section].isSelected {
            return UITableView.automaticDimension
        }
        else
        {
            print("\(notificationList[indexPath.section].question_title!.count) --")
            return CGFloat(20 + (notificationList[indexPath.section].question_title!.count < 50 ? 20 : (notificationList[indexPath.section].question_title!.count/40) * 50))
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}
extension faqVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    // ===============================================
    // ==== DZNEmptyDataSet Delegate & Datasource ====
    // ===============================================

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return notificationList.count == 0

    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage()//#imageLiteral(resourceName: "personwhite").maskWithColor(color: Color.mainColor!)!
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
        let text = LanguageManager.isArabic ? "لا يوجد أسئلة" : "No questions yet !"
        let attributes = [NSAttributedString.Key.font: UIFont(name: (LanguageManager.isArabic) ? AppFontName.Arlight:AppFontName.Enlight, size: 18)!,NSAttributedString.Key.foregroundColor:Color.mainColor!]

        return NSAttributedString(string: text, attributes: attributes)
    }
}


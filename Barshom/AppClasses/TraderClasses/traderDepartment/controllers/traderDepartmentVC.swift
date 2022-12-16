//
//  traderDepartmentVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

class traderDepartmentVC: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  var catList = [Category]()
  override func viewDidLoad() {
        super.viewDidLoad()
    handleUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCategories()
    }
  func handleUI(){
    collectionView.register(UINib(nibName: traderDepartmentCell.identifier, bundle: nil), forCellWithReuseIdentifier: traderDepartmentCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
        
  }

    func getCategories()
    {
        UserService.shared.getMarketCategory(userId: UserManager.getUserData!.id!) { (dat) in
            self.catList =  dat

            self.collectionView.reloadData()
        }
    }
    @IBAction func packagesClicked()
    {
        let packages = traderPackagesVC.instantiate(.packages)
        packages.uType = .trader
        
        self.show(packages, sender: nil)
    }
    @IBAction func addCategoryClicked()
    {
        self.performSegue(withIdentifier: "cat", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details"
        {
            let vc = segue.destination as! traderDepartmetsProductsVC
            vc.selectedCat = sender as! Category
        }
    }
}

extension traderDepartmentVC :traderDepartmentDelegate{
    func details(cat: Category) {
        performSegue(withIdentifier: "details", sender: cat)

    }
    
    func delete(cat: Category) {
        AppHelper.showInfoAlert(message: Resources.Common.deleteCatAlert, confirmBtnTitle: Resources.Common.delete) {
            UserService.shared.deleteCategory(complainId: cat.cat_id!) { (data) in
                AppHelper.showSuccessAlertWithoutButtons(vc: self, message:  data["message"] as! String)
                self.getCategories()
            }
        }
        
    }
    
  
  
}

extension traderDepartmentVC:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  private var LineSpac : CGFloat {
    return 4
  }
  
  private var cellWidth :CGFloat {
      return (collectionView.frame.width/2) - LineSpac - 10
  }
  
  private var cellHeight :CGFloat {
    return cellWidth+(cellWidth/6)
    
  }
  
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return catList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: traderDepartmentCell.identifier, for: indexPath) as! traderDepartmentCell
    cell.delegate = self
    cell.cellConfigration(CGSize(width: cellWidth, height: cellHeight),cat: catList[indexPath.row])
    return cell
   
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
   
    return CGSize(width: cellWidth , height: cellHeight)
      
  }
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return  LineSpac
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      
      return 0
  }
  
  
  
}

//
//  MainHomeVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/24/20.
//

import UIKit
import SideMenu
import ImageSlideshow
import Alamofire
import DropDown
var selectedCity : City?

class MainHomeVC: UIViewController {

  @IBOutlet weak var quickOrderBg: UIView!
    @IBOutlet weak var storesBg: UIView!
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var sliderShow: ImageSlideshow!
    @IBOutlet weak var sliderIndicator: UIPageControl!
    var dropDown = DropDown()
    var allCities = [City]()
  var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  var sliderList = [SlideShow]()
  override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      handleUI()
    rootVC = self
    }
  
  func handleUI(){
    quickOrderBg.dropShadow(roundCorner:20)
    storesBg.dropShadow(roundCorner:20)
    handleCity()
    UserService.shared.getSlideShow { [self] (data) in
        sliderList = data
        sliderShow.setImageInputs(sliderList.map({ (slide) -> SDWebImageSource in
            return SDWebImageSource(urlString: slide.image_url!)!
        }))
        sliderShow.roundCorners(.allCorners, radius: 10)
        sliderShow.contentScaleMode = .scaleToFill
        sliderShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)
        sliderShow.pageIndicator = sliderIndicator
        sliderShow.slideshowInterval = 3
        sliderIndicator.numberOfPages = sliderList.count
        sliderIndicator.isHidden = sliderList.count == 0
    }
  }
   
  func handleCity()
  {
    if UserManager.getUserCity != nil
    {
        selectedCity = UserManager.getUserCity!
        cityBtn.setTitle(LanguageManager.isArabic ? selectedCity?.city_name! : selectedCity?.city_name!, for: .normal)
        cityBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    else
    {
        cityBtn.setTitle(Resources.Login.choosecity, for: .normal)
        cityBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

    }
  }
 
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(rootVC!, type: .client)
  }
    
    @IBAction func cityAction(_ sender: UIButton) {
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
            UserManager.saveUserCity(user: selectedCity!.toJSON())
            handleCity()
        }
        self.dropDown.show()
    }
  @IBAction func barshomStoreAction(_ sender: UIButton) {
    if selectedCity == nil
    {
        AppHelper.showErrorAlert(message: Resources.Login.choosecity)
        return
    }
      
    isFastOrder = false
    performSegue(withIdentifier: "stores", sender: nil)
  }
  
 
  @IBAction func storesAction(_ sender: UIButton) {
    if selectedCity == nil
    {
        AppHelper.showErrorAlert(message: Resources.Login.choosecity)
        return
    }
    isFastOrder = false
    let vc = storesVC.instantiate(.Stores)
    self.navigationController?.show(vc, sender: nil)
  }
  
  @IBAction func quickOrderAction(_ sender: UIButton) {
    sheetPresenter.opensheetVC(self, storeyBoard: .QuickOrder, screenHeight: 3.5)

  }
  
  
}

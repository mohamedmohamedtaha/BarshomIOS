//
//  appointmentCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

protocol appointmentCellDelegate {
    func dayClicked(index:IndexPath)
    func midClicked(index:IndexPath)
    func nightClicked(index:IndexPath)
}
class appointmentCell: UITableViewCell {
    @IBOutlet weak var dayLb: UILabel!
    @IBOutlet weak var amLb: UILabel!
    @IBOutlet weak var pmLb: UILabel!
    @IBOutlet weak var amFromLb: UILabel!
    @IBOutlet weak var amToLb: UILabel!
    @IBOutlet weak var pmFromLb: UILabel!
    @IBOutlet weak var pmToLb: UILabel!
    @IBOutlet weak var midLb: UILabel!
    @IBOutlet weak var midFromLb: UILabel!
    @IBOutlet weak var midToLb: UILabel!
    @IBOutlet weak var disableView: UIView!
    var delegate: appointmentCellDelegate?
    var currentIndex:IndexPath?
    var showClicks = false
    var packageDat: Package_times?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func cellConfigration(packageData:Package_times){
        
        packageDat = packageData
        dayLb.text = packageData.getDayFormatted()
        amFromLb.text = packageData.morning_from!
        amToLb.text = packageData.morning_to!
        
        amLb.isHidden = packageData.morning_from! == ""

        if(packageData.mid_from! == "")
        {
            midFromLb.text = ""
            midToLb.text = ""
            midLb.isHidden = true
        }
        else
        {
            midFromLb.text = packageData.mid_from!
            midToLb.text =  packageData.mid_to!
            midLb.isHidden = false
        }
        if(packageData.night_from! == "")
        {
            pmFromLb.text = ""
            pmToLb.text = ""
            pmLb.isHidden = true
        }
        else
        {
            pmFromLb.text = packageData.night_from!
            pmToLb.text =  packageData.night_to!
            pmLb.isHidden = false
        }
        
        
        if showClicks {
            amLb.text = packageData.isDaySelected ? "◉" : "◎"
            midLb.text = packageData.isMidSelected ? "◉" : "◎"
            pmLb.text = packageData.isNightSelected ? "◉" : "◎"

        }
        else
        {
            amLb.text = "✔︎"
            midLb.text = "✔︎"
            pmLb.text = "✔︎"
        }
        disableView.isHidden = packageData.isAvailable
    
  }
    func cellConfigration(dayModel:DayModel,packageData:Package_times){
        packageDat = packageData
        dayLb.text = dayModel.getDayFormatted()
        if dayModel.morning == "1" {
            if shiftsList.count > 0 {
                amFromLb.text = shiftsList[2].shift_from!
                amToLb.text = shiftsList[2].shift_to!
            }
        }
        else
        {
            amFromLb.text = ""
            amToLb.text = ""
        }
        amLb.isHidden = dayModel.morning != "1"
        
        if dayModel.mid == "1" {
            if shiftsList.count > 0 {
                midFromLb.text = shiftsList[1].shift_from!
                midToLb.text = shiftsList[1].shift_to!
            }
        }
        else
        {
            midFromLb.text = ""
            midToLb.text = ""
        }
        midLb.isHidden = dayModel.mid != "1"
        
        if dayModel.night == "1" {
            if shiftsList.count > 0 {
                pmFromLb.text = shiftsList[0].shift_from!
                pmToLb.text = shiftsList[0].shift_to!
            }
        }
        else
        {
            pmFromLb.text = ""
            pmToLb.text = ""
        }
        pmLb.isHidden = dayModel.night != "1"

    
        if showClicks {
            amLb.text = packageData.isDaySelected ? "◉" : "◎"
            midLb.text = packageData.isMidSelected ? "◉" : "◎"
            pmLb.text = packageData.isNightSelected ? "◉" : "◎"

        }
        else
        {
            amLb.text = "✔︎"
            midLb.text = "✔︎"
            pmLb.text = "✔︎"
        }
    
  }
    @IBAction func dayClicked()
    {
        if showClicks {
            if packageDat!.isAvailable {
                delegate?.dayClicked(index: currentIndex!)
            }
        }
    }
    @IBAction func midClicked()
    {
        if showClicks {
            if packageDat!.isAvailable {
                delegate?.midClicked(index: currentIndex!)
            }
        }
    }
    @IBAction func nightClicked()
    {
        if showClicks {
            if packageDat!.isAvailable {
                delegate?.nightClicked(index: currentIndex!)
            }
        }
    }
}

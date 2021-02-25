//
//  photoCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/4/21.
//

import UIKit

protocol photosDelegate {
    func remove(_ index:Int)
}

class photoCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    var delegate:photosDelegate?
    var cellIndex = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellConfigration(_ Index:Int){
        cellIndex = Index
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        delegate?.remove(cellIndex)
    }
}

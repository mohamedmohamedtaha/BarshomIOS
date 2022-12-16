//
//  worker.swift
//  Barshom
//
//  Created by Wessam AlKhaldy on 12/12/2022.
//

import Foundation
import ObjectMapper

struct Worker : Mappable {
    
    var adv_account_name : Int?
    var adv_account_number : Int?
    var adv_activation_code : String?
    var adv_bank_name : String?
    var adv_address : Int?
    var adv_id : Int?
    var adv_cat_id : Int?
    var adv_author_id : Int?
    var adv_email : String?
    var adv_identification : Int?
    var adv_ipan_number : Int?
    var adv_status : String?
    var adv_name : String?
    var adv_id_string : String?

    init(adv_id:Int,adv_name:String,adv_email:String){
        self.adv_id = adv_id
        self.adv_name = adv_name
        self.adv_email = adv_email

    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        adv_id <- map["adv_id"]
        adv_account_name <- map["adv_account_name"]
        adv_account_number <- map["adv_account_number"]
        adv_activation_code <- map["adv_activation_code"]
        adv_bank_name <- map["adv_bank_name"]
        adv_address <- map["adv_address"]
        adv_cat_id <- map["adv_cat_id"]
        adv_author_id <- map["adv_author_id"]
        adv_email <- map["adv_email"]
        adv_identification <- map["adv_identification"]
        adv_ipan_number <- map["adv_ipan_number"]
        adv_status <- map["adv_status"]
        adv_name <- map["adv_name"]
        
    

    }
    
}

//
//  Ticket.swift
//  Barshom
//
//  Created by Ahmed Yehia on 28/03/2021.
//

import Foundation
import ObjectMapper

struct Ticket : Mappable {
    var cons_id : String?
    var cons_user_id : String?
    var cons_status : String?
    var cons_description : String?
    var cons_title : String?
    var cons_bell_number : String?
    var cons_created_at : String?
    var status_translated : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        cons_id <- map["cons_id"]
        cons_user_id <- map["cons_user_id"]
        cons_status <- map["cons_status"]
        cons_description <- map["cons_description"]
        cons_title <- map["cons_title"]
        cons_bell_number <- map["cons_bell_number"]
        cons_created_at <- map["cons_created_at"]
        status_translated <- map["status_translated"]
    }

}

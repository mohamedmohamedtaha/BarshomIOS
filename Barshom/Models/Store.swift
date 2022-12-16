//
//  Store.swift
//  Barshom
//
//  Created by Ahmed Yehia on 29/03/2021.
//

import Foundation
import ObjectMapper

struct Store : Mappable {
    var adv_id : String?
    var adv_name : String?
    var adv_delivery_time : String?
    var adv_map_location : String?
    var adv_thumb_id : String?
    var market_user_distance : String?
    var adv_order : String?
    var licenseImage : String?
    var commercialRecordImage : String?
    var formImage : String?
    var adv_car_plate_number : String?
    var imageUrl : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        adv_id <- map["adv_id"]
        adv_name <- map["adv_name"]
        adv_delivery_time <- map["adv_delivery_time"]
        adv_map_location <- map["adv_map_location"]
        adv_thumb_id <- map["adv_thumb_id"]
        market_user_distance <- map["market_user_distance"]
        adv_order <- map["adv_order"]
        licenseImage <- map["licenseImage"]
        commercialRecordImage <- map["commercialRecordImage"]
        formImage <- map["formImage"]
        adv_car_plate_number <- map["adv_car_plate_number"]
        imageUrl <- map["imageUrl"]
    }

    func getTimeFormatted()->Int
    {
        switch adv_delivery_time {
        case "half_hour":
            return 30
        case "hour":
            return 60
        case "two_hour":
            return 120
        default:
            return 0
        }
    }
}

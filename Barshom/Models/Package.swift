//
//  Package.swift
//  Barshom
//
//  Created by Ahmed Yehia on 29/03/2021.
//

import Foundation
import ObjectMapper

struct Package : Mappable {
    var package_id : String?
    var package_name : String?
    var package_price : String?
    var package_delivery_price : String?
    var package_period : String?
    var package_delivery_times : String?
    var package_products : [Package_products]?
    var package_times : [Package_times]?
    var package_weeks : String?
    var package_products_count : String?
    var is_subscribed : String?
    var orders : [Orders]?
    var subscription_id : String?
    var package_delivery_times_left : String?
    var times : [Times]?
    var imageUrl = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        package_id <- map["package_id"]
        package_name <- map["package_name"]
        package_price <- map["package_price"]
        package_delivery_price <- map["package_delivery_price"]
        package_period <- map["package_period"]
        package_delivery_times <- map["package_delivery_times"]
        package_products <- map["package_products"]
        package_times <- map["package_times"]
        package_weeks <- map["package_weeks"]
        package_products_count <- map["package_products_count"]
        is_subscribed <- map["is_subscribed"]
        orders <- map["orders"]
        subscription_id <- map["subscription_id"]
        package_delivery_times_left <- map["package_delivery_times_left"]
        times <- map["times"]
        imageUrl <- map["imageUrl"]
    }
    func isSubscribed()->Bool
    {
        return is_subscribed == "1"
    }

}
struct TraderPackage : Mappable {
    var package_id : String?
    var package_name : String?
    var package_price : String?
    var package_period : String?
    var package_expire_at : String?
    var user_package_expire_at : String?
    var imageUrl = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        package_id <- map["package_id"]
        package_name <- map["package_name"]
        package_price <- map["package_price"]
        package_period <- map["package_period"]
        package_expire_at <- map["package_expire_at"]
        user_package_expire_at <- map["user_package_expire_date"]

        imageUrl <- map["imageUrl"]
    }
    func isSubscribed()->Bool
    {
        return user_package_expire_at != nil &&  user_package_expire_at != ""
    }

}
struct Orders : Mappable {
    var week_name : String?
    var orders : [Order]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        week_name <- map["week_name"]
        orders <- map["orders"]
    }

}
struct Times : Mappable {
    var day : String?
    var times : [String:Any]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        day <- map["day"]
        times <- map["times"]
    }
    func getWeeksList() -> [DayModel] {
        var models = [DayModel]()
        if let tim = times  as? [String:Any]
        {
            for (key,value) in tim {
                print("\(key) = \(value)")

                if let shift = value as? String
                {
                    var dayModel = DayModel(JSON: ["":""])!
                    dayModel.day = key
                    switch shift {
                    case "1":
                        dayModel.morning = "1"
                        break
                    case "2":
                        dayModel.mid = "1"
                        break
                    case "3":
                        dayModel.night = "1"
                        break
                    default:
                        break
                    }
                    models.append(dayModel)
                }
            }
        }
        return models
    }

}
struct Package_products : Mappable {
    var product_id : String?
    var product_quantity : String?
    var product_quantity_types : String?
    var imageUrl : String?
    var product_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        product_id <- map["product_id"]
        product_quantity <- map["product_quantity"]
        product_quantity_types <- map["product_quantity_types"]
        imageUrl <- map["imageUrl"]
        product_name <- map["product_name"]
    }

}
struct Package_times : Mappable {
    var day : String?
    var morning_from : String?
    var morning_to : String?
    var mid_from : String?
    var mid_to : String?
    var night_from : String?
    var night_to : String?
    var isDaySelected = false
    var isMidSelected = false
    var isNightSelected = false
    var isAvailable = true
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        day <- map["day"]
        morning_from <- map["morning_from"]
        morning_to <- map["morning_to"]
        mid_from <- map["mid_from"]
        mid_to <- map["mid_to"]
        night_from <- map["night_from"]
        night_to <- map["night_to"]
    }
    func getDayFormatted()->String
    {
        switch day {
        case "saturday":
            return Resources.Common.saturday
        case "sunday":
            return Resources.Common.sunday
        case "monday":
            return Resources.Common.monday
        case "tuesday":
            return Resources.Common.tuesday
        case "wednesday":
            return Resources.Common.wednesday
        case "thursday":
            return Resources.Common.thursday
        case "friday":
            return Resources.Common.friday
        default:
            return Resources.Common.saturday

        }
    }

}
struct PackageWeek : Mappable {
    var week : String?
    var times = [Package_times]()
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        week <- map["week"]
        times <- map["times"]
        
    }
   
}
struct DayModel : Mappable {
    var day : String?
    var morning : String?
    var mid : String?
    var night : String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        day <- map["day"]
        morning <- map["morning"]
        mid <- map["mid"]
        night <- map["night"]
        
    }
    func getDayFormatted()->String
    {
        switch day {
        case "saturday":
            return Resources.Common.saturday
        case "sunday":
            return Resources.Common.sunday
        case "monday":
            return Resources.Common.monday
        case "tuesday":
            return Resources.Common.tuesday
        case "wednesday":
            return Resources.Common.wednesday
        case "thursday":
            return Resources.Common.thursday
        case "friday":
            return Resources.Common.friday
        default:
            return Resources.Common.saturday

        }
    }

}

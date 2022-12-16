//
//  Bills.swift
//  ArtFood-Trader
//
//  Created by Ahmed Yehia on 25/02/2021.
//


import Foundation
import ObjectMapper

struct WithdrawBalance : Mappable {
    var request_id : String?
    var request_user_id : String?
    var request_status : String?
    var request_amount : String?
    var request_created_at : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        request_id <- map["request_id"]
        request_user_id <- map["request_user_id"]
        request_status <- map["request_status"]
        request_amount <- map["request_amount"]
        request_created_at <- map["request_created_at"]
    }

}
struct Shifts : Mappable {
    var shift_id : String?
    var shift_name : String?
    var shift_from : String?
    var shift_to : String?
    var shift_to_period : String?
    var isSelected =  false
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        shift_id <- map["shift_id"]
        shift_name <- map["shift_name"]
        shift_from <- map["shift_from"]
        shift_to <- map["shift_to"]
        shift_to_period <- map["shift_to_period"]
    }

}
struct AddressModel : Mappable {
    var address_id : String?
    var address_text : String?
    var address_name : String?
    var lat : String?
    var lng : String?
    var address_location : String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        address_id <- map["address_id"]
        address_text <- map["address_text"]
        address_name <- map["address_name"]
        lat <- map["lat"]
        lng <- map["lng"]
        address_location <- map["address_location"]
    }

}
struct Bills : Mappable {
    var id : String?
    var operation_number : String?
    var operation_date : String?
    var price : String?
    var user_id : String?
    var date : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        operation_number <- map["operation_number"]
        operation_date <- map["operation_date"]
        price <- map["price"]
        user_id <- map["user_id"]
        date <- map["date"]
    }

}
struct Address : Mappable {
    var id : String = ""
    var address : String = ""
    var name : String = ""
    var lat : String = ""
    var lng : String  = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        address <- map["address"]
        name <- map["name"]
        lat <- map["lat"]
        lng <- map["lng"]
    }

}
struct Place : Mappable {
    var formatted_address : String?
    var geometry : Geometry?
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        formatted_address <- map["formatted_address"]
        geometry <- map["geometry"]
       
    }

}
struct Geometry : Mappable {
    var location : Location?
    var location_type : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        location <- map["location"]
        location_type <- map["location_type"]
    }

}
struct Location : Mappable {
    var lat : Double?
    var lng : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        lat <- map["lat"]
        lng <- map["lng"]
    }

}

struct Coupon : Mappable {
    var coupon_id : String?
    var coupon_code : String?
    var coupon_type : String?
    var coupon_times : String?
    var coupon_expire_at : String?
    var coupon_discount : String?
    var coupon_discount_type : String?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        coupon_id <- map["coupon_id"]
        coupon_code <- map["coupon_code"]
        coupon_type <- map["coupon_type"]
        coupon_times <- map["coupon_times"]
        coupon_expire_at <- map["coupon_expire_at"]
        coupon_discount <- map["coupon_discount"]
        coupon_discount_type <- map["coupon_discount_type"]
    }

}

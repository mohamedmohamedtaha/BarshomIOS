//
//  Notifications.swift
//  Barshom
//
//  Created by Ahmed Yehia on 28/03/2021.
//

import Foundation
import ObjectMapper

struct Notifications : Mappable {
    var notify_id : String?
    var notify_advertiser_id : String?
    var notify_type : String?
    var notify_msg_id : String?
    var notify_text : String?
    var notify_url : String?
    var notify_order_id : String?
    var notify_sender_chat_id : String?
    var notify_read : String?
    var notify_pushed_firebase : String?
    var notify_created_at : String?
    var notify_updated_at : String?
    var created_since : String?
    var complaint_id : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        notify_id <- map["notify_id"]
        notify_advertiser_id <- map["notify_advertiser_id"]
        notify_type <- map["notify_type"]
        notify_msg_id <- map["notify_msg_id"]
        notify_text <- map["notify_text"]
        notify_url <- map["notify_url"]
        notify_order_id <- map["notify_order_id"]
        notify_sender_chat_id <- map["notify_sender_chat_id"]
        notify_read <- map["notify_read"]
        notify_pushed_firebase <- map["notify_pushed_firebase"]
        notify_created_at <- map["notify_created_at"]
        notify_updated_at <- map["notify_updated_at"]
        created_since <- map["created_since"]
        complaint_id <- map["complaint_id"]
    }

}
struct appSettings : Mappable {
    var allow_whatsapp : String?
    var app_cancel_minutes : String?
    var app_face : String?
    var site_whatsapp : String?
    var app_twitter : String?
    var app_linkedin : String?
    var app_ins : String?
    var app_gplus : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        allow_whatsapp <- map["allow_whatsapp"]
        app_cancel_minutes <- map["app_cancel_minutes"]
        app_face <- map["app_face"]
        site_whatsapp <- map["site_whatsapp"]
        app_twitter <- map["app_twitter"]
        app_linkedin <- map["app_linkedin"]
        app_ins <- map["app_ins"]
        app_gplus <- map["app_gplus"]
    }

    func isAllowWhatsapp()->  Bool
    {
        return (allow_whatsapp ?? "0") == "1"
    }
}

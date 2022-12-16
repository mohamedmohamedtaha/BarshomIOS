//
//  Filter.swift
//  3aqary
//
//  Created by apple on 6/17/19.
//  Copyright © 2019 mohamed elatabany. All rights reserved.
//

import Foundation

struct Filter {
    
    static func generataKeys() -> [Int: String] {
        return [
            1: "rooms",
            2: "halls",
            3: "buildingAge"
        ]
    }
    
    
    static func generateOrdering(tag: Int) -> [String: String] {
        if tag == 4 {
            return [
                "order_key": "serv_price"
            ]
        } else if tag == 5 {
            return [
                "order_key": "serv_area"
            ]
        }
        return [:]
    }
    
    
    static func generateAscOrDesc(tag: Int) -> [String: String] {
        if tag == 1 {
            return  ["order_value": "ASC"]
        } else if tag == 2 {
            return  ["order_value": "DESC"]
        }
        return [:]
    }
    
    
}


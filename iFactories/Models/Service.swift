//
//  Service.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON
class Service {
    var name = ""
    var description = ""
    var date = ""
    var id = -1
    var order_id = -1
    var state = false

    static func parseService(obj: JSON) -> Service {
        let ser = Service()
        ser.id = obj["id"].intValue
        
        ser.date = obj["date"].stringValue
        ser.description = obj["comment"].stringValue
        return ser
        
        
        /*
         if (qu.has("id")) {
         cp.setOrder_id(qu.getInt("id"));
         }
         if (qu.has("comment")) {
         cp.setDescription(qu.getString("comment"));
         }
         if (qu.has("date")) {
         cp.setDate(qu.getString("date"));
         }
         

 */
    }
}

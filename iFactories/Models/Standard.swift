//
//  Standard.swift
//  iFactories
//
//  Created by navid einackchi on 7/21/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON

class GDIM {
    var name: String = ""
    var description: String = ""
    var id: Int = -1
    var type: Int = -1
    var selected: Bool = false
    
    
    static func parseGDIM(obj: JSON) -> GDIM {
        let cat = GDIM()
        cat.id = obj["id"].intValue
        cat.name = obj["title"].stringValue
//        cat.description = obj["description"].stringValue
        
        let typeID = obj["type"].stringValue
        if (typeID == "d")
        {
            cat.type = Settings.OthersType.DWay
        } else if (typeID == "g")
        {
            cat.type = Settings.OthersType.Geo
        }else if (typeID == "i")
        {
            cat.type = Settings.OthersType.Standards
        }else if (typeID == "m")
        {
            cat.type = Settings.OthersType.Currency
        }
        
        
        return cat
    }
    
    
    
}

/*
 String , ;
 int id, ;
 boolean  = false;
 
 
 public static Standard parseSatndards(JSONObject qu) {
 Standard cp = new Standard();
 try {
 if (qu.has("id")) {
 cp.setId(qu.getInt("id"));
 }
 if (qu.has("title")) {
 cp.setName(qu.getString("title"));
 }
 //            if (qu.has("description")) {
 //                cp.setdescription(qu.getInt("description"));
 //            }
 if (qu.has("type")) {
 String temp = qu.getString("type");
 if (temp.equals("d")) {
 cp.setType(Settings.OthersType.DWay);
 } else if (temp.equals("g")) {
 cp.setType(Settings.OthersType.Geo);
 } else if (temp.equals("i")) {
 cp.setType(Settings.OthersType.Standards);
 } else if (temp.equals("m")) {
 cp.setType(Settings.OthersType.Payments);
 }
 
 }
 } catch (Exception err) {
 
 }
 return cp;
 }
 

 */

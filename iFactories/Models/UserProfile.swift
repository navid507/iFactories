//
//  UserProfile.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserProfile {
    
    var personalId: String = ""
    var username: String = ""
    var password: String = ""
    var smscode: String = ""
    var device_id: String = ""
    var u_fname: String = ""
    var u_company: String = ""
    var u_country: String = ""
    var u_gender: String = ""
    var ubirthdate: String = ""
    var u_indate: String = ""
    var ncode: String = ""
    var phone: String = ""
    var mobile: String = ""
    var cart_code: String = ""
    var position: String = ""
    var email: String = ""
    
    static func ParseProfile(res: JSON)-> UserProfile
    {
        let pr = UserProfile()
        
        if (res == nil)
        {
            return pr
        }
       let pInfo = res["personalinfo"]
        
        pr.u_fname = pInfo["u_fname"].stringValue
        pr.username = pInfo["username"].stringValue
        pr.password = pInfo["password"].stringValue
        pr.smscode = pInfo["smscode"].stringValue
        pr.device_id = pInfo["device_id"].stringValue
        pr.u_fname = pInfo["u_fname"].stringValue
        pr.u_company = pInfo["u_company"].stringValue
        pr.u_country = pInfo["u_country"].stringValue
        pr.u_gender = pInfo["u_gender"].stringValue
        pr.ubirthdate = pInfo["ubirthdate"].stringValue
        pr.u_indate = pInfo["u_indate"].stringValue
        pr.ncode = pInfo["ncode"].stringValue
        pr.phone = pInfo["phone"].stringValue
        pr.mobile = pInfo["mobile"].stringValue
        pr.cart_code = pInfo["cart_code"].stringValue
        pr.position = pInfo["position"].stringValue
        pr.email = pInfo["email"].stringValue
        
        return pr
        
    }
}



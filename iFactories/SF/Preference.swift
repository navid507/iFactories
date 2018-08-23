//
//  UserPref.swift
//  app1
//
//  Created by safar-ios on 12/22/1395 AP.
//  Copyright © 1395 safar-ios. All rights reserved.
//

import Foundation
class Preference  {
    
    
    
    public static let _userDefualts = "preference"
    
    
    public static let defaults = UserDefaults(suiteName: Preference._userDefualts)!;
    
    
    
    public static let RegState = "prg_state"
    public static let Userphone = "user_phone"
    public static let UserCode = "user_code"
    public static let DeviceID = "device_id"
    public static let UserID = "user_id"
    public static let Private = "user_private"
    public static let FirstName = "sign_firstname"
    public static let LastName = "sign_lastname"
    public static let Address = "sign_address"
    public static let Tel = "sign_tel"
    public static let Order_id = "oreder_id"
    public static let Language = "lang"
    
    
    
   
    static func setRegState(_ RegState :Int)
    {
        defaults.set(RegState, forKey: Preference.RegState)
        defaults.synchronize()
        
    }
    
    static func getRegState()-> Int
    {
        return defaults.integer(forKey: Preference.RegState)
    }
 
    static func setUserphone(_ Userphone :String)
    {
        defaults.set(Userphone, forKey: Preference.Userphone)
        defaults.synchronize()
        
    }
    
    static func getUserphone()-> String
    {
        return defaults.string(forKey: Preference.Userphone) ?? ""
        
    }
    
    
    static func setUserCode(_ UserCode :String)
    {
        defaults.set(UserCode, forKey: Preference.UserCode)
        defaults.synchronize()
        
    }
    
    static func getUserCode()-> String
    {
        return defaults.string(forKey: Preference.UserCode) ?? ""
        
    }
    
    
//    static func setDeviceID(_ DeviceID :Int)
//    {
//        defaults.set(DeviceID, forKey: Preference.DeviceID)
//        defaults.synchronize()
//
//    }
//
//    static func getDeviceID()-> Int
//    {
//        return defaults.integer(forKey: Preference.DeviceID)
//
//    }
//
//
    static func setUserID(_ UserID :Int)
    {
        defaults.set(UserID, forKey: Preference.UserID)
        defaults.synchronize()

    }

    static func getUserID()-> Int
    {
        return defaults.integer(forKey: Preference.UserID)

    }
//
//    static func setPrivate(_ Private :Int)
//    {
//        defaults.set(Private, forKey: Preference.Private)
//        defaults.synchronize()
//
//    }
//
//    static func getPrivate()-> Int
//    {
//        return defaults.integer(forKey: Preference.Private)
//
//    }
//
    
//    static func setFirstName(_ FirstName :String)
//    {
//        defaults.set(FirstName, forKey: Preference.FirstName)
//        defaults.synchronize()
//
//    }
//
//    static func getFirstName()-> String
//    {
//        return defaults.integer(forKey: Preference.FirstName)
//
//    }
//
//
//    static func setLastName(_ LastName :String)
//    {
//        defaults.set(LastName, forKey: Preference.LastName)
//        defaults.synchronize()
//
//    }
//
//    static func getLastName()-> String
//    {
//        return defaults.integer(forKey: Preference.LastName)
//
//    }
    
    
//    static func setAddress(_ Address :String)
//    {
//        defaults.set(Address, forKey: Preference.Address)
//        defaults.synchronize()
//
//    }
//
//    static func getAddress()-> String
//    {
//        return defaults.integer(forKey: Preference.Address)
//
//    }
//
//
//    static func setTel(_ Tel :String)
//    {
//        defaults.set(Tel, forKey: Preference.Tel)
//        defaults.synchronize()
//
//    }
//
//    static func getTel()-> String
//    {
//        return defaults.integer(forKey: Preference.Tel)
//
//    }
//
//    static func setOrder_id(_ Order_id :Int)
//    {
//        defaults.set(Order_id, forKey: Preference.Order_id)
//        defaults.synchronize()
//
//    }
//
//    static func getOrder_id()-> Int
//    {
//        return defaults.integer(forKey: Preference.Order_id)
//
//    }
    static func setLanguage(_ Language :String)
    {
        defaults.set(Language, forKey: Preference.Language)
        defaults.synchronize()
        
    }
    
    static func getLanguage()-> String
    {
        return defaults.string(forKey: Preference.Language) ?? ""
        
    }
    
    
    
}


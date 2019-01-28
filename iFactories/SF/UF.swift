//
//  UF.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import Localize_Swift
class UF {
    
    static func changeAllFonts(parent: UIView,lang: Int )
    {
        for view in parent.subviews as [UIView] {
            if let btn = view as? UIButton {
                btn.setTitle(btn.title(for: .normal)?.localized(), for: .normal)
                
                btn.titleLabel?.font = getFont(tag: btn.tag, lang: lang)

            } else if let tf = view as? UITextField {
                tf.font = getFont(tag: tf.tag, lang: lang)
   
//                tf.text = tf.text?.localized()
                
            }else if let tf = view as? UILabel {
                tf.font = getFont(tag: tf.tag, lang: lang)
                tf.text = tf.text?.localized()
                
                
            }else if let tf = view as? UITextView {
                tf.font = getFont(tag: tf.tag, lang: lang)
                tf.text = tf.text?.localized()
                
                
            }else if let sv = view as? UIScrollView {
                UF.changeAllFonts(parent: sv, lang: lang)
            }else if let v = view as? UIView {
                UF.changeAllFonts(parent: v, lang: lang)
            }
        }
    }
  
    static func getFont(tag: Int, lang: Int)-> UIFont
    {
        let fonts = UIFont.familyNames
        let rfonts = UIFont.fontNames(forFamilyName: "Vazir")
        
        var size: CGFloat = CGFloat(tag)
        if tag > 100
        {
            size = CGFloat(tag - 100)
            
        }
        var font: UIFont = UIFont(name: "Vazir-Bold", size: 16)!
        if (tag < 100)
        {
            
        switch lang{
        case Settings.Language.Persian:
            font = UIFont(name: "Vazir-Medium", size: size)!
            
            break
        case Settings.Language.English:
            font = UIFont.systemFont(ofSize: size-2)
            break
        case Settings.Language.Arabic:
            font = UIFont.systemFont(ofSize: size)
            break
        case Settings.Language.Russion:
            font = UIFont.systemFont(ofSize: size-2)
            break
            
        default:
            break
        }
        }else{
            switch lang{
            case Settings.Language.Persian:
                font = UIFont(name: "Vazir-Bold", size: size)!
                break
            case Settings.Language.English:
                font = UIFont.boldSystemFont(ofSize: size-2)
                break
            case Settings.Language.Arabic:
                font = UIFont.boldSystemFont(ofSize: size)
                break
            case Settings.Language.Russion:
                font = UIFont.boldSystemFont(ofSize: size-2)
                break
                
            default:
                break
            }
        }
        return font
    }
    //    static func getLang() -> String
    //    {
    //        let def = UserDefaults.standard
    //        let lang = def.string(forKey: "lang")!
    //        return lang
    //    }
    //
    //    static func setLang(lang: String)
    //    {
    //        let def = UserDefaults.standard
    //        def.set(lang, forKey: "lang")
    //        def.synchronize()
    //    }
    //
    static func doEnglish()
    {
        UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        Preference.setLanguage("en")
        //        setLang(lang: "en")
        MainInfo.language = Settings.Language.English
        MainInfo.IsRTL = false
        
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        Localize.setCurrentLanguage("en")
        
    }
    static func doPersian()
    {
        
        UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        UserDefaults.standard.set(["fa"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        Preference.setLanguage("fa")
        //        setLang(lang: "fa")
        MainInfo.language = Settings.Language.Persian
        MainInfo.IsRTL = true
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        Localize.setCurrentLanguage("fa")
        
    }
    
    static func doRussion()
    {
        UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        UserDefaults.standard.set(["ru"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        Preference.setLanguage("ru")
        //   setLang(lang: "ru")
        MainInfo.language = Settings.Language.Russion
        MainInfo.IsRTL = false
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        Localize.setCurrentLanguage("ru")
    }
    static func doArabic()
    {
        
        UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        Preference.setLanguage("ar")
        //   setLang(lang: "ar")
        MainInfo.language = Settings.Language.Arabic
        MainInfo.IsRTL = true
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        Localize.setCurrentLanguage("ar")
        
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    static func isValidPhone(phone: String) -> Bool {
        
        let PHONE_REGEX = "^09[0-9'@s]{9,9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phone)
        return result
        
    }
    
   static func populateServices()
    {
        
        
        
        MainInfo.services.removeAllObjects()
        let MEETING = Service()
        MEETING.name = Settings.ServicesString.MEETING.localized()
        MEETING.id = Settings.ServicesID.MEETING
        MainInfo.services.add(MEETING)
        
        let NAMAYNDE = Service()
        NAMAYNDE.name = Settings.ServicesString.NAMAYNDE.localized()
        NAMAYNDE.id = Settings.ServicesID.NAMAYNDE
        MainInfo.services.add(NAMAYNDE)
        
        let MOMAYEZ = Service()
        MOMAYEZ.name = Settings.ServicesString.MOMAYEZ.localized()
        MOMAYEZ.id = Settings.ServicesID.MOMAYEZ
        MainInfo.services.add(MOMAYEZ)
        
        let MOSHAVERE = Service()
        MOSHAVERE.name = Settings.ServicesString.MOSHAVERE.localized()
        MOSHAVERE.id = Settings.ServicesID.MOSHAVERE
        MainInfo.services.add(MOSHAVERE)
        
        let BAZDID_GROUP = Service()
        BAZDID_GROUP.name = Settings.ServicesString.BAZDID_GROUP.localized()
        BAZDID_GROUP.id = Settings.ServicesID.BAZDID_GROUP
        MainInfo.services.add(BAZDID_GROUP)
        
        let SADERAT = Service()
        SADERAT.name = Settings.ServicesString.SADERAT.localized()
        SADERAT.id = Settings.ServicesID.SADERAT
        MainInfo.services.add(SADERAT)
        
        let SARMAYEGOZARY = Service()
        SARMAYEGOZARY.name = Settings.ServicesString.SARMAYEGOZARY.localized()
        SARMAYEGOZARY.id = Settings.ServicesID.SARMAYEGOZARY
        MainInfo.services.add(SARMAYEGOZARY)
        
        let HOZOOR = Service()
        HOZOOR.name = Settings.ServicesString.HOZOOR.localized()
        HOZOOR.id = Settings.ServicesID.HOZOOR
        MainInfo.services.add(HOZOOR)
        
        let TOOR = Service()
        TOOR.name = Settings.ServicesString.TOOR.localized()
        TOOR.id = Settings.ServicesID.TOOR
        MainInfo.services.add(TOOR)
        
    }
}

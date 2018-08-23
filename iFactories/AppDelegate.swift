//
//  AppDelegate.swift
//  iFactories
//
//  Created by navid einackchi on 6/2/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Localize_Swift

public extension UIView {
    
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        
        // You can change these values, so that you won't have to write a long function
        let defaultRepeatCount = 4
        let defaultTotalDuration = 0.5
        let defaultTranslation = -5
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = count ?? Float(defaultRepeatCount)
        animation.duration = (duration ?? defaultTotalDuration)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? defaultTranslation
        layer.add(animation, forKey: "shake")
        
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let langStr = Locale.current.languageCode
        if (langStr == "fa" || langStr == "ar")
        {
            MainInfo.Device_IsRTL = true
        }
//        Localize.setCurrentLanguage(langStr!)
        
//        let pl = UserDefaults.standard.string(forKey: "lang")
        var pl = Preference.getLanguage()
        if (pl == nil) // its first time app executes
        {
            MainInfo.IsRTL = MainInfo.Device_IsRTL
//            UF.setLang(lang: langStr!)
            Preference.setLanguage(langStr!)
            pl = langStr!
        }
        
        if (pl == "fa")
        {
            UF.doArabic()
            MainInfo.language = Settings.Language.Persian
            MainInfo.IsRTL = true
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("fa")
        } else if (pl == "en")
        {
            MainInfo.language = Settings.Language.English
            MainInfo.IsRTL = false
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Localize.setCurrentLanguage("en")
        }else if (pl == "ar")
        {
            MainInfo.language = Settings.Language.Arabic
            MainInfo.IsRTL = true
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("ar")
        }else if (pl == "ru")
        {
            MainInfo.language = Settings.Language.Russion
            MainInfo.IsRTL = false
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Localize.setCurrentLanguage("ru")
        }
        
        
       
        
         return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


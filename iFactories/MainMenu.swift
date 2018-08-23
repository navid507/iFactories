//
//  ViewController.swift
//  iFactories
//
//  Created by navid einackchi on 6/2/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Localize_Swift
class MainMenu: UIViewController, RegisterDone, VerifyDone {
   
    

    @IBOutlet weak var factoriesBT: UIButton!
    @IBOutlet weak var ordersBT: UIButton!
    @IBOutlet weak var languagesBT: UIButton!
    @IBOutlet weak var searchBT: UIButton!
    @IBOutlet weak var profileBT: UIButton!
    
   // @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
   //    btn.setTitle("Language Select".localized(), for: .normal)
        setLanguage()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLanguage()
    {
        factoriesBT.setTitle("Factories".localized(), for: .normal)
        ordersBT.setTitle("Orders".localized(), for: .normal)
        languagesBT.setTitle("Languages".localized(), for: .normal)
        searchBT.setTitle("Search".localized(), for: .normal)
        profileBT.setTitle("Profile".localized(), for: .normal)
        
    }
    
    @IBAction func soShowProfile(_ sender: Any) {
        if (MainInfo.userProfile != nil)
        {
             showProfileVC()
        }else{
            let stateReg = Preference.getRegState()
            switch stateReg
            {
            case Settings.Register_State.Nothing:
                showRegisterVC()
                break
            case Settings.Register_State.Phone:
                showVerifyVC()
                break
            case Settings.Register_State.Login:
                showProfileVC()
                break
            case Settings.Register_State.OK:
                showProfileVC()
                break
            default:
                break
            }
        }
    }
    
    func showRegisterVC()
    {
        let asb = UIStoryboard(name: "Accounting", bundle: nil)
        let rvc = asb.instantiateViewController(withIdentifier: "RegisterPhoneViewController") as! RegisterPhoneViewController
        rvc.delegate = self
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    func showVerifyVC()
    {
        let asb = UIStoryboard(name: "Accounting", bundle: nil)
        let rvc = asb.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
        rvc.delegate = self
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    func showProfileVC()
    {
        let asb = UIStoryboard(name: "Accounting", bundle: nil)
        let rvc = asb.instantiateViewController(withIdentifier: "ProfileTabsViewController") as! ProfileTabsViewController
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
    func didRegister() {
        showVerifyVC()
    }
    func didVerify() {
        showProfileVC()
    }
    
    func changePhone() {
        
        showRegisterVC()
    }
}


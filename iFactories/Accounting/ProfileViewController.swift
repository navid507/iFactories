//
//  ProfileViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/7/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController {

    @IBOutlet weak var uNameLB: UILabel!
    @IBOutlet weak var uFactoryLB: UILabel!
    @IBOutlet weak var uPhoneLB: UILabel!
    @IBOutlet weak var uMailLB: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //      setLang()
        if MainInfo.userProfile != nil
        {
            setValues()
        }
        getProfile()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setValues()
    {
        if MainInfo.userProfile == nil
        {
            return
        }
        
               uNameLB.text = (MainInfo.userProfile?.u_fname)!
        uFactoryLB.text = MainInfo.userProfile?.u_company
        uPhoneLB.text = MainInfo.userProfile?.mobile
        uMailLB.text = MainInfo.userProfile?.email
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getProfile()
    {
        
        
        let code = Preference.getUserCode()
        let phone = Preference.getUserphone()
        let uid = UIDevice.current.identifierForVendor!.uuidString
         let param = NSMutableDictionary()
        
        param.setObject(phone, forKey: "phone" as NSCopying)
        param.setObject(code, forKey: "code" as NSCopying)
        param.setObject(uid, forKey: "uniqe" as NSCopying)
        
        let url = URL(string: Settings.URLs.Login)
        var request = URLRequest(url: url!)
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseLogin(response: response)
        }
        )
        
    }
    
    func parseLogin(response: DataResponse<Any>)
    {
        switch response.result {
        case .failure(let error):
            print(error)
            
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
                
                
                
            }
        case .success(let responseObject):
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            }
            let json = JSON(responseObject)
            let state = json["error"].intValue
            
            if (state == 0)
            {
                Preference.setRegState(Settings.Register_State.OK)
                MainInfo.userProfile = UserProfile.ParseProfile(res: json)
                
            }
            else
            {
                
                MainInfo.userProfile = nil
                Preference.setRegState(Settings.Register_State.Nothing)
                
            }
            setValues()
        }
        
    }
}

//
//  RegisterPhoneViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/7/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol RegisterDone {
    func didRegister()
}
class RegisterPhoneViewController: UIViewController {

    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var errLB: UILabel!
    @IBOutlet weak var enterPhoneLB: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var pbAI: UIActivityIndicatorView!
    @IBOutlet weak var sendBT: UITextField!
    var delegate: RegisterDone?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pbAI.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServicesViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        
        view.addGestureRecognizer(tap)
        //        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//      setLang()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func doSend(_ sender: Any) {
        if (phoneTF.text?.isEmpty)!
        {
            errLB.text = "Phone Is Empty".localized()
            errLB.isHidden = false
            phoneTF.shake()
        }else if !UF.isValidPhone(phone: phoneTF.text!){
            errLB.text = "Phone Is Invalid".localized()
            errLB.isHidden = false
            phoneTF.shake()
        }else{
            doAccLogin()
        }
    }
    
    func doAccLogin()
    {
        sendBT.isHidden = true
        pbAI.isHidden = false
        errLB.isHidden = true
        
        let user = phoneTF.text
//        let pass = Preference.getUserCode()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        //        let data = NSMutableDictionary()
        let param = NSMutableDictionary()
        
        param.setObject(user, forKey: "phone" as NSCopying)
        param.setObject(uid, forKey: "uniqe" as NSCopying)
        
        /*
         JSONObject js = new JSONObject();
         js.put("phone", userp.getUserphone());
         js.put("code", userp.getUserCode());
         js.put("unique", UF.UNIQ(getApplicationContext()));
         
         String response = Web.send(Settings.URLs.Login, js.toString());
         
         
         
         */
        
        //        param.setObject(1, forKey: "remember" as NSCopying)
        
        
        //        data.setObject(param, forKey: "data" as NSCopying)
        
        let url = URL(string: Settings.URLs.Register)
        var request = URLRequest(url: url!)
        
        
        //   let values = param
        
//        request.httpBody = try! JSONSerialization.data(withJSONObject: param)
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseRegister(response: response)
        }
        )
        
    }
    
    func parseRegister(response: DataResponse<Any>)
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
            
            if ( state == 0)
            {
                Preference.setRegState(Settings.Register_State.Phone)
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didRegister()
                Preference.setUserphone(phoneTF.text!)
                
//                MainInfo.userProfile = UserProfile.ParseProfile(res: json)
            }
            else
            {
                Preference.setRegState(Settings.Register_State.Nothing)
                pbAI.isHidden = true
                sendBT.isHidden = false
                errLB.text = "There Is A Problem With Your Phone".localized()
                errLB.isHidden = false
                //                Preference.setValidUP(Settings.ValidState.Nothing)
            }
        }
        
    }
    
}

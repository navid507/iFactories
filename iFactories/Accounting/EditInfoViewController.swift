//
//  EditInfoViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/7/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditInfoViewController: UIViewController {

    @IBOutlet weak var contentV: UIView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var NameLB: UILabel!
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var NameErrLB: UILabel!
    
    @IBOutlet weak var CompanyLB: UILabel!
    @IBOutlet weak var CompanyTF: UITextField!
    @IBOutlet weak var CompanyErrLB: UILabel!
    
    @IBOutlet weak var PositionLB: UILabel!
    @IBOutlet weak var PositionTF: UITextField!
    @IBOutlet weak var PositionErrLB: UILabel!
    
    @IBOutlet weak var PhoneLB: UILabel!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var PhoneErrLB: UILabel!
    
    @IBOutlet weak var CountryLB: UILabel!
    @IBOutlet weak var CountryTF: UITextField!
    @IBOutlet weak var CountryErrLB: UILabel!
    
    @IBOutlet weak var EmailLB: UILabel!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var EmailErrLB: UILabel!
    
    @IBOutlet weak var sendBT: UIButton!
    @IBOutlet weak var sendPB: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        if (MainInfo.userProfile != nil)
        {
            setValues()
        }
        sendPB.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        
        view.addGestureRecognizer(tap)
        //        self.navigationController?.navigationBar.isHidden = true
        
        
    }
 
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func setValues()
    {
        if (MainInfo.userProfile == nil)
        {
            return
        }
        PositionTF.text = MainInfo.userProfile?.position
        NameTF.text = MainInfo.userProfile?.u_fname
        CompanyTF.text = MainInfo.userProfile?.u_company
        PhoneTF.text = MainInfo.userProfile?.phone
        CountryTF.text = MainInfo.userProfile?.u_country
        EmailTF.text = MainInfo.userProfile?.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doSend(_ sender: Any) {
        if (checkValues())
        {
            sendBT.isHidden = true
            sendPB.isHidden = false
            sendProfile()
            
        }
    }
    func checkValues()-> Bool
    {
        NameErrLB.isHidden = true
        EmailErrLB.isHidden = true
        CompanyErrLB.isHidden = true
        PositionErrLB.isHidden = true
        PhoneErrLB.isHidden = true
        CountryErrLB.isHidden = true
        
        if (NameTF.text?.isEmpty)!
        {
            NameTF.shake()
            NameTF.becomeFirstResponder()
            NameErrLB.isHidden = false
            return false
        }
        
        if (CompanyTF.text?.isEmpty)!
        {
            CompanyTF.shake()
            CompanyTF.becomeFirstResponder()
            CompanyErrLB.isHidden = false
            return false
        }
        if (PositionTF.text?.isEmpty)!
        {
            PositionTF.shake()
            PositionErrLB.isHidden = false
            PositionTF.becomeFirstResponder()
            return false
        }
        if (PhoneTF.text?.isEmpty)!
        {
            PhoneTF.shake()
            PhoneErrLB.isHidden = false
            PhoneTF.becomeFirstResponder()
            return false
        }
        if (CountryTF.text?.isEmpty)!
        {
            CountryTF.shake()
            CountryErrLB.isHidden = false
            CountryTF.becomeFirstResponder()
            return false
        }
        if (EmailTF.text?.isEmpty)!
        {
            EmailTF.shake()
            EmailErrLB.isHidden = false
            EmailTF.becomeFirstResponder()
            return false
        }
        return true
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func sendProfile()
    {
        
        
        let code = Preference.getUserCode()
        let phone = Preference.getUserphone()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        let param = NSMutableDictionary()
        
        /*
         JSONObject personalInfo = new JSONObject();
         personalInfo.put("u_fname", firstName_value);
         personalInfo.put("u_company", company_value);
         personalInfo.put("u_position", position_value);
         personalInfo.put("u_country", country_value);
         personalInfo.put("phone", tel_value);
         personalInfo.put("u_email", email_value);
         personalInfo.put("mobile", userp.getUserphone());
         personalInfo.put("uniq", uniq);
         personalInfo.put("username", userp.getUserphone());
         personalInfo.put("password", userp.getUserCode());

 */
        param.setObject(NameTF.text!, forKey: "u_fname" as NSCopying)
        param.setObject(CompanyTF.text!, forKey: "u_company" as NSCopying)
        param.setObject(PositionTF.text!, forKey: "u_position" as NSCopying)
        param.setObject(CountryTF.text!, forKey: "u_country" as NSCopying)
        param.setObject(PhoneTF.text!, forKey: "phone" as NSCopying)
        param.setObject(EmailTF.text!, forKey: "u_email" as NSCopying)
        param.setObject(phone, forKey: "mobile" as NSCopying)
        
        param.setObject(phone, forKey: "username" as NSCopying)
        param.setObject(code, forKey: "password" as NSCopying)
        param.setObject(uid, forKey: "uniqe" as NSCopying)
        
        let url = URL(string: Settings.URLs.SignUp)
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
            
            if (state == Settings.Result.NoAuth)
            {
                
                let alertController = UIAlertController( title: "Problem!".localized(), message: "Your device has lost connection to the server. Check that you have a valid internet connection.".localized(), preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK".localized(), style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(ok)
                self.present(alertController, animated: true, completion: nil)
            }
            else
            {
                let uid = json["id"].intValue
                Preference.setUserID(uid)
              
                Preference.setRegState(Settings.Register_State.OK)
                MainInfo.userProfile?.position = PositionTF.text!
                MainInfo.userProfile?.u_fname = NameTF.text!
                MainInfo.userProfile?.u_company = CompanyTF.text!
                MainInfo.userProfile?.phone = PhoneTF.text!
                MainInfo.userProfile?.u_country = CountryTF.text!
                MainInfo.userProfile?.email = EmailTF.text!
                
                let alertController = UIAlertController( title: "Problem!".localized(), message: "Your device has lost connection to the server. Check that you have a valid internet connection.".localized(), preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK".localized(), style: UIAlertActionStyle.default, handler: {
                    (action) in
                    self.navigationController?.popViewController(animated: true)
                    
                }
                )
                alertController.addAction(ok)
                self.present(alertController, animated: true, completion: nil)
            }
            setValues()
        }
        
    }
}

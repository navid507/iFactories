//
//  VerifyViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/7/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
protocol VerifyDone {
    func didVerify()
    func changePhone()
    
}
class VerifyViewController: UIViewController {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var errLB: UILabel!
    @IBOutlet weak var enterPhoneLB: UILabel!
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var pbAI: UIActivityIndicatorView!
    
    @IBOutlet weak var sendBT: UIButton!
    
    var delegate: VerifyDone?
    
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doSend(_ sender: Any) {
        if (phoneTF.text?.lengthOfBytes(using: .utf8) != 4)
        {
            errLB.text = "Code Is Invalid".localized()
            errLB.isHidden = false
            phoneTF.shake()
        }else{
            doAccLogin()
        }
    }
    
    @IBAction func doChangePhone(_ sender: Any) {
        Preference.setRegState(Settings.Register_State.Nothing)
        self.navigationController?.popViewController(animated: true)
        
        delegate?.changePhone()
    }
    func doAccLogin()
    {
        sendBT.isHidden = true
        pbAI.isHidden = false
        errLB.isHidden = true
        
        let code = phoneTF.text
        let phone = Preference.getUserphone()
        //        let pass = Preference.getUserCode()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        //        let data = NSMutableDictionary()
        let param = NSMutableDictionary()
        
        param.setObject(phone, forKey: "phone" as NSCopying)
        param.setObject(code, forKey: "code" as NSCopying)
        param.setObject(uid, forKey: "uniqe" as NSCopying)
       
        let url = URL(string: Settings.URLs.Verify)
        let request = URLRequest(url: url!)
        
        
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
            
            if (state == 0)
            {
                Preference.setRegState(Settings.Register_State.Login)
                Preference.setUserCode(phoneTF.text!)
                MainInfo.userProfile = UserProfile.ParseProfile(res: json)
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didVerify()
            }
            else
            {
                pbAI.isHidden = true
                sendBT.isHidden = false
                errLB.text = "Code Is Incorrect".localized()
                errLB.isHidden = false
                
                Preference.setRegState(Settings.Register_State.Nothing)
                //                Preference.setValidUP(Settings.ValidState.Nothing)
            }
        }
        
    }
}

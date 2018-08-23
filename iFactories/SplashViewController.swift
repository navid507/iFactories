//
//  SplashViewController.swift
//  iFactories
//
//  Created by navid einackchi on 6/2/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SplashViewController: UIViewController {

    @IBOutlet weak var errLabel: UILabel!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    @IBOutlet weak var retryBt: UIButton!
    
    var isAccLogin = false
//    var isGuild = false
    var isAnimated = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retryBt.sendActions(for: .touchUpInside)
//        Preference.setRegState(Settings.Register_State.Nothing)
        
        // Do any additional setup after loading the view.
    }
    
    func doInit()
    {
        // isCountryLoaded = false
        
        isAccLogin = false
//        isGuild = false
        
        doAccLogin()
    }
    
    @IBAction func doRetry(_ sender: Any) {
        self.retryBt.isHidden = true
        self.errLabel.isHidden = true
        self.progressView.isHidden = false
        doInit()
        //        doApiLogin()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //logoLabel
        
        progressView.startAnimating()
        self.presentMain()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doAccLogin()
    {
        let valid = Preference.getRegState()
        if (valid != Settings.Register_State.Login || valid != Settings.Register_State.OK)
        {
            self.isAccLogin = true
            return
        }
        
        let user = Preference.getUserphone()
        let pass = Preference.getUserCode()
        let uid = UIDevice.current.identifierForVendor!.uuidString
//        let data = NSMutableDictionary()
        let param = NSMutableDictionary()
        
        param.setObject(user, forKey: "phone" as NSCopying)
        param.setObject(pass, forKey: "code" as NSCopying)
        param.setObject(uid, forKey: "unique" as NSCopying)
        
        /*
         JSONObject js = new JSONObject();
         js.put("phone", userp.getUserphone());
         js.put("code", userp.getUserCode());
         js.put("unique", UF.UNIQ(getApplicationContext()));
         
         String response = Web.send(Settings.URLs.Login, js.toString());
         
         

 */
        
        //        param.setObject(1, forKey: "remember" as NSCopying)
        
        
//        data.setObject(param, forKey: "data" as NSCopying)
        
        let url = URL(string: Settings.URLs.Login)
        var request = URLRequest(url: url!)
        
        
        //   let values = param
        
//        request.httpBody = try! JSONSerialization.data(withJSONObject: param)
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseLogin(response: response)
            self.isAccLogin = true
            self.presentMain()
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
            
            if ( state == 0)
            {
                
                MainInfo.userProfile = UserProfile.ParseProfile(res: json)
            }
            else
            {
                Preference.setRegState(Settings.Register_State.Nothing)
//                Preference.setValidUP(Settings.ValidState.Nothing)
            }
        }
        isAccLogin = true
        presentMain()
    }
    
    
    
//    func getGuild()
//    {
//        //   let url = Settings.URLs.AIRLINE_URL
//        let params: Parameters = ["data": "country", "lastupdate":""]
//
//        let url = URL(string: Settings.URLs.Guild)
//        var request = URLRequest(url: url!)
//
//        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
//
//
//        //        Alamofire.request(Settings.URLs.AIRLINE_URL, method: .post, parameters: params, encoding: JSONEncoding.default,headers: Settings.headers).responseJSON { response in
//        HttpRequest.requestAPI(req: request, completion: parseGuild )
//    }
//
//    func parseGuild(response: DataResponse<Any>)
//    {
//        switch response.result {
//        case .failure(let error):
//            print(error)
//
//            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
//                print(responseString)
//              }
//        case .success(let responseObject):
//            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
//                print(responseString)
//            }
//            let json = JSON(responseObject)
//            let state = json["status"].stringValue
//
//            if ( state == "success")
//            {
//                let guilds = json[""].array
//                for guild in guilds!
//                {
//                    let g = Guild.parseGuild(obj: guild)
//                    MainInfo.Guilds.append(g)
//                }
//
////                MainInfo.Profile = CProfile.ParseProfile(res: json)
//
//            } else
//            {
////                Preference.setValidUP(Settings.ValidState.InValid)
//            }
//        }
//    }
//
    
    
    func presentMain()
    {
        if ( isAnimated && isAccLogin)
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

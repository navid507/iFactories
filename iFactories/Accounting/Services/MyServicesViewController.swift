//
//  MyServicesViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/10/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MyServicesViewController: UIViewController {

    var stvc: MyServicesTableViewController?
    public var myServices = NSMutableArray()
    
    @IBOutlet weak var serviceTitleLB: UILabel!
    @IBOutlet weak var otherserviceLB: UILabel!
    
    @IBOutlet weak var otherServiceTF: UITextField!
    @IBOutlet weak var sendBT: UIButton!
    
    @IBOutlet weak var loadingAI: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
getServices()
        UF.populateServices()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? MyServicesTableViewController {
            
            self.stvc = vc
            self.stvc?.myServices.removeAllObjects()
            //self.owvc?.delegate = self
        }
    }
    
    func getServices()
    {
        
        loadingAI.isHidden = false
        let code = Preference.getUserCode()
        let phone = Preference.getUserphone()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        let param = NSMutableDictionary()
        
        param.setObject(phone, forKey: "phone" as NSCopying)
        param.setObject(code, forKey: "code" as NSCopying)
        param.setObject(uid, forKey: "uniqe" as NSCopying)
        
        let url = URL(string: Settings.URLs.requests)
        var request = URLRequest(url: url!)
        
        
        //   let values = param
        
        
        
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
            myServices.removeAllObjects()
            let json = JSON(responseObject)
            let err = json["error"].intValue
            if (err == 0)
            {
                let servicesJSA = json["request"].arrayValue
                
                for s in servicesJSA
                {
                    let ser = Service.parseService(obj: s)
                    myServices.add(ser)
                }
                
                
            }
            loadingAI.isHidden = true
            
            setTableList()
            
            
            /*
             if (json.has("request")) {
             JSONArray Add = json.getJSONArray("request");
             //                JSONArray Add = new JSONArray(rret);
             for (int i = 0; i < Add.length(); i++) {
             try {
             JSONObject qu = Add.getJSONObject(i);
             Service cp = Service.parseService(qu);
             services.add(cp);
             } catch (Exception e) {
             
             }
             }
             }

 */
        }
        
    }
    
    func setTableList(){
        self.stvc?.myServices = self.myServices
        self.stvc?.tableView.reloadData()
    }
    
}

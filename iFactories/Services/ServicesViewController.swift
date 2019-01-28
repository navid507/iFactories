//
//  ServicesViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/5/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ServicesViewController: UIViewController {

    var stvc: ServicesTableViewController?
//    public var services = NSMutableArray()
    
    @IBOutlet weak var serviceTitleLB: UILabel!
    @IBOutlet weak var otherserviceLB: UILabel!
    
    @IBOutlet weak var otherServiceTF: UITextField!
    @IBOutlet weak var sendBT: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UF.populateServices()
        stvc?.services = MainInfo.services
        stvc?.tableView.reloadData()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServicesViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        
        view.addGestureRecognizer(tap)
//        self.navigationController?.navigationBar.isHidden = true
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        
        if (MainInfo.IsRTL)
        {
            backBT.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
        }
        
    }
    @IBOutlet weak var backBT: UIButton!
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
//        setLang()
        
    }
//    func setLang()
//    {
//        serviceTitleLB.text = "iServices".localized()
//        otherserviceLB.text = "What else do you want".localized()
//        sendBT.setTitle("Send".localized(), for: .normal)
//    }
    
    
    //Calls this function when the tap is recognized.
   

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ServicesTableViewController {
            
            self.stvc = vc
            self.stvc?.services.removeAllObjects()
            //self.owvc?.delegate = self
        }
    }
    
    @IBAction func doSend(_ sender: Any) {
        if (MainInfo.userProfile == nil)
        {
            let alert = UIAlertController(title: "RequsetSentSuccessfully".localized(), message: "WeWillContactYou".localized(), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        reqServices()
    }
    
    func reqServices()
        {
            
          
            //   let url = Settings.URLs.AIRLINE_URL
            let param = NSMutableDictionary()
            let reqs = NSMutableArray()
            for s in MainInfo.services
            {
                if let service = s as? Service
                {
                    if service.state == true
                    {
                        let req = NSMutableDictionary()
                        req.setObject(service.id, forKey: "id" as NSCopying)
                        req.setObject("", forKey: "comment" as NSCopying)
                        reqs.add(req)
                    }
                }
            }
           
            if ((otherServiceTF.text?.lengthOfBytes(using: .utf8))! > 1)
            {
                let req = NSMutableDictionary()
                req.setObject(100, forKey: "id" as NSCopying)
                req.setObject(otherServiceTF.text, forKey: "comment" as NSCopying)
                reqs.add(req)
            }
            
            
            
            param.setObject(reqs, forKey: "request" as NSCopying)
            param.setObject(MainInfo.userProfile?.username, forKey: "phone" as NSCopying)
            param.setObject(MainInfo.userProfile?.password, forKey: "code" as NSCopying)
            
            
            
            let url = URL(string: Settings.URLs.req_services)
            var request = URLRequest(url: url!)
    
//            request.httpBody = try! JSONSerialization.data(withJSONObject: param)
    
    
            
            HttpRequest.requestAPI(req: request, param: param, completion: parseServiceResult )
        }
    
        func parseServiceResult(response: DataResponse<Any>)
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
    
                if ( state == Settings.Result.Success)
                {
                    let alert = UIAlertController(title: "RequsetSentSuccessfully".localized(), message: "WeWillContactYou".localized(), preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
    
                } else
                {
                    let alert = UIAlertController(title: "Eroor".localized(), message: "PleaseTryAgain".localized(), preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
    
}

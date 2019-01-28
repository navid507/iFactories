//
//  SearchViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    var stvc: FactoriesTableViewController?
    public var myFactories = NSMutableArray()

    @IBOutlet weak var loadingPB: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServicesViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        
        view.addGestureRecognizer(tap)
        //        self.navigationController?.navigationBar.isHidden = true
        
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doSearch2(_ sender: UITextField) {
        getShops(str: sender.text!)  }
//    @IBAction func doSearch(_ sender: UITextField) {
//        getShops(str: sender.text!)
//    }
//
//    @IBAction func doSearch1(_ sender: UITextField) {
//         getShops(str: sender.text!)
//    }
   
    
    func getShops(str: String)
    {
        loadingPB.isHidden = false
        myFactories.removeAllObjects()
        setTableList()
        
        let param = NSMutableDictionary()
        
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        param.setObject(str, forKey: "keyword" as NSCopying)
        
        let url = URL(string: Settings.URLs.searchShopByTitle)
        var request = URLRequest(url: url!)
        
        
        //   let values = param
        
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseGetShops(response: response)
        }
        )
        
    }
    
    func parseGetShops(response: DataResponse<Any>)
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
            myFactories.removeAllObjects()
            let json = JSON(responseObject)
//            let err = json["error"].intValue
//            if (err == 0)
//            {
                let shopsJSA = json["shop"].arrayValue
                
                for s in shopsJSA
                {
                    let ser = Shop.parseShop(obj: s)
                    myFactories.add(ser)
                }
                
                
//            }
            setTableList()
            
            
        }
        
    }
    
    func setTableList(){
        loadingPB.isHidden = true
        self.stvc?.myFactories = self.myFactories
        self.stvc?.tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? FactoriesTableViewController {
            
            self.stvc = vc
            self.stvc?.myFactories.removeAllObjects()
            //self.owvc?.delegate = self
        }
    }
    

}

//
//  FactoryViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/21/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FactoriesViewController: UIViewController, Filtering{
    var stvc: FactoriesTableViewController?
    public var myFactories = NSMutableArray()
    public var myGuilds = NSMutableArray()
    public static var myGDIMs = NSMutableArray()
    public var guildID = -1
    
    @IBOutlet weak var loadingPB: UIActivityIndicatorView!
    @IBOutlet weak var pageTitleLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        populateGuild()
        getGDIM()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doFilter(_ sender: Any) {
        showFilter()
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
    
    func populateGuild() {
        for guild in MainInfo.Guilds
        {
            if guild.parent_id == guildID
            {
                myGuilds.add(guild)
            }
            
        }
    }
    
    func getGDIM()
    {
        loadingPB.isHidden = false
        let code = Preference.getUserCode()
        let phone = Preference.getUserphone()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        let param = NSMutableDictionary()
        
      
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        param.setObject("-1", forKey: "type" as NSCopying)
        param.setObject(uid, forKey: "unique" as NSCopying)
        
        let url = URL(string: Settings.URLs.GDIM)
        var request = URLRequest(url: url!)
        
        
        //   let values = param
        
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseGDIM(response: response)
        }
        )
        
    }
    
    func parseGDIM(response: DataResponse<Any>)
    {
        switch response.result {
        case .failure(let error):
            print(error)
            
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
                
                
                
            }
        case .success(let responseObject):
            if let data = response.data, let responseString = String(data: data, encoding: .utf8)
            {
                print(responseString)
            }
            FactoriesViewController.myGDIMs.removeAllObjects()
            let json = JSON(responseObject)
            let err = json["error"].intValue
            if (err == 0)
            {
                let servicesJSA = json["gdim"].arrayValue
                
                for s in servicesJSA
                {
                    let ser = GDIM.parseGDIM(obj: s)
                    FactoriesViewController.myGDIMs.add(ser)
                }
            }
            loadingPB.isHidden = true
            
            showFilter()
            
            
        }
        
    }
    
    
    
    func showFilter()
    {
        let fvc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        fvc.myGuilds = myGuilds
        fvc.delegate = self
        self.navigationController?.pushViewController(fvc, animated: true)

    }
    
    
    
    func doFilter(g: NSMutableArray, d: NSMutableArray, i: NSMutableArray, m: NSMutableArray, guilds: NSMutableArray) {
    myFactories.removeAllObjects()
        setTableList()
        loadingPB.isHidden = false
        
        getShops(guilds: populateGuildsFilter(guilds: guilds), gdim: populateOtherFilter(g: g, d: d, i: i, m: m))
    }
    
    func populateGuildsFilter(guilds: NSMutableArray)-> NSMutableArray
    {
        let reqs = NSMutableArray()
        for g in guilds
        {
            if let guild = g as? Guild
            {
                if (guild.selected)
                {
                    let req = NSMutableDictionary()
                    req.setObject(guild.id, forKey: "id" as NSCopying)
                    reqs.add(req)
                }
            }
        }
        
        if reqs.count == 0
        {
            for g in myGuilds
            {
                if let guild = g as? Guild
                {
                    let req = NSMutableDictionary()
                    req.setObject(guild.id, forKey: "id" as NSCopying)
                    reqs.add(req)
                }
                
            }
        }
        
        return reqs
    }
    
    func populateOtherFilter(g: NSMutableArray, d: NSMutableArray, i: NSMutableArray, m: NSMutableArray)-> NSMutableArray
    {
        let reqs = NSMutableArray()
        for gdim in g
        {
            if let gd = gdim as? GDIM
            {
                if (gd.selected)
                {
                    let req = NSMutableDictionary()
                    req.setObject(gd.id, forKey: "id" as NSCopying)
                    reqs.add(req)
                }
            }
        }
        for gdim in d
        {
            if let gd = gdim as? GDIM
            {
                if (gd.selected)
                {
                    let req = NSMutableDictionary()
                    req.setObject(gd.id, forKey: "id" as NSCopying)
                    reqs.add(req)
                }
            }
        }
        for gdim in i
        {
            if let gd = gdim as? GDIM
            {
                if (gd.selected)
                {
                    let req = NSMutableDictionary()
                    req.setObject(gd.id, forKey: "id" as NSCopying)
                    reqs.add(req)
                }
            }
        }
        for gdim in m
        {
            if let gd = gdim as? GDIM
            {
                if (gd.selected)
                {
                    let req = NSMutableDictionary()
                    req.setObject(gd.id, forKey: "id" as NSCopying)
                    reqs.add(req)
                }
            }
        }
        
         return reqs
    }
    
    func getShops(guilds: NSMutableArray, gdim: NSMutableArray)
    {
        
        
        let param = NSMutableDictionary()
        loadingPB.isHidden = false
        
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        param.setObject(guildID, forKey: "guild" as NSCopying)
        param.setObject(guilds, forKey: "guilds" as NSCopying)
        param.setObject(gdim, forKey: "gdim" as NSCopying)
        
        let url = URL(string: Settings.URLs.shop)
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
            let err = json["error"].intValue
            if (err == 0)
            {
                let shopsJSA = json["shop"].arrayValue
                
                for s in shopsJSA
                {
                    let ser = Shop.parseShop(obj: s)
                    myFactories.add(ser)
                }
                
                
            }
            setTableList()
            loadingPB.isHidden = true
            
            
        }
        
    }
    
    func setTableList(){
        loadingPB.isHidden = true
        self.stvc?.myFactories = self.myFactories
        self.stvc?.tableView.reloadData()
    }
    
    
/*    private JSONArray populateOtherFilter() {
    JSONArray j = new JSONArray();
    for (Standard g : App.others) {
    if (g.isSelected()) {
    try {
    JSONObject ch = new JSONObject();
    ch.put("id", g.getId());
    j.put(ch);
    } catch (Exception err) {
    
    }
    }
    }
    
    //        if (j.length() == 0) {
    //            for (Standard g : App.others) {
    //                try {
    //                    JSONObject ch = new JSONObject();
    //                    ch.put("id", g.getId());
    //                    j.put(ch);
    //                } catch (Exception err) {
    //
    //                }
    //            }
    //        }
    return j;
    
    }
*/
    
    
}

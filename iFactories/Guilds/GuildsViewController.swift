//
//  GuildsViewController.swift
//  iFactories
//
//  Created by navid einackchi on 7/21/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageSlideshow
import Kingfisher

class GuildsViewController: UIViewController, GuildSelectP {

    @IBOutlet weak var gallerySlider: ImageSlideshow!
    var stvc: GuildTableViewController?
//    public static var myGuilds = NSMutableArray()
    public var myGDIM = NSMutableArray()
    public var ads = [String]()
    
    let pparent = -1
    @IBOutlet weak var pbAIV: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        getGuilds()
        // Do any additional setup after loading the view.
        if (MainInfo.IsRTL)
        {
            backBT.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
        }
        
        getGallery()
        
    }
    @IBOutlet weak var backBT: UIButton!
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        if let vc = segue.destination as? GuildTableViewController {
            
            self.stvc = vc
            self.stvc?.myGuilds.removeAll()
            self.stvc?.delegate = self
        }
    }
    
    func guildSelected(guild: Guild) {
        let fvc = self.storyboard?.instantiateViewController(withIdentifier: "FactoryViewController") as! FactoriesViewController
        fvc.selectedGuild = guild
        self.navigationController?.pushViewController(fvc, animated: true)
    }
    
    func getGuilds()
    {
        pbAIV.isHidden = false
        
        let code = Preference.getUserCode()
        let phone = Preference.getUserphone()
        let uid = UIDevice.current.identifierForVendor!.uuidString
        let param = NSMutableDictionary()
        
      
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        
        let url = URL(string: Settings.URLs.Guild)
        var request = URLRequest(url: url!)
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseGuilds(response: response)
        }
        )
        
    }
    
    func parseGuilds(response: DataResponse<Any>)
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
            MainInfo.Guilds.removeAll()
            let json = JSON(responseObject)
            let err = json["error"].intValue
            if (err == 0)
            {
                let servicesJSA = json["guilds"].arrayValue
                
                for s in servicesJSA
                {
                    let ser = Guild.parseGuild(obj: s)
                    MainInfo.Guilds.append(ser)
                }

            }
            setTableList()
   
        }
        
    }
    
    
    func setTableList(){
        pbAIV.isHidden = true
        for g in MainInfo.Guilds
        {
            if g.parent_id == pparent
            {
                self.stvc?.myGuilds.append(g)
            }
        }
//        self.stvc?.myGuilds = MainInfo.Guilds
        self.stvc?.tableView.reloadData()
    }
    
    // Mark: for Gallery
    func getGallery()
    {
//        pbAIV.isHidden = false
        
          let param = NSMutableDictionary()
        
        
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        
        let url = URL(string: Settings.URLs.Ads)
        var request = URLRequest(url: url!)
        
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseGallery(response: response)
        }
        )
        
    }
    
    func parseGallery(response: DataResponse<Any>)
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
            MainInfo.Guilds.removeAll()
            let json = JSON(responseObject)
            let err = json["error"].intValue
            if (err == 0)
            {
                let servicesJSA = json["ads_guild"].arrayValue
                
                for s in servicesJSA
                {
                    let ser = s.stringValue
                    ads.append(ser)
                }
                
            }
            showAds()
            
        }
        
    }
    
    func showAds()
    {
        var iis = [KingfisherSource]()
        for s in ads
        {
            let source = KingfisherSource(urlString: s)
            iis.append(source!)
        }
        gallerySlider.contentScaleMode = .scaleAspectFill
       gallerySlider.setImageInputs(iis)
        gallerySlider.slideshowInterval = 5
        let pageIndicator = PageControlPosition.insideScrollView
//        pageIndicator.currentPageIndicatorTintColor = UIColor.lightGray
//        pageIndicator.pageIndicatorTintColor = UIColor.black
        gallerySlider.pageControlPosition = pageIndicator
        
    }
    
}

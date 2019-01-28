//
//  CategoryViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/12/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoryViewController: UIViewController, OnSelectedCat {
    
    
    @IBOutlet weak var catNameLB: UILabel!
    var factory: Shop?
    var ctvc: CategoriesTableViewController?
    public static var myCats = NSMutableArray()
    public var filteredCats = NSMutableArray()
    public var selectedCat: Category?
    
    
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UF.changeAllFonts(parent: self.view, lang: MainInfo.language)
        if (CategoryViewController.myCats.count > 0)
        {
            populateSelectedCats()
            catNameLB.text = "Sub Categories Of".localized() + (selectedCat?.name)!
        }else{
            
            getAllCats()
            
        }
        
         // Do any additional setup after loading the view.
        if (MainInfo.IsRTL)
        {
            backBT.transform = CGAffineTransform(rotationAngle: CGFloat.pi )
        }
        
    }
    @IBOutlet weak var backBT: UIButton!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? CategoriesTableViewController {
            
            self.ctvc = vc
            self.ctvc?.myCats.removeAllObjects()
            self.ctvc?.delegate = self
        }
    }
 
    func getAllCats()
    {
        let param = NSMutableDictionary()
        
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        param.setObject(factory?.id, forKey: "id" as NSCopying)
        
        let url = URL(string: Settings.URLs.cats)
        var request = URLRequest(url: url!)
        
        //   let values = param

        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseGetCats(response: response)
        }
        )
        
    }
    
    func parseGetCats(response: DataResponse<Any>)
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
            CategoryViewController.myCats.removeAllObjects()
            let firstCat = Category()
            firstCat.parent_id = 0
            firstCat.id = -1
            firstCat.name = "Categories".localized()
            CategoryViewController.myCats.add(firstCat)
            selectedCat = firstCat
            
            let json = JSON(responseObject)
            let err = json["error"].intValue
            if (err == 0)
            {
                let shopsJSA = json["cat"].arrayValue
                
                for s in shopsJSA
                {
                    let ser = Category.parseCategory(obj: s)
                    CategoryViewController.myCats.add(ser)
                }
            }
            populateSelectedCats()
            
            
        }
        
    }
    
    func populateSelectedCats()
    {
        filteredCats.removeAllObjects()
        for cat in CategoryViewController.myCats
        {
            if let c = cat as? Category
            {
                if (c.parent_id == selectedCat?.id)
                {
                    filteredCats.add(c)
                }
            }
        }
        setTableList()
       
    }
    func onCatSelected(cat: Category) {
        if (cat.type == 1)
        {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            vc.cat = cat
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }else{
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
            vc.selectedCat = cat
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func setTableList(){
        self.ctvc?.myCats = self.filteredCats
        self.ctvc?.tableView.reloadData()
    }
}

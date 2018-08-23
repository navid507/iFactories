//
//  ProductViewController.swift
//  iFactories
//
//  Created by navid einackchi on 8/12/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductViewController: UIViewController {
    var cat: Category?
    var ctvc: ProductsCollectionViewController?
    
    public var myProducts = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllProducts()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getAllProducts()
    {
        let param = NSMutableDictionary()
        
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
        param.setObject(cat?.id, forKey: "cat_id" as NSCopying)
        
        let url = URL(string: Settings.URLs.searchProductByCat)
        var request = URLRequest(url: url!)
        
        //   let values = param
        
        HttpRequest.requestAPI(req: request, param: param, completion: { (response) -> Void in
            
            self.parseGetPrds(response: response)
        }
        )
        
    }
    
    func parseGetPrds(response: DataResponse<Any>)
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
            myProducts.removeAllObjects()
            
            let json = JSON(responseObject)
            let err = json["error"].intValue
            if (err == 0)
            {
                let shopsJSA = json["product"].arrayValue
                
                for s in shopsJSA
                {
                    let ser = Product.parseProduct(obj: s)
                    myProducts.add(ser)
                }
            }
            setTableList()
            
            
        }
        
    }
    func setTableList(){
        self.ctvc?.myProducts = self.myProducts
        self.ctvc?.collectionView?.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ProductsCollectionViewController {
            
            self.ctvc = vc
            self.ctvc?.myProducts.removeAllObjects()
            //            self.ctvc?.delegate = self
        }
        
        
        
    }
    
    
}

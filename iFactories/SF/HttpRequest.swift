//
//  HttpRequest.swift
//  iFactories
//
//  Created by navid einackchi on 6/14/18.
//  Copyright © 2018 sanabadai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpRequest
{
    class func requestAPI(req: URLRequest, param: NSMutableDictionary,  completion:@escaping (DataResponse<Any>) -> Void ) -> DataRequest{
        var request = req
        
        param.setObject(MainInfo.language, forKey: "lang" as NSCopying)
    
        request.httpBody = try! JSONSerialization.data(withJSONObject: param)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return Alamofire.request(request).responseJSON { (response) -> Void in
            
            completion(response)
        }
        
        
    }
}

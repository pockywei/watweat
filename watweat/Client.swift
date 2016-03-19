//
//  client.swift
//  watweat
//
//  Created by Regina Zhang on 3/19/16.
//  Copyright © 2016 WEI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON


class Client {
    //let id:Int
    let alias:String
    
    init() {
        //id = 1;
        alias = "Xiao Fang"
    }
    
    func sendRequest(url:NSURL, params:[String:AnyObject], method:Alamofire.Method) {
        Alamofire.request(method, url, parameters: params)
            .responseSwiftyJSON({ (request, response, json, error) in
                print(json)
                print(error)
                //let street:String = json["array"][0]["street"].string!
                //print(street)
            })
    }
    
    func going()
}
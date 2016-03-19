//
//  ViewController.swift
//  watweat
//
//  Created by WEI on 16/3/18.
//  Copyright © 2016年 WEI. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
        
        let client = Client()
        //client.sendMessage("hello!", restaurant_id: 1)
        client.unread_message_request(1)
        /*var url = NSURL(string:"http://10.0.7.25:4567/restaurant_chat")
        var parameters : [String:AnyObject]?
        parameters = ["alias":client.alias, "idRestaurant":1]
        if parameters==nil{
            parameters = ["":NSNull()]
        }
        
        if let para = parameters{
            client.sendRequest(url!,params: parameters!, method: Alamofire.Method.POST)
        }
        else
            
        {
            
            print("NO PARAMETER")
        }*/
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


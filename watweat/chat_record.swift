//
//  User.swift
//  watweat
//
//  Created by WEI on 16/3/20.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation


class chat_record{
	class var sharedInstance: chat_record {
		struct Static {
			static var instance: chat_record?
			static var token: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.token) {
			Static.instance = chat_record()
		}
		
		return Static.instance!
	}
	
	
	var record = [String : String]()
	var name = [String]()
	var context = [String]()
	
	
}
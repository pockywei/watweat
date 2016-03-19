//
//  User.swift
//  watweat
//
//  Created by WEI on 16/3/20.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation


class User{
	class var sharedInstance: User {
		struct Static {
			static var instance: User?
			static var token: dispatch_once_t = 0
		}
		
		dispatch_once(&Static.token) {
			Static.instance = User()
		}
		
		return Static.instance!
	}
	
	var ID : Int?
	var name : String?
	
	
	
}
//
//  chatRoom.swift
//  watweat
//
//  Created by WEI on 16/3/19.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation


class chatRoom {
	var chatroomname:String?
	var chatroomContext:String?
	var chatroomID:Int
	
	
	init(chatroomname:String,chatroomContext:String,chatroomID:Int){
	self.chatroomname=chatroomname
	self.chatroomContext=chatroomContext
		self.chatroomID=chatroomID
	}
}
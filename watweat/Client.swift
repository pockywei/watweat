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
	let recordchat = chat_record.sharedInstance
	var flag = false
	let user = User.sharedInstance
	let id:Int
	let alias:String
	let considering:String
	var artw : Artwork?
	init(id:Int,alias:String,considering:String,artw:Artwork) {
		self.artw = artw
		self.id = id;
		self.alias = alias
		self.considering = considering
	}
	
	func sendRequest(url:NSURL, params:[String:AnyObject], method:Alamofire.Method, action_func: (SwiftyJSON.JSON)->Bool)->Bool{
		//, inout out_json: SwiftyJSON.JSON ){
		var flag = false
		Alamofire.request(method, url, parameters: params)
			.responseSwiftyJSON({ (request, response, json, error) in
				print(request.HTTPBody)
				print(json)
				print(error)
				//out_json = json
				//let street:String = json["array"][0]["street"].string!
				//print(street)
				flag=action_func(json)
				
			})
		//print(flag)
		return flag
	}
	
	func joinReqst(restaurant_id: Int, joint_type: Character){
		let parameters:[String:AnyObject] = ["idRestaurant":restaurant_id, "alias":alias, "idUser":id]
		if (joint_type == "G"){
			let url = NSURL(string:"http://10.0.7.25:4567/test_post")
			//var response = SwiftyJSON.JSON([:])
			sendRequest(url!, params:parameters, method: Alamofire.Method.POST, action_func: do_going)//, out_json:&response)
			//assert(response["status"].string == "success")
			//print(response["status"])
		} else if (joint_type == "C"){
			let url = NSURL(string: "")
			sendRequest(url!, params:parameters, method: Alamofire.Method.POST, action_func: do_considering)
		}
		print("hello")
	}
	
	func do_going(json: SwiftyJSON.JSON)->Bool{
		if (json.exists() && json["status"].string == "success"){
			print("this json => " + json["status"].string!)
			//enable_chatroom(json["idGroupChat"].int!)
			return true
		}else{
			print("ERROR occurred when sending going request")
			return false
		}
	}
	
	func do_considering(json: SwiftyJSON.JSON)->Bool{
		if (json.exists() && json["status"].string == "success"){
			print("this json => " + json["status"].string!)
			let phoneNumber = json["array"]["phoneNo"].int
			
			print(artw?.locationName)
			user.roomdic[(artw?.phoneNumber)!] = artw?.locationName
			print("count dic")
			print(user.roomdic.count)

			return true
			
			
			
		}else{
			print("ERROR occurred when sending considering request")
			return false
		}
		
		
	}
	
	
	func sendMessage(message:String, restaurant_id: Int){
		let parameters:[String:AnyObject] = ["alias":alias, "message":message, "idRestaurant":restaurant_id, "idUser":id]
		let url = NSURL(string:"http://10.0.7.25:4567/restaurant_chat_send")
		sendRequest(url!, params: parameters, method: Alamofire.Method.POST, action_func: do_send_message)
	}
	
	func do_send_message(json: SwiftyJSON.JSON)->Bool{
		if (json.exists()){
			print("json exists")
			if(json["status"].string == "success"){
				print("this json => " + json["status"].string!)
				return true
				//show_message(json["message"].string!, alias: json["alias"].string!)
			}
		}else{
			print("ERROR occurred when sending message")
			return false
		}
		
	return false
	}
	
	func do_consideration_request(restaurant_id: Int)->Bool{
		let parameters:[String: AnyObject] = ["alias": alias, "idRestaurant":restaurant_id, "idUser":id, "going_considering":considering]
		let url = NSURL(string:"http://10.0.7.25:4567/restaurant_go")
		return sendRequest(url!, params: parameters, method: Alamofire.Method.GET, action_func: do_considering)
		
	}
	
	func unread_message_request(restaurant_id: Int){
		let parameters:[String: AnyObject] = ["alias": alias, "idRestaurant":restaurant_id, "idUser":id]
		let url = NSURL(string:"http://10.0.7.25:4567/restaurant_chat")
		sendRequest(url!, params: parameters, method: Alamofire.Method.GET, action_func: get_messages)
		
	}
	
	func get_messages(json: SwiftyJSON.JSON)->Bool{
		if (json.exists() && json["status"].string == "success"){
			print("this json => " + json["status"].string!)
			for m in json["array"].array! {
				show_message(m["message"].string!, alias: m["sender_alias"].string!)
			}
			return true
		}else{
			print("ERROR occurred when sending message")
			return false
		}
	}
	
	// Todo
	//
	func show_message(message: String, alias: String){
		recordchat.record[alias] = message
		recordchat.context.append(message)
		recordchat.name.append(alias)
		print(message)
	}
}
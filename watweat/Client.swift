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
	let id:Int
	let alias:String
	
	init() {
		id = 2;
		alias = "lalala"
	}
	
	func sendRequest(url:NSURL, params:[String:AnyObject], method:Alamofire.Method, action_func: (SwiftyJSON.JSON)->()){
		//, inout out_json: SwiftyJSON.JSON ){
		Alamofire.request(method, url, parameters: params)
			.responseSwiftyJSON({ (request, response, json, error) in
				print(request.HTTPBody)
				print(json)
				print(error)
				//out_json = json
				//let street:String = json["array"][0]["street"].string!
				//print(street)
				action_func(json)
			})
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
	
	func do_going(json: SwiftyJSON.JSON){
		if (json.exists() && json["status"].string == "success"){
			print("this json => " + json["status"].string!)
			enable_chatroom(json["idGroupChat"].int!)
			
		}else{
			print("ERROR occurred when sending going request")
		}
	}
	
	func do_considering(json: SwiftyJSON.JSON){
		if (json.exists() && json["status"].string == "success"){
			print("this json => " + json["status"].string!)
			enable_chatroom(json["idGroupChat"].int!)
			
		}else{
			print("ERROR occurred when sending considering request")
		}
		
	}
	
	// Todo
	func enable_chatroom(group_chat_id: Int){
		
	}
	
	func sendMessage(message:String, restaurant_id: Int){
		let parameters:[String:AnyObject] = ["alias":alias, "message":message, "idRestaurant":restaurant_id, "idUser":id]
		let url = NSURL(string:"http://10.0.7.25:4567/restaurant_chat_send")
		sendRequest(url!, params: parameters, method: Alamofire.Method.POST, action_func: do_send_message)
	}
	
	func do_send_message(json: SwiftyJSON.JSON){
		if (json.exists()){
			print("json exists")
			if(json["status"].string == "success"){
				print("this json => " + json["status"].string!)
				//show_message(json["message"].string!, alias: json["alias"].string!)
			}
		}else{
			print("ERROR occurred when sending message")
		}
	}
	
	func unread_message_request(restaurant_id: Int){
		let parameters:[String: AnyObject] = ["alias": alias, "idRestaurant":restaurant_id, "idUser":id]
		let url = NSURL(string:"http://10.0.7.25:4567/restaurant_chat")
		sendRequest(url!, params: parameters, method: Alamofire.Method.GET, action_func: get_messages)
		
	}
	
	func get_messages(json: SwiftyJSON.JSON){
		if (json.exists() && json["status"].string == "success"){
			print("this json => " + json["status"].string!)
			for m in json["array"].array! {
				show_message(m["message"].string!, alias: m["sender_alias"].string!)
			}
		}else{
			print("ERROR occurred when sending message")
		}
	}
	
	// Todo
	func show_message(message: String, alias: String){
		print(message)
	}
}
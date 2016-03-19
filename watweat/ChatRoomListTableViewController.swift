//
//  ChatRoomTableViewCobtroller.swift
//  watweat
//
//  Created by WEI on 16/3/19.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation
import UIKit


class ChatRoomListTableViewController:UITableViewController {
	
	
	
	var Chatrooms = [chatRoom]()
	
	
	
	@IBAction func BackButton(sender: AnyObject) {
		let isPresentingInAddMealMode = presentingViewController is UINavigationController
		print("4")
		if isPresentingInAddMealMode {
			print("5")
			dismissViewControllerAnimated(true, completion: nil)
			
		} else {
			navigationController!.popViewControllerAnimated(true)
			print("6")
			
			
		}
		
	}
	override func viewDidAppear(animated: Bool) {
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		Chatrooms.append(chatRoom(chatroomname: "Hi",chatroomContext: "Melbourne Uni",chatroomID: 1))
		
		
		
		print(Chatrooms.count)

		
				print("@@@@@@@@@@@@@")
	}
	
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections.
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Chatrooms.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		print("Decline_cell")
		
		
		
		let cell = tableView.dequeueReusableCellWithIdentifier("ChatListCellid", forIndexPath: indexPath) as! ChatListCell
		
		
		let chat_cell = Chatrooms[indexPath.row]
		
		
		print("here is :")
		print(chat_cell.chatroomname)
		cell.ChatRoomName.text=chat_cell.chatroomname
		cell.ChatContext.text=chat_cell.chatroomContext
		
		
		//		cell.Tournament.text = offer_cell.Tournament
		//
		//		cell.Offer_date.text = offer_cell.Match_date
		
		
		return cell
		
		
		
	}

	
}
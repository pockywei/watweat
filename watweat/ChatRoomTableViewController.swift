//
//  ChatRoomTableViewController.swift
//  watweat
//
//  Created by WEI on 16/3/19.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation



import Foundation
import UIKit


class ChatRoomTableViewController:UITableViewController {
	let user = User.sharedInstance
	let recordchat = chat_record.sharedInstance
	var art : Artwork?
	@IBOutlet weak var TextField: UITextField!
	
	@IBAction func BackButton(sender: AnyObject) {
		let isPresentingInAddMealMode = presentingViewController is UINavigationController
		print("1")
		if isPresentingInAddMealMode {
			dismissViewControllerAnimated(true, completion: nil)
			print("2")
					} else {
			print("3")
			navigationController!.popViewControllerAnimated(true)

			
			
		}
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		user.cl = Client(id: 2,alias: "test1",considering: "C",artw:art!)
		user.cl?.unread_message_request((art?.phoneNumber)!)
		
		
		
	}
	
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections.
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 15
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		print("Decline_cell")
		
		
		
		let cell = tableView.dequeueReusableCellWithIdentifier("chat_page", forIndexPath: indexPath) 
		
		
		let chat_cell = Chatrooms[indexPath.row]
		
		
				
		
		//		cell.Tournament.text = offer_cell.Tournament
		//
		//		cell.Offer_date.text = offer_cell.Match_date
		
		
		return cell
		
		
		
	}
	
	
}
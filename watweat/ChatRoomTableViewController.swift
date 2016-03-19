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
		
	}
	
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections.
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 100
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		print("Decline_cell")
		
		
		
		let cell = tableView.dequeueReusableCellWithIdentifier("ChatListCellid", forIndexPath: indexPath) as! ChatListCell
		
		
		//let chat_cell = Chatrooms[indexPath.row]
		
		
				
		
		//		cell.Tournament.text = offer_cell.Tournament
		//
		//		cell.Offer_date.text = offer_cell.Match_date
		
		
		return cell
		
		
		
	}
	
	
}
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
	
	
}
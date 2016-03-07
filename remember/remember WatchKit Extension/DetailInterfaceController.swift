//
//  DetailInterfaceController.swift
//  remember
//
//  Created by Ludimila da Bela Cruz on 25/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import Foundation
import EventKit
import WatchConnectivity


class DetailInterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var detailLabel: WKInterfaceLabel!
    
    var reminder = EKReminder()
    var saveString = [String]()
    var session:WCSession!
    var message = String()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.reminder = (context as? EKReminder)!
        self.detailLabel.setText(reminder.title)
        self.setupWatchConnectivity()
        
        if(WCSession.isSupported()){
            session.sendMessage(["b":"goodBye"], replyHandler: nil, errorHandler: nil)
        }
    
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.addData()

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBOutlet var statusReminders: WKInterfacePicker!
    
    //
    func addData(){
        
        let itemList: [(String, String)] = [("Item 1", "DONE!"),("Item 2", "To Do"),("Item 3", "Forgot it")]
   
        let pickerItems: [WKPickerItem] = itemList.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = $0.0
            pickerItem.title = $0.1
            
            self.saveString.append(pickerItem.title!)
            
    
            return pickerItem
        }//fim map
    
        
        statusReminders.setItems(pickerItems)
    
    }
    
    @IBAction func saveReminder() {
        
        if self.saveString[0] == "DONE!"{
            
            self.reminder.completed = true
            self.reminder.completionDate = NSDate()
        }else if self.saveString[1] == "To Do"{
            
            self.reminder.completed = false
            
        }else{
            
            self.reminder.completed = false
        }
        
        
    }
    
    
    
    //conectividade do lado do watch
    func setupWatchConnectivity() {
        
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
    }
    
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
         self.message = (message["a"]! as? String)!
    }
    
    
}

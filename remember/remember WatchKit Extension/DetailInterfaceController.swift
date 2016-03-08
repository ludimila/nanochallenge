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
    var arrayReminder = [String]()
    
    
    //watchcnonnectivity
    var session:WCSession!
    var reminderTitle = String()
    var reminderCompletionDate = String()
    var reminderDueDate = String()
    var reminderPriority = String()
    var reminderIdentifier = String()

    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.reminder = (context as? EKReminder)!
        self.detailLabel.setText(reminder.title)
    }

    override func willActivate() {
        super.willActivate()
        self.addData()
        
        self.setupWatchConnectivity()

    }

    override func didDeactivate() {
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
            
           self.compareReminder(self.reminder)
            
        }else if self.saveString[1] == "To Do"{
            
            self.reminder.completed = false
            
        }else{
            
            self.reminder.completed = false
        }
        
        self.popController()
    }
    
    //verifica se a task atual e a original são iguais/mesmas
    func compareReminder(reminder: EKReminder){
        for (_, task) in InterfaceController.reminders.enumerate(){
        
            if task == reminder{
                task.completionDate = NSDate()
                
                self.makeString(task)
                
                if(WCSession.isSupported()){
                    self.transferUserInfo(["reminder" : self.arrayReminder])
                }
            
            }
            
        }
    }
    
    
    func transferUserInfo(userInfo: [String : AnyObject]) -> WCSessionUserInfoTransfer? {
        return session?.transferUserInfo(userInfo)
    }
    
    
    
    //transforma os dados do lembretes em strings
    func makeString(reminder: EKReminder){
    
        self.reminderTitle = reminder.title
        self.reminderCompletionDate = getDayOfReminder(reminder.completionDate!)
        self.reminderDueDate = getDayOfReminder((reminder.dueDateComponents?.date)!)
        self.reminderPriority = ("\(reminder.priority)")
        self.reminderIdentifier = reminder.calendarItemIdentifier
        
        
        self.arrayReminder.append(self.reminderTitle)
        self.arrayReminder.append(self.reminderCompletionDate)
        self.arrayReminder.append(self.reminderDueDate)
        self.arrayReminder.append(self.reminderPriority)
        self.arrayReminder.append(self.reminderIdentifier)
        
    
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
         self.reminderTitle = (message["a"]! as? String)!

    }
    
    
    
    //converte data pra string
    func getDayOfReminder(date: NSDate) -> String{
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let convertToString = formatter.stringFromDate(date)
        
        return convertToString
    }

    
}

//
//  TaskListInterfaceController.swift
//  remember
//
//  Created by Ludimila da Bela Cruz on 23/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//



import WatchKit
import Foundation
import EventKit

class TaskListInterfaceController: WKInterfaceController {
 
    @IBOutlet var tableData: WKInterfaceTable!
    
    var arrayData = [EKReminder]()
    var eventStore: EKEventStore!
    var reminders: [EKReminder]!
    var events: [EKEvent]!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.eventStore = EKEventStore()
        self.reminders = [EKReminder]()
        self.requestAccessReminder()
        self.requestAccessCalendar()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        if segueIdentifier == "showDetails"{
           return self.arrayData[rowIndex].title
        }
        
        return nil
    }
    
    
    //calendario
    
    
    //acessa os lembretes
    func requestAccessReminder(){
        self.eventStore.requestAccessToEntityType(.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                let predicate = self.eventStore.predicateForRemindersInCalendars(nil)
                self.eventStore.fetchRemindersMatchingPredicate(predicate, completion: { (reminders: [EKReminder]?) -> Void in
                    
                    self.reminders = reminders
                    
                    dispatch_async(dispatch_get_main_queue()) {

                        self.putData(reminders!)
 
                    }
                })
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }
    }
    
    
    func putData(array: [EKReminder]){
        
        self.tableData.setNumberOfRows(array.count, withRowType: "row")
        
        for (index, task) in array.enumerate(){


            let row = tableData.rowControllerAtIndex(index) as! RowListController
            row.taskLabel.setText(task.title)
            
            if task.dueDateComponents != nil {

                row.taskHour.setText("\(task.dueDateComponents!.hour):\(task.dueDateComponents!.minute)")
            }
            
            self.managePriority(task.priority,row: row)
    
            self.arrayData = array
        }
        
        
    }
    
    
    //seta a cor do separator de acordo com a prioridade da task
    func managePriority(prioprity: Int, row: RowListController){
        
        switch(prioprity){
        
        case 0:
            row.separator.setColor(UIColor.whiteColor())
        case 9:
            row.separator.setColor(UIColor.greenColor())
        case 5:
            row.separator.setColor(UIColor.yellowColor())
        case 1:
            row.separator.setColor(UIColor.redColor())
        default:
            print("Deu ruim no separator")
        }
    
    }
    
   // acessa eventos calendario
    func requestAccessCalendar(){
    
        self.eventStore.requestAccessToEntityType(.Event) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                
                let predicate = self.eventStore.predicateForEventsWithStartDate(NSDate(), endDate: NSDate(), calendars: nil)
                self.events = self.eventStore.eventsMatchingPredicate(predicate)
               // print(self.events)
            
            }else{
                print("The app is not permitted to access calendar, make sure to grant permission in the settings and try again")
            }
            
        }
    
    }
    
    
//    //deleta os lembretes
//    
//    func removeReminder(array: [EKReminder]){
//    
//        for (index, task) in array.enumerate(){
//            
//            let reminder: EKReminder = self.reminders[index]
//            
//            do{
//                
//                
//            }
//            
//            let row = tableData.rowControllerAtIndex(index) as! RowListController
//            row.taskLabel.setText(task.title)
//            
//            self.arrayData = array
//        }
//
//    
//    }
    
    
    
}






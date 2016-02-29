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
    
    var arrayData = [String]()
    var eventStore: EKEventStore!
    var reminders: [EKReminder]!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.putData(context as! [String])
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        self.eventStore = EKEventStore()
        self.reminders = [EKReminder]()
        self.requestAccessReminder()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    func putData(array: [String]){
        
        self.tableData.setNumberOfRows(array.count, withRowType: "row")
        
        for (index, taskName) in array.enumerate(){
            
            let row = tableData.rowControllerAtIndex(index) as! RowListController
            row.taskLabel.setText(taskName)
            
            self.arrayData = array
        }
        

    }
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        if segueIdentifier == "showDetails"{
            return self.arrayData[rowIndex]
        }
        
        return nil
    }
    
    
    //calendario
    
    func requestAccessReminder(){
    

        self.eventStore.requestAccessToEntityType(EKEntityType.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                let predicate = self.eventStore.predicateForRemindersInCalendars(nil)
                self.eventStore.fetchRemindersMatchingPredicate(predicate, completion: { (reminders: [EKReminder]?) -> Void in
                    
                    self.reminders = reminders
                    
                    dispatch_async(dispatch_get_main_queue()) {

                        print(reminders)

                        
                    }
                })
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }
    
    
    }
}

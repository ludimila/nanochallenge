//
//  TaskListInterfaceController.swift
//  remember
//
//  Created by Ludimila da Bela Cruz on 23/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import Foundation


class TaskListInterfaceController: WKInterfaceController {
 
    @IBOutlet var tableData: WKInterfaceTable!
    
    
var arrayData = [String]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
     self.putData(context as! [String])
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
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
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        let tryAgain = WKAlertAction(title: "Try Again", style: .Default, handler: { () -> Void in })
        let cancel = WKAlertAction(title: "Cancel", style: .Cancel, handler: { () -> Void in })
        self.presentAlertControllerWithTitle("Title.", message: "Message.", preferredStyle: WKAlertControllerStyle.Alert, actions:[tryAgain, cancel])

        
    }
    
}
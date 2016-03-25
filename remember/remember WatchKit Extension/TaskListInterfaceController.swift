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
        self.putData(InterfaceController.arrayIphone)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }


    //preenche a table com os lembretes do dia de hoje
    func putData(array: [String]){
        

        self.tableData.setNumberOfRows(array.count, withRowType: "row")
        
        for (index, task) in array.enumerate(){
            
            let row = tableData.rowControllerAtIndex(index) as! RowListController
            //let taskDay = getDayOfReminder(task.dueDateComponents!.date!)
            
            row.taskLabel.setText(task)
        
            print(task)
             
//            self.managePriority(task.priority,row: row)
//            self.arrayData = arrayReminder
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
            break
        }
    
    }
    
    
    //chama a tela com o dictation - REMOVER ESSE METODO 
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        if segueIdentifier == "newReminder"{
            
            return "oi"
            
        }else{
            return nil
        }
    }//fim segue
    
    
    
    
    
    
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        
        if segueIdentifier == "showDetails"{
            return self.arrayData[rowIndex]
        }
        
        return nil
    }
    
    
    
    //converte data pra string
    func getDayOfReminder(date: NSDate) -> String{
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let convertToString = formatter.stringFromDate(date)
        
        return convertToString
    }
    
    
}//fim classe






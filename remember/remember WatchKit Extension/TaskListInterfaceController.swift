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
    
    
    var arrayReminderTitles = [String]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.putData(InterfaceController.arrayIphone)
        
    }

    override func willActivate() {
        super.willActivate()
        
    }


    //preenche a table com os lembretes do dia de hoje
    func putData(reminders: [String]){
        
        self.tableData.setNumberOfRows(reminders.count/3, withRowType: "row")
        
        for index in 0 ... reminders.count/3-1 {
            
            let row = tableData.rowControllerAtIndex(index) as! RowListController
           
                row.taskLabel.setText(reminders[index*3])
                row.taskHour.setText(reminders[index*3+2])
                self.managePriority(reminders[index*3+1],row: row)
            
            self.arrayReminderTitles.append(reminders[index*3])
        }
        
    }
    
    //seta a cor do separator de acordo com a prioridade da task
    func managePriority(prioprity: String, row: RowListController){
        
        switch(prioprity){
        case "0":
            row.separator.setColor(UIColor.whiteColor())
        case "9":
            row.separator.setColor(UIColor.greenColor())
        case "5":
            row.separator.setColor(UIColor.yellowColor())
        case "1":
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
            return self.arrayReminderTitles[rowIndex]
        
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






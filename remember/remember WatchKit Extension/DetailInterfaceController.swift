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


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet var detailLabel: WKInterfaceLabel!
    
    var reminder = EKReminder()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.reminder = (context as? EKReminder)!
        self.detailLabel.setText(reminder.title)
    
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
            
            
//            for index in 0...2{
//                
//                switch(index){
//                case 0:
//                    let attr = [NSFontAttributeName : UIFont(name: "SF-Compact-Text-Semibold", size: 15)!, NSForegroundColorAttributeName: UIColor.greenColor()]
//                    
//                    let atributtedString = NSAttributedString(string: pickerItem.title!, attributes: attr)
//                    pickerItem.title = ("\(atributtedString)")
//                case 1:
//                    let attr = [NSFontAttributeName : UIFont(name: "SF-Compact-Text-Semibold", size: 15)!, NSForegroundColorAttributeName: UIColor.orangeColor()]
//                    let atributtedString = NSAttributedString(string: pickerItem.title!, attributes: attr)
//                    pickerItem.title = ("\(atributtedString)")
//                case 2:
//                    let attr = [NSFontAttributeName : UIFont(name: "SF-Compact-Text-Semibold", size: 15)!, NSForegroundColorAttributeName: UIColor.lightGrayColor()]
//                    let atributtedString = NSAttributedString(string: pickerItem.title!, attributes: attr)
//                    pickerItem.title = ("\(atributtedString)")            default:
//                        print("Deu ruim")
//                }//fim switch
//            
//            
//            }//fim for
    
            return pickerItem
        }//fim map
        
        statusReminders.setItems(pickerItems)
    
    }
}

//
//  DetailInterfaceController.swift
//  remember
//
//  Created by Ludimila da Bela Cruz on 25/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet var detailLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.detailLabel.setText(context as? String)
    
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
    
            return pickerItem
        }
        
        statusReminders.setItems(pickerItems)
    
    }
}

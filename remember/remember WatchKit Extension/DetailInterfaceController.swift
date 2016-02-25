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
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    


    @IBAction func doneTask() {
    }
    
    @IBAction func notDoneTask() {
    }
    
}

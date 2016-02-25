//
//  InterfaceController.swift
//  remember WatchKit Extension
//
//  Created by Ludimila da Bela Cruz on 22/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    
    @IBOutlet var progressCircle: WKInterfaceImage!
    
    
    
    var professionalArray = ["Meeting", "Video Call", "Send Email"]
    var personalArray = ["Eat", "Netfeliz", "Date"]
    var secretArray = ["Impeachment", "Bater panela", "Roubar geladeira"]
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        super.willActivate()
        
        //animated progress circle
        
        self.progressCircle.setImageNamed("redDay")
        self.progressCircle.startAnimatingWithImagesInRange(NSMakeRange(0, 20), duration: 2, repeatCount: 1)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
        
    
//    @IBAction func addProfessionalReminder() {
//    presentControllerWithName("TaskListInterfaceController", context: professionalArray)
//    }
//    
//    @IBAction func addPersonalReminder() {
//          presentControllerWithName("TaskListInterfaceController", context: self.personalArray)
//    }
//    
//    @IBAction func addSecretReminder() {
//          presentControllerWithName("TaskListInterfaceController", context: self.secretArray)
//    }

}

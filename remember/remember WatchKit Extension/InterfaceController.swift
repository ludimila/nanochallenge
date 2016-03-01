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

    @IBOutlet var groupTasks: WKInterfaceGroup!
    @IBOutlet var tasksButton: WKInterfaceButton!
    
    
    var professionalArray = ["Meeting", "Video Call", "Send Email"]
    var personalArray = ["Eat", "Netfeliz", "Date"]
    var secretArray = ["Impeachment", "Bater panela", "Roubar geladeira"]
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
    
    }

    override func willActivate() {
        super.willActivate()
        
        
        self.completedTasks(10)
        self.configureButton()
        self.getDayOfWeek()
        
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    
    func configureButton(){
    
        self.tasksButton.setTitle("Hoje")
        self.tasksButton.setBackgroundColor(UIColor.clearColor())

    }
    
    func completedTasks(numberOfTasks: Int){
        
        if numberOfTasks <= 10 {
            self.groupTasks.setBackgroundImageNamed("greenDay")
            self.groupTasks.startAnimatingWithImagesInRange(NSMakeRange(0, 11), duration: 4, repeatCount: 1)
        }else if numberOfTasks <= 15{
            self.groupTasks.setBackgroundImageNamed("yellowDay")
            self.groupTasks.startAnimatingWithImagesInRange(NSMakeRange(0, 15), duration: 4, repeatCount: 1)
        }else{
            self.groupTasks.setBackgroundImageNamed("redDay")
            self.groupTasks.startAnimatingWithImagesInRange(NSMakeRange(0, 20), duration: 4, repeatCount: 1)
        }
        
    }//fim completedTasks

    
    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        
        if segueIdentifier == "showAll"{
            return self.professionalArray
        }
        return nil
    }
    
    
    func getDayOfWeek(){
        let todayDate = NSDate()
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let convertToString = formatter.stringFromDate(todayDate)
        self.tasksButton.setTitle(convertToString)
        
    }
    
}//fim classe





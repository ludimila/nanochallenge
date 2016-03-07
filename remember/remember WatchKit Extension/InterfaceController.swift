//
//  InterfaceController.swift
//  remember WatchKit Extension
//
//  Created by Ludimila da Bela Cruz on 22/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import Foundation
import EventKit


class InterfaceController: WKInterfaceController {

    @IBOutlet var groupTasks: WKInterfaceGroup!
    @IBOutlet var tasksButton: WKInterfaceButton!
    
    var eventStore = EKEventStore()
    static var reminders: [EKReminder]!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
    
    }

    override func willActivate() {
        super.willActivate()
        
        self.getDayOfWeek()
        self.requestAccessReminder()
        self.configureButton()
        
    }
    

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    //seta o botao como transparente
    func configureButton(){
    
        self.tasksButton.setBackgroundColor(UIColor.clearColor())

    }
    
    
    
    //acessa os lembretes
    func requestAccessReminder(){
        self.eventStore.requestAccessToEntityType(.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                let predicate = self.eventStore.predicateForRemindersInCalendars(nil)
                self.eventStore.fetchRemindersMatchingPredicate(predicate, completion: { (reminders: [EKReminder]?) -> Void in
                    
                   InterfaceController.reminders = reminders
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.getAllTasks(InterfaceController.reminders)
                    }
                })
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }
    }
    
    
    
    //conta o total de lembretes
    func getAllTasks(tasks: [EKReminder]){
        
        var completed = 0
        var notCompleted = 0
        
        for (_, task) in tasks.enumerate(){
            
            
            if task.completed == true {
                completed++
            }else{
                notCompleted++
            }
        }//fim for

        self.completedTasks(completed+notCompleted)
        
    }// fim getalltasks
    
    
    
    //seta a cor de acordo com a quantidade de tarefas do dia
    func completedTasks(numberOfTasks: Int){
        
        if numberOfTasks <= 10 {
            self.groupTasks.setBackgroundImageNamed("greenDay")
            self.groupTasks.startAnimatingWithImagesInRange(NSMakeRange(0, 11), duration: 4, repeatCount: 1)
        }else if numberOfTasks <= 15{
            self.groupTasks.setBackgroundImageNamed("yellowDay")
            self.groupTasks.startAnimatingWithImagesInRange(NSMakeRange(0, 15), duration: 4, repeatCount: 1)
        }else{
            self.groupTasks.setBackgroundImageNamed("redDay")
            self.groupTasks.startAnimatingWithImagesInRange(NSMakeRange(0, 21), duration: 4, repeatCount: 1)
        }
        
    }//fim completedTasks

    
    
    //pega o nome do dia da semana
    func getDayOfWeek(){
        let todayDate = NSDate()
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let convertToString = formatter.stringFromDate(todayDate)
        self.tasksButton.setTitle(convertToString)
        
        
    }
}//fim classe





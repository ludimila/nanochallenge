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
    
    var teste = [EKReminder]()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.myReminders()
    
    
    }

    override func willActivate() {
        super.willActivate()
        
        self.getDayOfWeek()
        
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
    
    
    func myReminders(){
    
    
        let one = EKReminder()
        let two = EKReminder()
        let thre = EKReminder()

        
        one.title = "Comprar banana"
        one.priority = 0
        two.title = "Ligar para a Maria"
        two.priority = 9
        thre.title = "Assistir ao Oscar"
        thre.priority = 5
        
        self.teste.append(one)
        self.teste.append(two)
        self.teste.append(thre)
        
        InterfaceController.reminders = self.teste
    
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





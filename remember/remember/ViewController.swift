//
//  ViewController.swift
//  remember
//
//  Created by Ludimila da Bela Cruz on 22/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit
import EventKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate{

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var prio: UILabel!
    
    
    

    var reminder = EKReminder()
    var eventStore = EKEventStore()
    
    var arrayReminderWatch = [String]()
    
    
    
    //WatchConnectivity
    var session: WCSession!
    var reminderTitle = String()
    var reminderCompletionDate = String()
    var reminderDueDate = String()
    var reminderPriority = String()
    var reminderIdentifier = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupWatchConnectivity()
        session.sendMessage(["a":"Conexão estabelecida"], replyHandler: nil, errorHandler: nil)
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //metodos de conectividade
    
    // Do any additional setup after loading the view, typically from a nib.
    func setupWatchConnectivity() {
        
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
    }
    
    //recebe os dados do watch
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        
        self.arrayReminderWatch = (userInfo["reminder"] as! [String])
        self.reminderTitle = self.arrayReminderWatch.first!
        
        self.eventStore.requestAccessToEntityType(.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                let predicate = self.eventStore.predicateForRemindersInCalendars(nil)
                self.eventStore.fetchRemindersMatchingPredicate(predicate, completion: { (reminders: [EKReminder]?) -> Void in
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.compareReminders(reminders!)
                        
                        
                    }
                })
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")

            }
        }
        
        
        

    }
    
    
    
    
    //compara reminder do watch com reminder do iphone antes de fazer as modificações
    
    func compareReminders(remindersIphone: [EKReminder]){
    
        
        for (_, task) in remindersIphone.enumerate(){
        
            if task.title == self.arrayReminderWatch.first{
                
                self.label.text = (self.reminderTitle)
                self.prio.text = (task.title)
            
                print("Watch:    \(self.arrayReminderWatch[4])")
                print("Iphone:   \(task.calendarItemIdentifier)")
            
            }
        
        }
            

    
    }
    
    
    
}//FIM CLASSE


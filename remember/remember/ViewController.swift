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
    
    var arrayReminderWatch = String()
    
    
    
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
        
        self.requestAccess()
        self.getAllReminders()
        
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
        
        self.arrayReminderWatch = (userInfo["reminder"] as! String)
    }
    
    
    
    func requestAccess(){
        
        self.eventStore.requestAccessToEntityType(.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                print("Deu bom")
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
                
            }
        }
    }
    
    func getAllReminders(){
    
        let predicate = self.eventStore.predicateForRemindersInCalendars(nil)
        self.eventStore.fetchRemindersMatchingPredicate(predicate, completion: { (reminders: [EKReminder]?) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.saveReminder(reminders!)
            }
        })
    }
    
    
    //compara reminder do watch com reminder do iphone antes de fazer as modificações e salva as modificacoes
    
    func saveReminder(remindersIphone: [EKReminder]){
        
    
        for (_, task) in remindersIphone.enumerate(){
        
            if task.title == self.arrayReminderWatch{
                
                task.completionDate = NSDate()
                task.completed = true
                
                do {
                    try self.eventStore.saveReminder(task, commit: true)
                    print("SS")

                }catch{
                    print("Error creating and saving new reminder : \(error)")
                    print("II")

                }
                
            }
        }
    
    }
    
    
    
}//FIM CLASSE


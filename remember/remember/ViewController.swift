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
    
    var reminder = EKReminder()
    var session: WCSession!
    var eventStore = EKEventStore()
    
    var teste = [String]()
    
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


    @IBOutlet weak var prio: UILabel!
    
    //metodos de conectividade
    
    // Do any additional setup after loading the view, typically from a nib.
    func setupWatchConnectivity() {
        
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
    }
    
    
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        
        self.teste = (userInfo["reminder"] as! [String])
        
        self.label.text = self.teste.first
        self.prio.text = self.teste[0]
    }
    
}//FIM CLASSE


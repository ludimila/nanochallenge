//
//  NewReminder.swift
//  remember
//
//  Created by Ludimila da Bela Cruz on 03/03/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import EventKit
import Foundation


class NewReminder: WKInterfaceController {
    
    
    
    @IBOutlet var teste: WKInterfaceLabel!
    
    
    var eventStore = String()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.eventStore = (context as! String)
        
    }
    
    override func willActivate() {
        super.willActivate()
   
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    
    @IBAction func saveReminder() {
        
        presentTextInputControllerWithSuggestions([""], allowedInputMode: .Plain) { (results) -> Void in
            if results != nil{
                let dict = results
                self.teste.setText(dict?.first as? String)
                
                
            }
            
        }
        
    }
    
}

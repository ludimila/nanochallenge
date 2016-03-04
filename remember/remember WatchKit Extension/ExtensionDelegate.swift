//
//  ExtensionDelegate.swift
//  remember WatchKit Extension
//
//  Created by Ludimila da Bela Cruz on 22/02/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {

    func applicationDidFinishLaunching() {
        self.setupWatchConnectivity()
    }

    func applicationDidBecomeActive() {

    }

    func applicationWillResignActive() {

    }
    
    
    private func setupWatchConnectivity() {
        
        if WCSession.isSupported() {
        let session  = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
            
        }
    }
    
}

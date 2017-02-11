//
//  AppDelegate.swift
//  EarthPornWallpaper
//
//  Created by Tibor Leon Hahne on 04/02/2017.
//  Copyright © 2017 Tibor Leon Hahne. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    @IBOutlet weak var menuBar: NSMenu!
    
     let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.title = "EPW"
        statusItem.menu = menuBar
       
        EarthPornWallpaper.start(min: 60);
    }
    @IBAction func pressQuit(_ sender: Any) {
        NSApplication.shared().terminate(self);
    }
    
    @IBAction func pressSettings(_ sender: Any) {
        let popover = NSPopover()
        popover.contentViewController = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        
    }

    func printQuote() {
        
    }
    
    func test(){
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


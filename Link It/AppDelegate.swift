//
//  AppDelegate.swift
//  Link It
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        
        item?.image = NSImage(named: "link")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Link It", action: #selector(AppDelegate.linkIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        
        item?.menu = menu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func linkIt() {
        
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {
                            
                            NSPasteboard.general().clearContents()
                            
                            var actualURL = ""
                            
                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                actualURL = url
        
                            } else {
                                actualURL = "http://" + url
                            }
                            
                            NSPasteboard.general().setString("<a href=\"\(actualURL)\">\(url)</a>", forType: "public.html")
                            
                            NSPasteboard.general().setString(url, forType: "public.utf8-plain-text")
                                
                            
                        }
                    }
                }
            }
        }
        
        printPasteboard()
    }
    
    func printPasteboard() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    print("Type: \(type)")
                    print("String: \(item.string(forType: type))")
                }
            }
        }
    }
    
    func quit() {
        NSApplication.shared().terminate(self)
    }


}


//
//  AppDelegate.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/28.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    
    // 创建状态栏按钮
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    // 监视器
    var eventMonitor: EventMonitor?
    
    let popover = NSPopover()

    // MARK: - App lifecycle
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        
        // 状态栏按钮
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusIcon")
            button.action = #selector(togglePopover(_:))
        }
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
          if let strongSelf = self, strongSelf.popover.isShown {
            strongSelf.closePopover(event!)
          }
        }
        
        popover.contentViewController = PopoverViewController.freshController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    // MARK: - function
    @objc func togglePopover(_ sender: AnyObject) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    // 显示Popover
    @objc func showPopover(_ sender: AnyObject) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
    }
    
    // 隐藏Popover
    @objc func closePopover(_ sender: AnyObject) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }

}


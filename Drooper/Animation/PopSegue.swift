//
//  PopSegue.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/30.
//

import Cocoa

class PopSegue: NSStoryboardSegue {
    
    override func perform() {
        let animator = PopAnimator()
        let sourceVC = self.sourceController as! PopoverViewController
        let destVC = self.destinationController as! AddEventViewController
        sourceVC.present(destVC, animator: animator)
    }
    

}

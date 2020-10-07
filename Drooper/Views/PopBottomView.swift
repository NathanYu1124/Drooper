//
//  PopBottomView.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/29.
//

import Cocoa

class PopBottomView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        self.wantsLayer = true
        self.layer?.backgroundColor = DMPopBottomColor.cgColor
    }
    
}

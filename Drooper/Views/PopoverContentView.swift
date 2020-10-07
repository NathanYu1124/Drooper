//
//  PopoverContentView.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/29.
//

import Cocoa

class PopoverContentView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    // 修改Popover背景颜色(包含箭头)
    override func viewDidMoveToWindow() {
        guard let frameView = window?.contentView?.superview else { return }
        
        let backgroundView = NSView(frame: frameView.bounds)
        backgroundView.wantsLayer = true
        backgroundView.layer?.backgroundColor = DMPopBackColor.cgColor
        backgroundView.autoresizingMask = [.width, .height]
        frameView.addSubview(backgroundView, positioned: .below, relativeTo: frameView)
    }
}

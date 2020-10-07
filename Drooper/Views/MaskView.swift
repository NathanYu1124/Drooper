//
//  MaskView.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/10/1.
//

import Cocoa

class MaskView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    // 阻止子视图的点击事件传到父视图
    override func mouseDown(with event: NSEvent) {
        
        
        self.window?.makeFirstResponder(nil)
    }
    
}

//
//  CollectionViewItem.swift
//  TestCollectionView
//
//  Created by Nathan Yu on 2020/9/29.
//

import Cocoa

protocol CVItemStateProtocal: class {
    func controlStateChanged()
}


class CollectionViewItem: NSCollectionViewItem {
    
    static let reuseIdentifier = NSUserInterfaceItemIdentifier("CollectionViewItemReuseIdentifier")
    
    @IBOutlet weak var iconView: NSImageView!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var controlButton: NSButton!
    
    // Popover主界面Timer Label引用
    weak var mainTimerLabel: NSTextField!
    
    var event: EventModel = EventModel(name: "事项", type: ("娱乐", "game_white"), music: ("舒缓", "accordion_white"), time: ("0", "0", "59"))
    
    weak var delegate: CVItemStateProtocal?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.cornerRadius = CVItemCornerRadius
        view.layer?.backgroundColor = DMPopItemGray.cgColor
        iconView.image = NSImage(named: event.eventType.image)
        titleLabel.stringValue = event.eventName
        timeLabel.stringValue = String(format: "%.2d:%.2d:%.2d",0,0,59)
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? changeItemToSelectedState() : changeItemToDefaultState()
        }
    }
    
    //
    @IBAction func changeEventState(_ sender: Any) {
        
        // MARK: TODO - 开始倒计时测试
        print(event.seconds)
        DPTimer.share.startTimer(seconds: event.seconds, eventModel: event, timerLabel: timeLabel, mainLabel: mainTimerLabel)
        
    }
    
    // 设置选中样式
    func changeItemToSelectedState() {
        
        self.view.layer?.backgroundColor = DMPopLightWhite.cgColor
        let imgStr = event.eventType.image
        let endIndex = imgStr.index(imgStr.endIndex, offsetBy: -6)
        let iconStr = String(imgStr[imgStr.startIndex..<endIndex])
        
        iconView.image = NSImage(named: iconStr)
        titleLabel.textColor = NSColor.black
        timeLabel.textColor = DMPopItemGray
    }
    
    // 设置默认样式
    func changeItemToDefaultState() {
        
        self.view.layer?.backgroundColor = DMPopItemGray.cgColor
        iconView.image = NSImage(named: event.eventType.image)
        titleLabel.textColor = DMPopLightWhite
        timeLabel.textColor = DMPopLightWhite
    }
    
}

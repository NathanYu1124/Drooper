//
//  AddEventViewController.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/30.
//

import Cocoa


protocol PopEventProtocal: class {
    func saveAndBackToPop(model: EventModel)
}

class AddEventViewController: NSViewController {

    @IBOutlet weak var contentView: NSView!
    @IBOutlet weak var topOvalView: NSView!
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var typeLeftView: NSView!
    @IBOutlet weak var typeRightView: NSView!
    @IBOutlet weak var musicLeftView: NSView!
    @IBOutlet weak var musicRightView: NSView!
    @IBOutlet weak var timeAreaView: NSView!
    @IBOutlet weak var hourTextField: NSTextField!
    @IBOutlet weak var minuteTextField: NSTextField!
    @IBOutlet weak var secondTextField: NSTextField!
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var typeImageView: NSImageView!
    @IBOutlet weak var musicImageView: NSImageView!
    @IBOutlet weak var typeNextButton: NSButton!
    @IBOutlet weak var typePreButton: NSButton!
    @IBOutlet weak var musicNextButton: NSButton!
    @IBOutlet weak var musicPreButton: NSButton!
    @IBOutlet weak var typeLabel: NSTextField!
    @IBOutlet weak var musicLabel: NSTextField!
    
    
    let eventTypes = [(type:"娱乐", image:"game_white"), (type:"工作", image:"working_white"), (type:"休息", image:"tea_white")]
    let musicTypes = [(type:"舒缓", image:"accordion_white"), (type:"悠扬", image:"guitar_white"), (type:"热烈", image:"drums_white")]
    var currTypeIndex = 0
    var currMusicIndex = 0
    let hourDefaultVal = "1"
    let minuteDefaultVal = "1"
    let secondDefaultVal = "1"
    var hour = "1"
    var minute = "1"
    var second = "1"
    
    weak var delegate: PopEventProtocal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        typePreButton.isEnabled = false
        musicPreButton.isEnabled = false
        typeImageView.image = NSImage(named: eventTypes[currTypeIndex].image)
        musicImageView.image = NSImage(named: musicTypes[currMusicIndex].image)
        
        self.view.wantsLayer = true
        self.view.layer?.cornerRadius = 10
        self.view.layer?.backgroundColor = DMPopLightWhite.cgColor
        
        self.contentView.wantsLayer = true
        self.contentView.layer?.cornerRadius = 15
        self.contentView.layer?.backgroundColor = DMPopBottomColor.cgColor
        
        topOvalView.wantsLayer = true
        topOvalView.layer?.backgroundColor = DMPopItemGray.cgColor
        topOvalView.layer?.cornerRadius = topOvalView.frame.height / 2
        
        nameTextField.resignFirstResponder()
        let attrDict = [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 30),
                        NSAttributedString.Key.foregroundColor: DMSeperatorGray]
        let attStr = NSAttributedString(string: "输入名称...", attributes: attrDict)
        nameTextField.placeholderAttributedString = attStr
        
        hourTextField.stringValue = hourDefaultVal
        minuteTextField.stringValue = minuteDefaultVal
        secondTextField.stringValue = secondDefaultVal
      
        typeLeftView.wantsLayer = true
        typeLeftView.layer?.cornerRadius = typeLeftView.frame.width / 2
        typeLeftView.layer?.backgroundColor = DMSeperatorGray.cgColor
        
        typeRightView.wantsLayer = true
        typeRightView.layer?.cornerRadius = typeRightView.frame.width / 2
        typeRightView.layer?.backgroundColor = DMSeperatorGray.cgColor
        
        musicLeftView.wantsLayer = true
        musicLeftView.layer?.cornerRadius = musicLeftView.frame.width / 2
        musicLeftView.layer?.backgroundColor = DMSeperatorGray.cgColor
        
        musicRightView.wantsLayer = true
        musicRightView.layer?.cornerRadius = musicRightView.frame.width / 2
        musicRightView.layer?.backgroundColor = DMSeperatorGray.cgColor
        
        timeAreaView.wantsLayer = true
        timeAreaView.layer?.cornerRadius = timeAreaView.frame.height / 2
        timeAreaView.layer?.backgroundColor = DMPopItemGray.cgColor
    }
    
    @IBAction func dismissAddView(_ sender: Any) {
        
        self.presentingViewController?.dismiss(self)
    }
    
    // 保存模型并退出
    @IBAction func backToPopView(sender: Any) {
        
        // 生成新的模型
        let name = nameTextField.stringValue
        let type = eventTypes[currTypeIndex]
        let music = musicTypes[currMusicIndex]
        let time = (hourTextField.stringValue, minuteTextField.stringValue, secondTextField.stringValue)
        let model = EventModel(name: name, type: type, music: music, time: time)
        
        delegate?.saveAndBackToPop(model: model)
        self.presentingViewController?.dismiss(self)
    }
    
    
    @IBAction func chooseNextType(_ sender: NSButton) {
        if currTypeIndex < eventTypes.count {
            currTypeIndex += 1
            typeImageView.image = NSImage(named: eventTypes[currTypeIndex].image)
            typeLabel.stringValue = eventTypes[currTypeIndex].type
            
            if typePreButton.isEnabled == false {
                typePreButton.isEnabled = true
            }
            
            if currTypeIndex == eventTypes.count - 1 {
                typeNextButton.isEnabled = false
            }
        }
    }
    
    @IBAction func choosePreType(_ sender: NSButton) {
        if currTypeIndex > 0 {
            currTypeIndex -= 1
            typeImageView.image = NSImage(named: eventTypes[currTypeIndex].image)
            typeLabel.stringValue = eventTypes[currTypeIndex].type
            
            if typeNextButton.isEnabled == false {
                typeNextButton.isEnabled = true
            }
            
            if currTypeIndex == 0 {
                typePreButton.isEnabled = false
            }
        }
    }
    
    @IBAction func chooseNextMusic(_ sender: NSButton) {
        if currMusicIndex < musicTypes.count {
            currMusicIndex += 1
            musicImageView.image = NSImage(named: musicTypes[currMusicIndex].image)
            musicLabel.stringValue = musicTypes[currMusicIndex].type
            
            if musicPreButton.isEnabled == false {
                musicPreButton.isEnabled = true
            }
            
            if currMusicIndex == musicTypes.count - 1 {
                musicNextButton.isEnabled = false
            }
        }
    }
    
    @IBAction func choosePreMusic(_ sender: NSButton) {
        if currMusicIndex > 0 {
            currMusicIndex -= 1
            musicImageView.image = NSImage(named: musicTypes[currMusicIndex].image)
            musicLabel.stringValue = musicTypes[currMusicIndex].type
            
            if musicNextButton.isEnabled == false {
                musicNextButton.isEnabled = true
            }
            
            if currMusicIndex == 0 {
                musicPreButton.isEnabled = false
            }
        }
    }
}

// MARK: - NSTextFieldDelegate
extension AddEventViewController: NSTextFieldDelegate {

    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            
            if textField.identifier == nameTextField.identifier {
                saveButton.isEnabled = (textField.stringValue.isEmpty) ? false : true
            }
            
            print(textField.stringValue)
        }
    }
    
    func controlTextDidEndEditing(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            
            if textField.identifier == hourTextField.identifier {
                if textField.stringValue.isEmpty {
                    textField.stringValue = hourDefaultVal
                }
                hour = textField.stringValue
            }
            
            if textField.identifier == minuteTextField.identifier {
                if textField.stringValue.isEmpty {
                    textField.stringValue = minuteDefaultVal
                }
                minute = textField.stringValue
            }
            
            if textField.identifier == secondTextField.identifier {
                if textField.stringValue.isEmpty {
                    textField.stringValue = secondDefaultVal
                }
                second = textField.stringValue
            }
            
            print("hour: " + hour + " minute: " + minute + " second: " + second)
            
            // 全0则时间修改为默认值
            if hour == "0" && minute == "0" && second == "0" {
                hourTextField.stringValue = hourDefaultVal
                minuteTextField.stringValue = minuteDefaultVal
                secondTextField.stringValue = secondDefaultVal
                
                // 恢复初始值
                hour = hourDefaultVal
                minute = minuteDefaultVal
                second = secondDefaultVal
            }
        }
    }
}

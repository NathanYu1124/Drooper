//
//  PopoverViewController.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/28.
//

import Cocoa


class PopoverViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var ovalView: NSView!
    @IBOutlet weak var seperatorLine: NSView!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var timerLabel: NSTextField!
    
    
    let itemsPerRow = 2

    var eventDays = [[EventModel]]()
    private var events = [EventModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ovalView.wantsLayer = true
        ovalView.layer?.cornerRadius = 15
        ovalView.layer?.backgroundColor = DMPopItemGray.cgColor
        
        seperatorLine.wantsLayer = true
        seperatorLine.layer?.backgroundColor = DMSeperatorGray.cgColor
        
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = DMColBackColor.cgColor
        collectionView.register(CollectionViewItem.self, forItemWithIdentifier: CollectionViewItem.reuseIdentifier)
        collectionView.collectionViewLayout = flowLayout()
    }

    
    @IBAction func exitApplication(_ sender: Any) {
        exit(0)
    }
    
    
    // Flow 
    private func flowLayout() -> NSCollectionViewLayout {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: CVItemWidth, height: CVItemHeight)
        flowLayout.sectionInset = NSEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        return flowLayout
    }
    
}

// MARK: - extension
extension PopoverViewController {
    static func freshController() -> PopoverViewController {
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let id = NSStoryboard.SceneIdentifier("PopoverVC")
        guard let popVC = storyboard.instantiateController(withIdentifier: id) as? PopoverViewController else {
            fatalError("Something Wrong with Main.storyboard")
        }
        
        return popVC
    }
    
    // Segue
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "PopSegueID" {
            let addVC = segue.destinationController as! AddEventViewController
            addVC.delegate = self
        }
    }
}

// MARK: - CollectionView dataSource
extension PopoverViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: CollectionViewItem.reuseIdentifier, for: indexPath) as! CollectionViewItem
        item.mainTimerLabel = timerLabel
                
        return item
    }
    
    // 分区头部视图
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier("HeaderView"), for: indexPath) as! HeaderView
        
        return view
    }
    
    // 选中item
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        let selectedItem = collectionView.item(at: indexPaths.first!) as! CollectionViewItem
        
        // 暂停之前的倒计时
        
        // 开始新的倒计时
        print(indexPaths)

        timerLabel.stringValue = selectedItem.timeLabel.stringValue
    }
}

// MARK: - CollectionView layout
extension PopoverViewController: NSCollectionViewDelegateFlowLayout {
    
    
    // 分区头部视图Size
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: 350, height: 20)
    }
}

// MARK: - PopEventProtocal
extension PopoverViewController: PopEventProtocal {
    // 更新模型及界面数据
    func saveAndBackToPop(model: EventModel) {
        
    }
}

// MARK: - CVItemStateProtocal
extension PopoverViewController: CVItemStateProtocal {
    // 
    func controlStateChanged() {
        
    }
}








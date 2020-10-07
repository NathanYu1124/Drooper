//
//  DPTimer.swift
//  Drooper
//
//  Created by Nathan Yu on 2020/9/28.
//

import Foundation
import Cocoa

// GCD定时器
class DPTimer {
    
    // 开始, 暂停, 继续, 结束
    
    private var timeCount = 5
    private var gcdTimer: DispatchSourceTimer?
    static let share = DPTimer()
    
    
    // 启动Timer
    func startTimer(seconds: Int, eventModel: EventModel, timerLabel: NSTextField, mainLabel: NSTextField) {
        print("\(Date()): GCD 方式的定时器，循环")
        if seconds <= 0 { return }
        print("开始倒计时!")
        
        self.timeCount = seconds
        gcdTimer = DispatchSource.makeTimerSource()
        gcdTimer?.setEventHandler() {
            if self.timeCount <= 0 {
                self.gcdTimer?.cancel()
                return
            }
            self.timeCount -= 1
            print("\(Date()): 倒计时 \(self.timeCount) 秒")
            // 主线程刷新UI
            eventModel.seconds = self.timeCount
            DispatchQueue.main.async {
                timerLabel.stringValue = String(format: "%.2d:%.2d:%.2d", self.timeCount / 3600, self.timeCount % 3600 / 60, self.timeCount % 3600 % 60)
                
                mainLabel.stringValue = String(format: "%.2d:%.2d:%.2d", self.timeCount / 3600, self.timeCount % 3600 / 60, self.timeCount % 3600 % 60)
            }
        }
        gcdTimer?.setCancelHandler() {
            // 更新UI
            print("\(Date()): 倒计时结束！")
        }
        gcdTimer?.schedule(deadline: .now() + .seconds(1), repeating: .seconds(1))
        gcdTimer?.resume()
    }
    
    // 暂停Timer
    func pauseTimer() {
        gcdTimer?.suspend()
    }
    
    // 继续Timer
    func resumeTimer() {
        gcdTimer?.resume()
    }
    
    // 终止Timer
    func stopTimer() {
        gcdTimer?.cancel()
        gcdTimer = nil
    }
}

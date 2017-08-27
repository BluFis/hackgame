//
//  ChoiceRecognize.swift
//  hackgame
//
//  Created by Apple on 2017/8/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import MagicalRecord

class ChoiceRecognize {
    
    let password = ["Password","admin","NotHere"]
    
    var tryTimes = 0
    
    var timeSpent = 0
    
    var score = 0
    
    func result(str:String?,index:Int) -> Bool{
        
        if str == password[index]{
            let level = LEVELS.mr_createEntity()! as LEVELS
            level.get = true
            level.level = Int16(index + 1)
            level.timeSpend = beautifulTime(a: timeSpent)
            level.tryTimes = Int16(tryTimes)
            level.score = Int32(makeScore())
            level.managedObjectContext?.mr_saveToPersistentStoreAndWait()
            let user = USER.mr_findAll()?[0] as! USER
            user.level = Int16(index) + 1
            user.timeSpend = addTime(t1: user.timeSpend!, t2: timeSpent)
            user.totalScore += Int32(score)
            user.totalTry += Int16(tryTimes)
            user.managedObjectContext?.mr_saveToPersistentStoreAndWait()
            return true
            
            
        }else{
            tryTimes += 1
            return false
        }

    }
    private func addTime(t1:String,t2:Int) -> String{
        
        let t3 = NSString(string: t1.replacingOccurrences(of: ":", with: ""))
        let t4 = Int(t3.intValue / 100 * 60 + t3.intValue % 100) + t2
        return beautifulTime(a:t4)

    }
    private func makeScore()->Int{
        
        
        return 240 - timeSpent + (50 - tryTimes) * 30
        
        
    }
    func beautifulTime(a:Int)->String{
        var returnString = "00:00"
        if a / 60 < 10{
            if a % 60 < 10{
                returnString = "0" + String(a / 10) + ":0" + String(a % 10)
            }else{
                returnString = "0" + String(a / 10) + ":" + String(a % 10)
            }
        }else if a % 60 < 10{
            returnString =  String(a / 10) + ":0" + String(a % 10)
        }else{
            returnString =  String(a / 10) + ":" + String(a % 10)
        }
        return returnString
    }
}



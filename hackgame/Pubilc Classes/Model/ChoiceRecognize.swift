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
    
    var timeSpent = "00:00"
    
    var score = 0
    
    func result(str:String?,index:Int) -> Bool{
        
        if str == password[index]{
            
            
            
            return true
            
            
        }else{
            tryTimes += 1
            return false
        }

    }

}



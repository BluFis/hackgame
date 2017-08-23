//
//  ChoiceRecognize.swift
//  hackgame
//
//  Created by Apple on 2017/8/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
class ChoiceRecognize {
    
    let password = ["Password","admin","NotHere"]
    
    func result(str:String?,index:Int) -> Bool{
        
        if str == password[index]{
            
            
            
            return true
            
            
        }else{
            
            return false
        }

    }

}



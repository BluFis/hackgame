//
//  PrepareForGame.swift
//  hackgame
//
//  Created by Apple on 2017/8/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import Alamofire
import MagicalRecord

class PrepareForGame {
    
    
    
    
 private   func checkLevel()->Bool{
       let count = LEVELS.mr_findAll()?.count
    
        if let countNub = count{
            
            if countNub > 0 {
                return true
            }
        }
        return false
    }
    
    func getProfile()->[String:Any]{
         let user = USER.mr_findAll()?[0] as! USER
        
         if checkLevel(){
         return["username":user.username!,"email":user.email!,"level":user.level,"lastLogin":user.lastLogin!,"totalTime":user.timeSpend!,"totalTry":user.totalTry,"totalScore":user.totalScore]
           
        }else{
            return["username":user.username!,"email":user.email!,"level":0,"lastLogin":user.lastLogin!,"totalTime":"00:00","totalTry":0,"totalScore":0]
        }
        
    }

}

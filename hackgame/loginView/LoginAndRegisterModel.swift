//
//  LoginAndRegisterModel.swift
//  hackgame
//
//  Created by Apple on 2017/8/25.
//  Copyright © 2017年 Apple. All rights reserved.
//

import Foundation
import MagicalRecord
import Alamofire
class checkLogin {
    func checkResult(_ username:String?,_ email:String?,_ password:String?, _ comformPass:String?,_ completionHandler: @escaping (String)->Void){
 
        if let usn = username{
            if let eml = email{
                if let psw = password{
                    if let compsw = comformPass{
                        if compsw == psw{
                            let url:String = "http://localhost/website/register.php"
                            let body = ["username":usn,"email":eml,"password":psw]
                            Alamofire.request(url.urlEncoded(),method:.post,parameters: body, encoding: URLEncoding.httpBody).responseJSON { response in
                                if let value = response.data{
                                    let json = JSON(value)
                                    print(json)
                                    if let Valve = json["error"].bool{
                                        if Valve == true{
                                            if let errMsg = json["err_msg"].string{
                                                completionHandler(errMsg)
                                            }
                                            
                                        }else{
                                            self.updateData(usn, psw, eml)
                                            completionHandler("Success")
                                            print("seccess")
                                        }
                                        
                                    }
                                }else{
                                    completionHandler("Internet connection error")
                                }
                                
                            }
                        }else{
                            completionHandler("Two passwords are diffent")
                        }
                    }else{
                        completionHandler("empty comfirmPassword")
                    }
                }else{
                    completionHandler("empty password")
                }
            }else{
                completionHandler("empty email")
            }
        }else{
            completionHandler("empty email")
        }
        
        
        
        
        

 
}
    private func updateData(_ username:String,_ password:String,_ email:String){
        
        let UserCount = USER.mr_findAll()!.count
        
        if UserCount  > 0 {
            let user = USER.mr_findAll()![0] as! USER
            user.username = username
            user.password = password
            user.email = email
            user.lastLogin = self.currentTime()
            user.managedObjectContext?.mr_saveToPersistentStoreAndWait()
        }else{
            let user = USER.mr_createEntity()! as USER
            user.username = username
            user.password = password
            user.email = email
            user.lastLogin = self.currentTime()
            user.managedObjectContext?.mr_saveToPersistentStoreAndWait()
            
        }
    }
    func login(_ email:String?,_ password:String?, _ completionHandler: @escaping (String)->Void){
        if let emailcheck = email{
            if let passwordcheck = password{
                let url:String = "http://localhost/website/login.php"
                let body = ["email":emailcheck,"password":passwordcheck]
                Alamofire.request(url.urlEncoded(),method:.post,parameters: body, encoding: URLEncoding.httpBody).responseJSON { (response) in
                    if let value = response.data{
                        let json = JSON(value)
                        if let Value = json["error"].bool{
                            if Value == true{
                                if let errMsg = json["err_msg"].string{
                                    print(errMsg)
                                    completionHandler(errMsg)
                                }
                            }else{
                                let user = USER.mr_findAll()![0] as! USER
                                user.lastLogin = self.currentTime()
                                user.managedObjectContext?.mr_saveToPersistentStoreAndWait()
                                completionHandler("Success")
                            }
                        }
                    }else{
                        completionHandler("Internet connection error")
                    }
                }
            }else{
                completionHandler("empty password")
            }
        }else{
            completionHandler("empty email")
        }
   
        
    }
    
    
private func currentTime()->String{
    let now = Date()
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
    return dformatter.string(from: now)
    
}


}

extension String {
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
}
}

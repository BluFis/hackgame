//
//  LoginAndRegister.swift
//  hackgame
//
//  Created by Apple on 2017/8/25.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import MagicalRecord


class Register: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    let checkModel = checkLogin()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let count = USER.mr_findAll()?.count
        if count != nil && count! > 0{
            let user = USER.mr_findAll()?[0] as! USER
            checkModel.login(user.email, user.password) { (result) in
                if result == "Success"{
                    self.goToMainVC()
                }else{
                    DispatchQueue.main.async {
                        self.performMessage(str: result)
                    }
                    
                }
        }
 
        }
    }
    
    func performMessage(str:String){
        
        let messageLabel = UILabel(frame: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width: self.view.frame.width, height: 80)))
        messageLabel.backgroundColor = UIColor.red
        messageLabel.font = UIFont(name: "Menlo", size: 20.0)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 0))
        print(messageLabel.layer.anchorPoint)
        messageLabel.layer.anchorPoint = CGPoint(x: 0.5 ,y: 0)
        self.view.addSubview(messageLabel)
        UIView.animate(withDuration: 0.5, animations: {
            messageLabel.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
        }) { (true) in
            messageLabel.text = str
            UIView.animate(withDuration: 1.5, delay: 0.5, animations: {
                messageLabel.alpha = 0
            }){(true) in
                messageLabel.removeFromSuperview()
            }
        }
    }
    
    
    func goToMainVC(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainVC = storyboard.instantiateViewController(withIdentifier: "Main") as! Main
        let appDelet = UIApplication.shared.delegate as! AppDelegate
        appDelet.window?.rootViewController = MainVC
        
        
    }
    
    @IBAction func check(_ sender: Button) {
        checkModel.checkResult(username.text, email.text, password.text, confirmPassword.text) { (result) in
            if result == "Success"{
                self.goToMainVC()
            }else{
                
                DispatchQueue.main.async {
                    self.performMessage(str: result)
                }
                
            }
            
            
        }
        
    }
    

}


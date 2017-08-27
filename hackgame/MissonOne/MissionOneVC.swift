//
//  MissionOneVC.swift
//  hackgame
//
//  Created by Apple on 2017/8/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class MissionOneVC: UIViewController {
    let result = ChoiceRecognize()
    @IBOutlet weak var button: Button!
    @IBOutlet weak var textfield: UITextField!
  
    @IBOutlet weak var tryTimes: UILabel!
    
    @IBOutlet weak var timeSpeet: UILabel!
    var time:Timer!
    var a = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    @objc func update(){
        a += 1
        timeSpeet.text = "timeSpent : " + result.beautifulTime(a: a)
        result.timeSpent = a
    }
    

    
    @IBAction func submitBtn(_ sender: Button) {
        
        if result.result(str: textfield.text, index: 0){
            
            let storyboard = UIStoryboard(name: "MissionTwo", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "MissionTwo") as! MissionTwoVC
            self.present(nextVC, animated: true, completion: nil)
    
            
        }else{
            self.tryTimes.text = "tryTimes : " + String(result.tryTimes)
            self.button.shakeButton(true)
            textfield.text = nil
        }
        
    }
    
  

}

//
//  MissionOneVC.swift
//  hackgame
//
//  Created by Apple on 2017/8/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
let result = ChoiceRecognize()
class MissionOneVC: UIViewController {

    @IBOutlet weak var button: Button!
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func submitBtn(_ sender: Button) {
        
        if result.result(str: textfield.text, index: 0){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.button.shakeButton(true)
            textfield.text = nil
        }
        
    }
    
  

}

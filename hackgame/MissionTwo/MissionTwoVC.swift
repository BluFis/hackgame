//
//  MissionTwoVC.swift
//  hackgame
//
//  Created by Apple on 2017/8/22.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class MissionTwoVC: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    var result = ChoiceRecognize()
    @IBOutlet weak var button: Button!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func passwordBtn(_ sender: Button) {
        
        if result.result(str:textfield.text, index: 1){
            self.dismiss(animated: true, completion: nil)
        }else{
        button.shakeButton(true)
        }
        
        
    }
    
}

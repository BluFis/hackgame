//
//  Button.swift
//  OcRcaculator
//
//  Created by Apple on 2017/8/13.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
@IBDesignable
class Button: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    func shakeButton(_ :Bool){
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.frame = CGRect(origin: CGPoint(x:self.frame.origin.x - 20,y:self.frame.origin.y), size: self.frame.size)
            }) { (true) in
                UIView.animate(withDuration: 0.3, animations: {
                     self.frame = CGRect(origin: CGPoint(x:self.frame.origin.x + 20,y:self.frame.origin.y), size: self.frame.size)
                })
            }
        }

    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
}

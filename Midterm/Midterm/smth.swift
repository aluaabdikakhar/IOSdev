//
//  smth.swift
//  Midterm
//
//  Created by apple on 3/7/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

import UIKit

class smth: UIViewController{
    var onSelect: ((UIColor) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func button(_ sender: UIButton) {
        if sender.titleLabel?.text == "RED" {
            self.onSelect?(UIColor.red)
        }
        else {
            self.onSelect?(UIColor.blue)
        }
        self.dismiss(animated: true)
    }
    
    
    
}

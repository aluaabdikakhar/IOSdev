//
//  ViewController.swift
//  Midterm
//
//  Created by apple on 3/7/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func knopka(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateInitialViewController(identifier: "select") as? smth
            else{return}
        selectVC.onSelect = { [weak self] color in
            guard self != nnil else {return}
            sender.backgroundColor = color
        }
        self.present(selectVC, animated: true)
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
  


}


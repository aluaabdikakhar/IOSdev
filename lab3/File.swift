//
//  File.swift
//  lab3
//
//  Created by apple on 3/8/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

class File: UIViewController {
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    var color: UIColor?
    var tapped:UIView?
    let screen = UIScreen.main.bounds
    
    
    @IBOutlet weak var width: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var X: UITextField!
    
    @IBOutlet weak var Y: UITextField!
    
    @IBOutlet var knopki: [UIButton]!
    
    
    @IBAction func nazhatie(_ sender: UIButton) {
        for button in knopki{
            if button == sender{
                button.isSelected = true
                color = sender.backgroundColor
            }
            else{
                button.isSelected = false
        }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            buttonsAppear()
            data()
        }
        //add
        var addPage: ((_ width: Double, _ height: Double, _ x: Double, _ y: Double, _ color: UIColor) -> Void)? = nil
        //delete
        @objc func deleteButton() {
            guard let rect = tapped else {return}
            rect.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
        }
        //add
        @objc func addButton() {
            //check input's correctness
            guard let widthFloat = Double(width.text!),let xFloat = Double(X.text!), let yFloat = Double(Y.text!), let heightFloat = Double(height.text!), let color = color else {
                let alert = UIAlertController(title: "Ошибка", message: "Некоторые поля не заполнены или введен неправильный формат", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            if widthFloat == 0 || heightFloat == 0 {
                let alert = UIAlertController(title: "Ошибка", message: "Высота и длина не могут быть 0", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            if (CGFloat(xFloat+widthFloat) > screen.width) || (CGFloat(yFloat+heightFloat) > screen.height-90) {
                let alert = UIAlertController(title: "Ошибка", message: "Данные не правильные", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            guard let rect = tapped else {
                addPage?(widthFloat, heightFloat, xFloat, yFloat, color)
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            rect.backgroundColor = color
            rect.frame = CGRect(x: CGFloat(xFloat), y: CGFloat(yFloat), width: CGFloat(widthFloat), height: CGFloat(heightFloat))
            
            self.navigationController?.popViewController(animated: true)
        }
        //save
        @objc func saveButton() {
            //check
            if Double(width.text!)==0.0 || Double(height.text!)==0.0 {
                let alert = UIAlertController(title: "Ошибка", message: "Высота и длина не могут быть 0", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            if width.text!.isEmpty || X.text!.isEmpty || height.text!.isEmpty || Y.text!.isEmpty{
                let alert = UIAlertController(title: "Ошибка", message: "Присутсвуют не заполненные ячейки", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            guard let widthFloat = Double(width.text!),let xFloat = Double(X.text!), let yFloat = Double(Y.text!), let heightFloat = Double(height.text!), let colour = color else {
                let alert = UIAlertController(title: "Ошибка", message: "Данные не изменены", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            if (CGFloat(xFloat+widthFloat) > screen.width) || (CGFloat(yFloat+heightFloat) > screen.height-90) {
                let alert = UIAlertController(title: "Ошибка", message: "Данные не правильные", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            guard let rect = tapped else {
                addPage?(widthFloat, heightFloat, xFloat, yFloat, colour)
                self.navigationController?.popViewController(animated: true)
                return
            }
            
            rect.backgroundColor = color
            rect.frame = CGRect(x: CGFloat(xFloat), y: CGFloat(yFloat), width: CGFloat(widthFloat), height: CGFloat(heightFloat))
            
            self.navigationController?.popViewController(animated: true)
        }
        func buttonsAppear() {
            let buttonDelete = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deleteButton))
            let buttonSave = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveButton))
            let buttonAdd = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addButton))
            
            guard let rect = tapped else {
                 navigationItem.rightBarButtonItems = [buttonAdd]
                return
            }
            navigationItem.rightBarButtonItems = [buttonDelete, buttonSave]
        }
        func data(){
            guard let rect = tapped else {return}
            
            self.width.text = rect.frame.width.description
            self.height.text = rect.frame.height.description
            self.X.text = rect.frame.origin.x.description
            self.Y.text = rect.frame.origin.y.description
            self.color = rect.backgroundColor
            knopki.forEach {(button) in
                if button.backgroundColor == rect.backgroundColor {
                    button.isSelected = true
                } else {
                    button.isSelected = false
                }
            }
        }
    }





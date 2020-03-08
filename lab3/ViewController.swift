//
//  ViewController.swift
//  lab3
//
//  Created by Elnara  on 2/29/20.
//  Copyright © 2020 Elnara . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var origin: CGPoint!
    var screen = UIScreen.main.bounds
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //to open options view controller
    @IBAction func options(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "File") as File
        
        vc.addPage = { [weak self] width, height, x, y, color in
            guard let self = self else { return }
            
            let rect = UIView(frame: CGRect(x: x, y: y+90, width: width, height: height))
            rect.backgroundColor = color
            self.view.addSubview(rect)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
            rect.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(_:)))
            rect.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchAction(_:)))
            rect.addGestureRecognizer(pinchGestureRecognizer)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    //для открытия страницы редактирования
    @objc func tapAction(_ gestureRecognizer: UITapGestureRecognizer) {
        if let rect = gestureRecognizer.view {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "File") as File
            vc.tapped = rect
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    //для передвижения
    @objc func panAction(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let rect = gestureRecognizer.view else {
            return
        }
        switch gestureRecognizer.state {
        case .began:
            origin = rect.frame.origin
        case .changed:
            let d = gestureRecognizer.translation(in: rect)
            rect.frame.origin.x = origin.x + d.x
            rect.frame.origin.y = origin.y + d.y
            if (rect.frame.origin.x<=0){
                rect.frame.origin.x = 0
            }else if ((rect.frame.origin.x + rect.frame.width)>=screen.width){
                rect.frame.origin.x = screen.width - rect.frame.width
            }else if (rect.frame.origin.y<=90){
                rect.frame.origin.y = 90
            }else if ((rect.frame.origin.y + rect.frame.height)>=screen.height){
                rect.frame.origin.y = screen.height - rect.frame.height
            }
        default: break
        }
    }
    //для изменения размера
    @objc func pinchAction(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if let rect = gestureRecognizer.view {
            if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
                rect.transform = (rect.transform.scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))
                gestureRecognizer.scale = 1
            }
        }
    }
}


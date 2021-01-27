//
//  ViewController.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/1/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        let a = 20
        let b = 33.7
        let c = a + Int(b)
        let d = Double(a) + b
        
        print("c = \(c)")
        print("d = \(d)")

    }


}


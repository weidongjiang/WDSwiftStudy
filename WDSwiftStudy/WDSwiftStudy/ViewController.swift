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

        demo1()
        demo2()
    }
    
    // MARK: - view
    func demo1() {
        let view1 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view1.backgroundColor = UIColor.red
        view.addSubview(view1)
       
        let btn = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        btn.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        btn.addTarget(self, action: #selector(btnDidClick), for: UIControl.Event.touchUpInside)
        view.addSubview(btn)
    }
    @objc func btnDidClick() {
        print("来玩swift")
    }
    
    // MARK: - 元组
    //元组可以吧多个值组合成一个复合值.元组内的数据可以是任意类型的,重点:不要求元素的类型相同
    //不想接收值,直接用下划线_代替
    //可以使用标签,类似于字典
    func demo2() {
        let jwd = (30,"jwd",180)
        print(jwd.0,jwd.1,jwd.2)
        
        let (age,name,hight) = jwd
        print(age,name,hight)
        
        let xll = (age:30,name:"xll")
        print(xll.age,xll.name)
        
    }
    
    
}


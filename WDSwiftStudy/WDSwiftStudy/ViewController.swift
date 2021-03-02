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
        demo3()
        demo4(a: 22)
        demo5()
    }
    
    // MARK: - 循环
    func demo5() {
        
        var num = 50
        while num > 0 {
            print(num)
            num -= 1
        }
        
        //repeat-while相当于OC中的do-while
        var re = -5
        repeat {
            re = re + 1
            print("repeat",re)
        }while (re < 0);
       
        
        // for循环
        let range = 0...10// 0-10包含0和10
        for i in range {
            print("for in range",i)
        }
        
        for j in 0...10 {
            print("for in 0...10",j)
        }
        
        for j in 0..<10 {// 遍历 不包含10
            print("for in 0..<10",j)
        }
        
        for _ in 0..<10 {// 遍历 不包含10，不使用遍历的index的时候可以使用 _ 代替
            print("for in 0..<10 😁")
        }
    
        // 遍历数组元素 元素类型可以不一致，最好保持一致的类型
        let keys = ["a","b","c","d","e","f","j",1] as [Any]
        for key in keys {
            print("keys",key)
        }
        // 按照区间去遍历
        for key in keys[0...3] {
            print("keys[0...3]",key)
        }
        print("--------------")
        for key in keys[0..<3] {
            print("keys[0..<3]",key)
        }
        print("--------------")
        for key in keys[2...6] {//
            print("keys[2...6]",key)
        }
        print("--------------")
//        for key in keys[2...10] {//Array index is out of range: file Swift/Array.swift 越界
//            print("keys[2...6]",key)
//        }
        
        for i in 0...10 {
            if i == 2 {
                print("continue")
                continue
            }
            if i > 8 {
                print("break")
                break
            }
            print("continue break",i)
        }
        
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
    
    // MARK: - 可选类型
//    可选类型有可能有值,也有可能为nil
//    let声明可选类型是没有意义的
//    必选类型一定有值
    func demo3() {
        var a: Int? = 10
        print(a ?? 0)
        a = nil
        print(a ?? 0)//可选类型的打印 必须要有默认值，在为nil的时候，就执行默认值

        var b: Int? = 10
        let c = b ?? 0 + 10
        
        var d = 10
        let f = 22 + d
        
        print("demo3",b ?? 0,c,d,f)
        b = nil;
        print("demo3",b ?? -1,c,d,f)
        d = 15;
        b = 1;
        print("demo3",b ?? 0,c,d,f)
        
//        使用'?'或者'!'进行解包
//        -- '!' 强制解包 一定要获取一个值 不能够为nil
//        -- '?'如果可选类型要进行计算的时候,系统会报错,需要程序员手动处理可选类型
//        -- '!' 强制解包有风险,需要谨慎使用,程序员需要对'!'负责 如果为nil 程序会崩溃
//        -- 一定要考虑是否安全 一定有值 防患于未然
//        -- '??' 合并空选项 必须提高 ?? 的优先级
    }
    
    
    
    // MARK: - 条件语句
//        分支结构 if语句
//
//        条件语句没有() ，可以写，但不推荐写
//        分支结构必须有 {}
//        没有非零即真的概念，只有true 和false
    func demo4(a:Int) {
        if a < 22 {
            print(a,"小于 22")
        }else {
            print(a,"大于或等于 22")
        }
        
        let urlString = "https://www.jianshu.com/u/5b9953c3d3ad"
        let url = URL(string: urlString)
        if url != nil {
            print(url ?? "nil")
        }
        
        //只有当url2不为空的时候,才会执行里面的代码
        if let url2 = URL(string: urlString) {
            print("url2",url2)
            _ = URLRequest(url: url2)
        }
        
        //不希望guard 能够被穿透
        //如果url1 为nil 就进入else 分支 会直接return
        let urlS = "f"
        guard var url3 = URL(string: urlS) else {
            print("url is nil")
            return
        }
        
        var b: Int? = 10
        var c: Int? = 30
        b = 9
        c = 8
        if b != nil && c != nil  {
            print(b!,c!)
        }
        
        
        //guard 可以多个条件判断
        let d = 9
        let e = 8
        guard  d == b, e == c else {
            print("guard 多个条件")
            return
        }
        
//        switch
//        不需要写break
//        每个匹配项中至少有一段代码可以执行
//        可以判断任意类型
//        一次可以匹配多个值
//        在匹配项中可以声明临时变量,而且不需要加 {} 限制作用域
        let x = 100
        switch x {
        case 100 ,200:
            print("[100 ,200]")
        case 201 ,300:
            print("[201 ,300]")
        case 301 ,400:
            print("[301 ,400]")
        case 401 ,500:
            print("[401 ,500]")
        default:
            print("不在区间")
        }
    }
    
}


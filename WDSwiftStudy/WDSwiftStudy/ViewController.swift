//
//  ViewController.swift
//  WDSwiftStudy
//
//  Created by 伟东 on 2021/1/27.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLAPI().getDataimgRank(URLAPI().imgRank)
        
        let label : UILabel = UILabel.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        self.view.addSubview(label)
        

        var binder = Binder<String>(label){ label, text in
            label.text = text
        }
        
        Observable.just(1).map{"数值是：\($0)"}.subscribe(binder).dispose()
        
        
//        WDObserver.creatobservable()
        
        
        
        
//        let str = "123ef3244rfs".wd.numberCount
//        print(str)
//        
//        String.wd.test()
//        
//        let s1 : NSString = "123erf"
//        print(s1.wd.numberCount)
        
//        WDLog("kkkkkk")
        // Do any additional setup after loading the view.
//        view.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
//
//        let a = 20
//        let b = 33.7
//        let c = a + Int(b)
//        let d = Double(a) + b
//
//        print("c = \(c)")
//        print("d = \(d)")

//        demo1()
//        demo2()
//        demo3()
//        demo4(a: 22)
//        demo5()
//        demo6()
//        demo7()
//        demo8()
//        demo9()
//        demo10()
        
//        demo11()
        
//        let wdDemo = WDDemo()
//        wdDemo.wdDemo1()
//        let age_1 = wdDemo.addExtensionFunc(age: 10)
//        print("addExtensionFunc \(age_1)")
//
//        let t = WDShareinstace.shareInstace
//        t.name = "jjj"
//        print("WDShareinstace",t.name)
//
//        print("==================== WDTypedOrRawPointer")
//        let pointer = WDTypedOrRawPointer()
//        pointer.wdTypedOrRawPointer()
//
//        let wdMirrorDemo = WDMirror()
//        wdMirrorDemo.wdMirrorDemo()
//
//
//        let wdenum = WDEnum()
//        wdenum.wdEnumTest()
        
        
        
    }
    // MARK: - 带间隔的区间值
    func demo11() {
        
        let hours = 111
        let hourImaterval = 2
        //tickMark的取值：从4开始，累加2，不超过11
        for tickMark in stride(from: 4, through: hours, by: hourImaterval) {
            print(tickMark)
        }
        
    }
    
    
    
    // MARK: - 函数
    func demo10()  {
        print("==================== demo10")
        func numT(a:Int,b:Int) {
            print(a*b)
        }
        numT(a: 3, b: 3)
        
        num1(a: 101, b:101)
        let c = num2(a: 101, b: 101)
        print("num2",c)
        
        let d = num3(width: 201, height: 201)
        print("num3",d)
    }
    
    func num1(a:Int,b:Int) {
        let c = a*b
        print("num1",c)
    }
    
    func num2(a:Int,b:Int) -> Int {
        return a*b
    }
    
    func num3(width a:Int,height b:Int) -> Int {
        return a*b
    }
    
    // MARK: - 条件选择 where
    func demo9() {
        print("==================== demo9")
        let point = (1,1)
        switch point {
        case let (x,y) where x == y:
            print("相等的",x,y)
            break
        default:
            break
        }
        
        let items = [12,2,3,4,6,22,99,100]
        for item in items where item > 50 {
            print("where item > 50:",item)
        }
    }
    
    
    // MARK: - 集合：数组 字典
    func demo8() {
        print("==================== demo8")
        //数组
        let array:[Any] = ["ww","ee","rr",13]//不推荐在数组中放不同的元素
        print(array)
        
        let emptyArray = [String]()//实例化空数组
        print(emptyArray)
        
        print("---------------------")
        
        var array1 = ["一","二","三","四","五"]
        // 倒序遍历
        for str in array1.reversed() {
            print(str)
        }
        print("---------------------")
        // 数组的增删改查
        array1.append("qwe")
        array1.remove(at: 2)
        array1[1] = "kk"
        for str in array1 {
            print(str)
        }
        print("---------------------")
        // 同时遍历 index value
        for (index,value) in array1.enumerated() {
            print("index",index,"value",value)
        }
        print("---------------------")
        // 数组合并
        let arr1:[Any] = ["jj","ll",1]
        let arr2:[Any] = ["a","b",0]
        let arr = arr1 + arr2
        print("数组合并",arr)
        
        
        //字典
        //初始化
        let dict:[String:Any] = ["name":"hh","age":"22"]
        print(dict)
        var emptyDict = [String:Any]()
        var dic:[String:Any] = ["name":"hjkh","age":99]
        print("init",dic)
        dic["love"] = "jkhs"
        print("add",dic)

        dic["love"] = "见客户"
        print("update",dic)

        
        dic.removeValue(forKey: "age")
        print("remove",dic)

        for (key,value) in dic {
            print(key,value)
        }
        dic.removeAll()
        print("removeAll",dic)
        
    }
    
    
    
    // MARK: - 字符串
    func demo7() {
        print("====================")
        // 打印转换字符串
        let str:String = "开始学习swift"
        let NSString_s = str as NSString
        print(NSString_s)
        
        // 字符串长度
        let len = str.lengthOfBytes(using: .utf8)
        print(len)
        
        let length = str.count
        print(length)
        
        // 遍历字符串
        for c in str {
            print(c)
        }
        // 字符串拼接
        let str1 = "好地方少了风"
        let str2 = "技术落后放入"
        let str3 = str1 + str2
        print(str3)
        
        print("-----------------")
        // 字符串转义
        let name = "老王"
        let age = 30
        let str4 = name + String(age)
        let str5 = name + "\(age)"
        let str6 = "\(name)\(age)"
        
        print(str4)
        print(str5)
        print(str6)
        
        // 字符串格式化
        let x = 3
        let y = 4
        let z = 6
        let str7 = String(format: "%02d:%02d:%02d", x,y,z)
        print(str7)
        
        // 字符串截取
        let str8 = "海口市将恢复了基尔霍夫利润"
        let start = str8.index(str8.startIndex, offsetBy: 3)
        let str10 = str8.suffix(3)
        let str11 = str8.suffix(from: start)
        let str12 = str8.suffix(4)
        let str13 = str8.prefix(3)

        print(start)
        print(str10)
        print(str11)
        print(str12)
        print(str13)

        
        
    }
    
    
    // MARK: - range区间
    func demo6() {
        print("====================")
        let range = 0...10
        let ishave = range.contains(5)// 区间是否包含5
        print("ishave",ishave)
        
        let range1:ClosedRange<Int> = 1...5
        let range2:Range<Int> = 1..<5
        let range3:PartialRangeThrough<Int> = ...15
        
        print(range1)
        print(range2)
        print(range3)

        
        let stringRange = "a"..."z"
        let isHave_b = stringRange.contains("b")
        print("isHave_b",isHave_b)
        
        let stringRange2 = "cc"..."ff"
        let isHave_cb = stringRange2.contains("cb")
        let isHave_dz = stringRange2.contains("dz")
        let isHave_fg = stringRange2.contains("fg")
        print("isHave_cb",isHave_cb)
        print("isHave_dz",isHave_dz)
        print("isHave_fg",isHave_fg)

        
        let tiem = 14
        let margin = 2
        for item in stride(from: 4, through: tiem, by: margin) {// 包含最后的数，through从头到尾的彻底的穿过
            print("stride through",item)
        }
        print("-----------")
        for item in stride(from: 4, to: tiem, by: margin) {//不包含最后的数据
            print("stride"+"to",item)
        }
        
    }
    
    // MARK: - for循环
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
            fallthrough
        case 301 ,400:
            print("[301 ,400]")
        case 401 ,500:
            print("[401 ,500]")
        default:
            print("不在区间")
        }
        
        let string = "kk"
        switch string {
        case "kk":
            fallthrough
        case "ll":
            print("kk ll")
        default:
            break
        }
        
        let point = (1,-1)
        switch point {
        case let(x, y) where x == y:
            print("on the line x == y")
        case let(x, y) where x == -y: do {
            print("on the line x == -y")
        }
        default:
            break
        }
        
        outer: for i in 1...4 {
            for k in 1...4 {
                if k == 2 {
                    continue outer// 标签标记对应的for循环
                }
                if i == 3 {
                    break outer
                }
            }
        }
    }
    
    
    /// 返回多个元组
    ///
    /// - Parameters:
    ///   - v1: 参数1
    ///   - v2: 参数2
    /// - Returns: 返回多个元组
    func cal(v1: Int, v2: Int) -> (sum: Int, difference:Int, average:Int) {
        let sum = v1 + v2;
        return (sum, v1 - v2, sum >> 1)
    }
    
    
    /// 标签 参数，使用时用 at
    /// - Parameter time: 参数时间
    func gotoJob(at time: String) {
        print("go to job \(time)")
    }
    
    
    /// 参数可以有默认值
    /// - Parameters:
    ///   - name: 姓名 默认Jack
    ///   - age: 年龄 默认0
    ///   - job: 工作默认 none
    func check(name: String = "Jack", age: Int = 0, job: String = "none") {
        print("1","2",separator: "=")
    }
    
    /// 可变参数类型
    /// - Parameter numbers: 多个同类型的参数
    /// - Returns:  sum
    func sum (_ numbers: Int...) -> Int {
        var total = 0
        for num in numbers {
            total += num
        }
        return total
    }
    
    
    /// 输入输出参数
    /// - Parameters:
    ///   - v1: <#v1 description#>
    ///   - v2: <#v2 description#>
    func swa(_ v1: inout Int, _ v2: inout Int) {
        let temp1 = 2
        let temp2 = 3
        v1 = temp1
        v2 = temp2
    }
    var a = 4
    var b = 5
    
    
    
}


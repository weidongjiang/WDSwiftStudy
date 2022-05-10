//
//  WDLiveGiftPlay.swift
//  WDSwiftStudy
//
//  Created by 蒋伟东 on 2022/4/29.
//

import Foundation
import UIKit
import SVGAPlayer
import SnapKit

class LNSVGAViewController: UIViewController {
    
    let svgaParser = SVGAParser.init()
    let svgaPalyer = SVGAPlayer.init()
    
    let playQueue = DispatchQueue.init(label: "com.svga.queue", attributes: .concurrent)
    let svgaLock = NSLock.init()
    let svgaGroup = DispatchGroup.init()
    
    var playTimes = 0 {
        didSet {
            //主线程刷新UI
            runInMain {
                self.markLabel.text = "总共需要播放 \(self.playTimes) 次动画"
            }
        }
    }
    var completeTimes = 0 {
        didSet {
            runInMain {
                self.countLabel.text = "当前已经播放 \(self.completeTimes) 个动画"
            }
        }
    }
    
    let markLabel = UILabel.init()
    let countLabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(svgaPalyer)
        //配置player
        svgaPalyer.clearsAfterStop = true
        svgaPalyer.delegate = self
        svgaPalyer.loops = 1
        
        svgaPalyer.snp.makeConstraints { (ls) in
            ls.edges.equalTo(self.view)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Play", style: .done, target: self, action: #selector(playSVGA))
        
        markLabel.textAlignment = .center
        self.view.addSubview(markLabel)
        
        markLabel.snp.makeConstraints { (ls) in
            ls.left.right.bottom.equalToSuperview()
            ls.height.equalTo(50)
        }
        
        countLabel.textAlignment = .center
        self.view.addSubview(countLabel)
        
        countLabel.snp.makeConstraints { (ls) in
            ls.left.right.equalToSuperview()
            ls.height.equalTo(30)
            ls.bottom.equalTo(markLabel.snp_topMargin)
        }
        
        self.view.backgroundColor = UIColor.systemGray5
    }
    
    //播放动画
    @objc func playSVGA() {
        
        playQueue.async(group: svgaGroup) {
            //需要播放的数量+1
            self.playTimes += 1
            if self.playTimes == 1 {
                //队列组进行监听
                self.addNotify()
            }
            //上锁，等待上一个动画播放完毕
            //连续点击时，由于该线程被锁住了，所以会堵塞到这里，直到锁解开，才会继续执行
            self.lock()
            //由于上面的那个线程是被锁住的，所以执行不了任务了，再另开辟一个线程执行动画
            DispatchQueue.global().async {
                let svgas = [
                    "https://github.com/yyued/SVGA-Samples/blob/master/EmptyState.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/HamburgerArrow.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/PinJump.svga?raw=true",
                    "https://github.com/svga/SVGA-Samples/raw/master/Rocket.svga",
                    "https://github.com/yyued/SVGA-Samples/blob/master/TwitterHeart.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/Walkthrough.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/angel.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/halloween.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/kingset.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/posche.svga?raw=true",
                    "https://github.com/yyued/SVGA-Samples/blob/master/rose.svga?raw=true",
                ]
                //随机取一个url进行播放
                let urlString = svgas[Int(arc4random()) % (svgas.count-1)]
                guard let url = URL.init(string: urlString) else {
                    return
                }
                self.svgaParser.parse(with: url) {[weak self] (entity) in
                    //将加载完毕的entity对象赋给player
                    self?.svgaPalyer.videoItem = entity
                    //player有了播放源之后就可以开始播放了。
                    self?.svgaPalyer.startAnimation()
                } failureBlock: {[weak self] (error) in
                    //播放错误处理
                    WWZLDebugPrint(item: url)
                    WWZLDebugPrint(item: error?.localizedDescription ?? "")
                    //播放出现问题，跳过播放，完成数+1
                    self?.completeTimes += 1
                    WWZLDebugPrint(item: "动画文件无效，跳过播放，当前进度：\(self?.completeTimes ?? 0)/\(self?.playTimes ?? 0)")
                    //将线程解锁，进行下一个操作
                    self?.unlock()
                }
            }
        }

    }
    
    func addNotify() {
        svgaGroup.notify(queue: playQueue) {
            WWZLDebugPrint(item: "\(self.playTimes)次动画已经全部播放完毕🌹🌹🌹🌹💐")
//            self.ly_showSuccessHud(text: "\(self.playTimes)次动画已经全部播放完毕", autoHideDelay: 1.5)
            //动画播放完毕，将指示器全部重置，并且清除播放器
            self.playTimes = 0
            self.completeTimes = 0
            self.svgaPalyer.clear()
        }
        // MARK：-
//        #warning("todo")

        // TODO:
    }
    
    func lock() {
        //上锁，并且group的enter+1，当group的enter和leave成对出现时，才会触发notify
        self.svgaGroup.enter()
        self.svgaLock.lock()
    }
    
    func unlock() {
        //解锁
        playQueue.async(group: svgaGroup) {
            self.svgaLock.unlock()
            self.svgaGroup.leave()
        }
    }
    
    deinit {
        WWZLDebugPrint(item: "deinit - \(self.classForCoder)")
        svgaPalyer.stopAnimation()
        svgaPalyer.clear()
        svgaPalyer.delegate = nil
    }
}


extension LNSVGAViewController : SVGAPlayerDelegate {
    
    func svgaPlayerDidAnimated(toFrame frame: Int) {
        //WWZLDebugPrint(item: "动画已经播放frame*******\(frame)")
    }
    
    func svgaPlayerDidAnimated(toPercentage percentage: CGFloat) {
        //WWZLDebugPrint(item: "动画播放进度-----\(percentage)")
    }
    
    func svgaPlayerDidFinishedAnimation(_ player: SVGAPlayer!) {
        completeTimes += 1
        WWZLDebugPrint(item: "本次动画播放完毕，当前进度：\(completeTimes)/\(playTimes)")
        //播放完毕，解锁，进行下一个操作
        unlock()
    }
    
}

//调试模式输出
func WWZLDebugPrint<T>(item message:T, file:String = #file, function:String = #function,line:Int = #line) {
    
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName):\(line) | \(message)")
    #endif
}

public func runInMain(_ block: @escaping ()->Void) -> Void {
    if Thread.current == Thread.main {
        block()
    } else {
        DispatchQueue.main.async {
            block()
        }
    }
}

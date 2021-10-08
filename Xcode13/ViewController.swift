//
//  ViewController.swift
//  Xcode13
//
//  Created by 研发部-陆续 on 2021/9/29.
//

import UIKit

@propertyWrapper
struct Clamped<T: Comparable> {
    let wrappedValue: T

    init(wrappedValue: T, range: ClosedRange<T>) {
        self.wrappedValue = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Swift5.5 新特性
        // CGFloat Double隐式转换
        let cgvalue: CGFloat = 1.0
        let dvalue: Double = cgvalue
        print(dvalue)
        
        // 属性包装器可用于函数、闭包 参数
        func setScore2(@Clamped(range: 0...100) to score: Int) {
            print("Setting score to \(score)")
        }
        setScore2(to: 50)
        setScore2(to: -50)
        setScore2(to: 500)
        
        // lazy 关键字现在也能用于局部作用域
        func printGreeting(to: String) -> String {
            print("In printGreeting()")
            return "Hello, \(to)"
        }
        func lazyTest() {
            print("Before lazy")
            lazy var greeting = printGreeting(to: "Paul")
            print("After lazy")
            print(greeting)
        }
        lazyTest()
        
        
    }

    // code review: 团队成员在审核期间为代码添加的注释与审核者的姓名和头像一起内嵌显示在代码编辑器中。
    // 添加注释、评论
    
    // docc: 生成文档
    
    /// 测试文档
    /// - Parameter e: ee
    /// - Returns: string
    func autodoc(e: Int) -> String {
        return ""
    }
}


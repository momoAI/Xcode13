//
//  ViewController.swift
//  Xcode13
//
//  Created by momo on 2021/9/29.
//

import UIKit

@propertyWrapper
struct Clamped<T: Comparable> {
    let wrappedValue: T

    init(wrappedValue: T, range: ClosedRange<T>) {
        self.wrappedValue = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

// Actor
//Actor 和 Class 有以下相似点：
//两者都是引用类型，因此可以用于共享状态,
//两者都可以有方法，属性，构造器和下标。
//两者都可以遵循协议，可以是泛型。
//两者的静态属性和静态方法的行为完全一致，因为静态属性和静态方法没有 self 的概念，所以不涉及数据的隔离。

//Actor 和 Class 的区别：
//Actor 当前还不支持继承，这使得它们的构造器更简单 —— 不需要便利构造器，重写和 final 关键字。这一点未来版本的 Swift 可能会改变。
//所有的 actor 都隐式遵循了 Actor 协议，其他的具体类型都不能使用这个协议。

actor SwiftActor {
    var instance: String?
    
    var property: String {
        get {
            return "bar"
        }
    }
    
    init() {
        
    }
    
    func foo() {
        
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
        
        // async/await
        Task {
            await testAsyncAwait()
        }
        
        // 全局 actor, 在主线程调用
        @MainActor func mainSafe() {
            print("call function in thread \(Thread.current )")
        }
        
        DispatchQueue.global().async {
            mainSafe()
        }
    }

    func testAsyncAwait() async {
        func asyncFunc() async -> String {
            sleep(1)
            print("async execute")
            return "ok"
        }
        func asyncFunc() -> String {
            print("async execute")
            return "ok"
        }
        //  同步函数不能直接调用异步函数 —— 这样做不合理，因此 Swift 会抛出错误
        //  异步函数可以调用其他异步函数，但同时也可以调用同步函数
        //  假设你同时有可供同步和异步调用的函数，Swift 会根据当前上下文优选相应的版本 —— 如果调用方当前是异步的 Swift 就会调用异步的函数，否则它就会调用同步的函数。
        let asyncResult = await asyncFunc()
        print(asyncResult)
        print("end....")
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


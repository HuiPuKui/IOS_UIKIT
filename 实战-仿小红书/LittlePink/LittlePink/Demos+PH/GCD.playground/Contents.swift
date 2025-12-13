import Foundation

// MARK: - GCD(Grand Central Dispatch) - 多线程执行任务的解决方案

// 任务(执行的代码)
// 1. 同步执行任务(sync) - 不具备开启多线程的能力
// 2. 异步执行任务(async) - 具备开启多线程的能力

// 队列(排队等待处理的任务) - FIFO(先进先出) - 先排队的人先受理
// 1. 串行队列(Serial Dispatch Queue) - 顺次执行队列中的任务
// 2. 并发队列(Concurrent Dispatch Queue) - 同时执行队列中的任务

// 串行队列同步执行
/*
let serialQueue = DispatchQueue(label: "serialQueue")
serialQueue.sync {
    for i in 1...3 {
        print("i: \(i)")
    }
}

for j in 10...13 {
    print("j: \(j)")
}
 */

// 并发队列异步执行
/*
let concurrentQueue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
concurrentQueue.async {
    for i in 1...3 {
        print("i: \(i)")
    }
}

concurrentQueue.async {
    for j in 10...13 {
        print("j: \(j)")
    }
}
 */

// 主队列
DispatchQueue.main.async {
    
}

// 全局并发队列
DispatchQueue.global().async {
    
}

DispatchQueue.global().async {
    print(Thread.current)
    
    DispatchQueue.main.async {
        print(Thread.current)
    }
}

//
//  SoupController.swift
//  IAP
//
//  Created by 惠蒲葵 on 2025/9/7.
//

import UIKit
import StoreKit

class SoupController: UITableViewController {
    
    let productId = "app store connect 里的 ID"
    
    var soup = [
        "1.命为弱者借口，运乃强者谦词",
        "2.种一棵树最好的时间是十年前，其次是现在",
        "3.说出来被人嘲笑的梦想，才有实现的价值",
        "4.所谓的光辉岁月，并不是以后，闪耀的日子，而是无人问津时，你对梦想的偏执",
        "5.既然不屑为伍，何必害怕与众不同",
    ]
    
    let soupVIP = [
        "6.没有时间学习的人，是有了时间也不会学习的人",
        "7.不要把这个世界，让给你恶心的人",
        "8.乾坤未定 你我都是黑马",
        "9.对不起，这把我要赢",
        "10.你必须非常努力，才能看起来毫不费力"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        
        if isPayed() {
            showAll()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPayed() ? self.soup.count : self.soup.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soup", for: indexPath)
        
        if indexPath.row == self.soup.count {
            cell.textLabel?.text = "购买鸡汤"
            cell.textLabel?.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = self.soup[indexPath.row]
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.accessoryType = .none
        }
        
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.soup.count {
            // 实现内购的方法
            let pay = SKMutablePayment() // 拿推车准备购物
            pay.productIdentifier = self.productId // 选择商品
            SKPaymentQueue.default().add(pay) // 加购+去收银台排队买单
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func restore(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}

extension SoupController: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                print("购买成功")
                savePayed()
                showAll()
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    print("购买失败, 原因是: \(error.localizedDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .restored {
                savePayed()
                showAll()
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    func savePayed() {
        UserDefaults.standard.set(true, forKey: self.productId)
    }
    
    func isPayed() -> Bool {
        return UserDefaults.standard.bool(forKey: self.productId)
    }
    
    func showAll() {
        self.navigationItem.setRightBarButton(nil, animated: true)
        self.soup.append(contentsOf: self.soupVIP)
        self.tableView.reloadData()
    }
    
}

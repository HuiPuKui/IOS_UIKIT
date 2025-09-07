//
//  SoupController.swift
//  IAP
//
//  Created by 惠蒲葵 on 2025/9/7.
//

import UIKit

class SoupController: UITableViewController {
    
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

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.soup.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soup", for: indexPath)
        
        if indexPath.row == self.soup.count {
            cell.textLabel?.text = "购买鸡汤"
            cell.textLabel?.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.textLabel?.text = self.soup[indexPath.row]
            cell.textLabel?.numberOfLines = 0
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.soup.count {
            // 实现内购的方法
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func restore(_ sender: Any) {
        
    }
    
}

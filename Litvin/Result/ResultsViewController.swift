//
//  ResultsViewController.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var bonus: UILabel!
    @IBOutlet weak var nalog: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var textView: UITextView!
    var model: Worker
    init(model: Worker) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        money.text = String(model.money) + "р"
        
        var days: Set<Int> = Set<Int>()
        
        for i in model.diseases ?? [] {
            if let i = i as? Disease {
                let day1 = Calendar.current.component(.day, from: i.start!)
                let day2 = Calendar.current.component(.day, from: i.end!)
                
                for j in day1...day2 {
                    days.insert(j)
                }
            }
        }
        
        self.days.text = String(days.count)
        
        let dayMoney = Float(model.money) / 30.0
        let a = Float(30 - days.count) * Float(dayMoney)
        var result = a + Float(days.count) * dayMoney / 2.0
        
        var bonus = 0
        for i in model.bonus ?? [] {
            if let i = i as? Bonus {
                bonus += Int(i.money)
                if !textView.text.isEmpty && !i.text!.isEmpty {
                    textView.text += "\n"
                }
                textView.text += i.text!
            }
        }
        
        if bonus == 0 {
            textView.text += "Нет"
        }
        
        self.bonus.text = "+ \(bonus)р"
        
        let nalog = result * 0.13
        self.nalog.text = "- \(nalog)р"
        
        result = result - nalog + Float(bonus)
        self.result.text = "Итог: \(result)р"
    }
    @IBAction func back(_ sender: Any) {
        view.removeFromSuperview()
    }
}

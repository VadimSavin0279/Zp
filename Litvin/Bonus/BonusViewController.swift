//
//  BonusViewController.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//

import UIKit

protocol Delegate2: AnyObject {
    func add(model: Disease)
    func addBonus(model: Bonus)
}

class BonusViewController: UIViewController {
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    let datePicker = UIDatePicker()
    var startDate: Date?
    var endDate: Date?
    @IBOutlet weak var money: UITextField!
    @IBOutlet weak var descr: UITextField!
    weak var delegate: Delegate2?
    override func viewDidLoad() {
        super.viewDidLoad()
        startTextField.inputView = datePicker
        endTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done1Action(_ sender: Any) {
        let month1 = Calendar.current.component(.month, from: datePicker.date)
        let month2 = Calendar.current.component(.month, from: Date())
        
        if month1 == month2 {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            startTextField.text = formatter.string(from: datePicker.date)
            startDate = datePicker.date
            startTextField.resignFirstResponder()
            error.isHidden = true
        } else {
            error.isHidden = false
            error.text = "Больничный можно добавлять только для текущего месяца"
        }
    }
    
    @IBAction func done2Action(_ sender: Any) {
        let month1 = Calendar.current.component(.month, from: datePicker.date)
        let month2 = Calendar.current.component(.month, from: Date())
        
        if month1 == month2 {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            endTextField.text = formatter.string(from: datePicker.date)
            endDate = datePicker.date
            endTextField.resignFirstResponder()
            error.isHidden = true
        } else {
            error.isHidden = false
            error.text = "Больничный можно добавлять только для текущего месяца"
        }
    }
    @IBAction func save(_ sender: Any) {
        guard let startDate = startDate, let endDate = endDate else {
            //view.removeFromSuperview()
            return
        }
        
        let date1 = Calendar.current.dateComponents([.day], from: startDate)
        let date2 = Calendar.current.dateComponents([.day], from: endDate)
        
        if date1.day! < date2.day! {
            let model = Disease()
            model.start = startDate
            model.end = endDate
            delegate?.add(model: model)
            clear(0)
            error.isHidden = true
        } else {
            error.isHidden = false
            error.text = "Дата начала должна быть раньше даты конца"
        }
    }
    @IBAction func clear(_ sender: Any) {
        startDate = nil
        endDate = nil
        startTextField.text = ""
        endTextField.text = ""
    }
    
    @IBAction func addBonus(_ sender: Any) {
        if !money.text!.isEmpty {
            let bonus = Bonus()
            bonus.money = Int32(money.text!) ?? 0
            bonus.text = descr.text
            delegate?.addBonus(model: bonus)
            money.text = ""
        }
    }
    
    @IBAction func exitAction(_ sender: Any) {
        view.removeFromSuperview()
    }
    @IBAction func clearBonus(_ sender: Any) {
        money.text = ""
        descr.text = ""
    }
}

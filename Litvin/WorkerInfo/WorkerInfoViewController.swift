//
//  WorkerInfoViewController.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//

import UIKit

protocol Delegate: AnyObject {
    func update()
}

class WorkerInfoViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, Delegate2 {
    func addBonus(model: Bonus) {
        worker.addToBonus(model)
        CoreDataManager.instance.saveContext()
    }
    
    func add(model: Disease) {
        worker.addToDiseases(model)
        CoreDataManager.instance.saveContext()
        self.model.append(model)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        let formatter = DateFormatter()
          formatter.dateFormat = "dd/MM"
        config.text = "\(formatter.string(from: model[indexPath.row].start!)) - \(formatter.string(from: model[indexPath.row].end!))"
        cell.contentConfiguration = config
        return cell
    }
    
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var addDays: UIButton!
    @IBOutlet weak var raschet: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var childfield: UITextField!
    @IBOutlet weak var familyfield: UITextField!
    @IBOutlet weak var moneyfield: UITextField!
    @IBOutlet weak var workfield: UITextField!
    @IBOutlet weak var fiofield: UITextField!
    @IBOutlet weak var numberfield: UITextField!
    
    enum TypeScreen {
        case edit(Worker)
        case new
    }
    let type: TypeScreen
    let worker: Worker
    init(type: TypeScreen) {
        self.type = type
        switch type {
        case .edit(let worker):
            self.worker = worker
            uuid = worker.id ?? UUID()
            for i in worker.diseases ?? [] {
                if let i = i as? Disease {
                    model.append(i)
                }
            }
        case .new:
            self.worker = Worker()
            uuid = UUID()
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    weak var delegate: Delegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let uuid: UUID
    
    var model: [Disease] = [] {
        didSet {
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deactivate()
        
        childfield.delegate = self
        familyfield.delegate = self
        moneyfield.delegate = self
        workfield.delegate = self
        fiofield.delegate = self
        numberfield.delegate = self
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableview.layer.borderColor = UIColor.gray.cgColor
        tableview.layer.borderWidth = 1
        
        numberfield.text = uuid.uuidString
        
        switch type {
        case .edit(let worker):
            fiofield.text = worker.fio
            workfield.text = worker.work
            moneyfield.text = String(worker.money)
            familyfield.text = worker.family
            childfield.text = String(worker.children)
        case .new:
            activate()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        view.removeFromSuperview()
    }
    
    @IBAction func editAction(_ sender: Any) {
        activate()
    }
    
    @IBAction func addBonus(_ sender: Any) {
        let newVC = BonusViewController()
        self.addChild(newVC)
        newVC.view.frame = self.view.bounds
        self.view.addSubview(newVC.view)
        newVC.didMove(toParent: self)
        newVC.delegate = self
    }
    
    @IBAction func raschetAction(_ sender: Any) {
        let newVC = ResultsViewController(model: worker)
        self.addChild(newVC)
        newVC.view.frame = self.view.bounds
        self.view.addSubview(newVC.view)
        newVC.didMove(toParent: self)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if !fiofield.text!.isEmpty && !workfield.text!.isEmpty && !numberfield.text!.isEmpty && !familyfield.text!.isEmpty && !moneyfield.text!.isEmpty && !childfield.text!.isEmpty {
            if let money = Int32(moneyfield.text!), let child = Int16(childfield.text!) {
                switch type {
                case .edit(_):
                    worker.id = uuid
                    worker.fio = fiofield.text!
                    worker.children = child
                    worker.family = familyfield.text!
                    worker.money = money
                    worker.work = workfield.text!
                    CoreDataManager.instance.saveContext()
                case .new:
                    worker.id = uuid
                    worker.fio = fiofield.text!
                    worker.children = child
                    worker.family = familyfield.text!
                    worker.money = money
                    worker.work = workfield.text!
                    CoreDataManager.instance.saveContext()
                }
                delegate?.update()
                view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        switch type {
        case .edit(let worker):
            CoreDataManager.instance.persistentContainer.viewContext.delete(worker)
            CoreDataManager.instance.saveContext()
            delegate?.update()
        case .new:
            break
        }
        view.removeFromSuperview()
    }
    
    func activate() {
        fiofield.isEnabled = true
        workfield.isEnabled = true
        familyfield.isEnabled = true
        childfield.isEnabled = true
        moneyfield.isEnabled = true
        
        back.isHidden = true
        raschet.isHidden = true
        addDays.isHidden = false
        save.isHidden = false
        
        edit.isHidden = true
        delete.isHidden = false
    }
    
    func deactivate() {
        numberfield.isEnabled = false
        fiofield.isEnabled = false
        workfield.isEnabled = false
        familyfield.isEnabled = false
        childfield.isEnabled = false
        moneyfield.isEnabled = false
        
        back.isHidden = false
        raschet.isHidden = false
        addDays.isHidden = true
        save.isHidden = true
        
        edit.isHidden = false
        delete.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let object = model[indexPath.row]
            switch type {
            case .edit(let worker):
                CoreDataManager.instance.persistentContainer.viewContext.delete(object)
                worker.removeFromDiseases(object)
                model.remove(at: indexPath.row)
                tableView.reloadData()
                CoreDataManager.instance.saveContext()
                delegate?.update()
            case .new:
                break
            }
        }
    }
}

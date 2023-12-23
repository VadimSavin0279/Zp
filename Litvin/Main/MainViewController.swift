//
//  MainViewController.swift
//  Litvin
//
//  Created by Вадим on 25.11.2023.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Delegate {
    func update() {
        let request = Worker.fetchRequest()
        if let data = try? CoreDataManager.instance.persistentContainer.viewContext.fetch(request) {
            model = data
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = model[indexPath.row].fio
        config.secondaryText = model[indexPath.row].id?.uuidString
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = config
        return cell
    }
    

    @IBAction func addWorker(_ sender: Any) {
        let newVC = WorkerInfoViewController(type: .new)
        self.addChild(newVC)
        newVC.view.frame = self.view.bounds
        self.view.addSubview(newVC.view)
        newVC.didMove(toParent: self)
        newVC.delegate = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    var model: [Worker] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        update()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = WorkerInfoViewController(type: .edit(model[indexPath.row]))
        self.addChild(newVC)
        newVC.view.frame = self.view.bounds
        self.view.addSubview(newVC.view)
        newVC.didMove(toParent: self)
        newVC.delegate = self
    }
}



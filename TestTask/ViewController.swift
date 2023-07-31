//
//  ViewController.swift
//  TestTask
//
//  Created by Мария on 03.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var count = 0
    var counter = 0
    
    var plugArray = [Int]()
    
    var childDataArray = [Child]()
    
    var firstVar = ""
    var secondVar = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addChildButton(_ sender: Any) {

        addButton.isEnabled = false
        
        if count == 0 {
            cleanButton.isHidden = false
            plugArray.removeAll()
            counter = 0
            firstVar = ""
            secondVar = ""
        }
        
        if count < 5 {
            count += 1
            plugArray.append(count)
            
            tableView.performBatchUpdates({
                tableView.insertRows(at: [IndexPath.init(row: plugArray.count - 1, section: 0)], with: .automatic)
            }, completion: nil)
            
            let indexPath = IndexPath(row: count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
        if count == 5 {
            addButton.isHidden = true
        }
    }
    
    @IBAction func cleanTableButton(_ sender: Any) { createActionSheet() }
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let parametersObject1 = ViewParameters(borderColorData: (0.969, 0.969, 0.969, 1.0), borderWidthData: 1.5, cornerRadiusData: 7)
        let parametersObject2 = ViewParameters(borderColorData: (0.078, 0.591, 0.961, 1.0), borderWidthData: 2.0, cornerRadiusData: 26.0)
        let parametersObject3 = ViewParameters(borderColorData: (0.766, 0.004, 0.000, 1.0), borderWidthData: 2.0, cornerRadiusData: 26.0)
        
        nameView.decorateView(param: parametersObject1)
        ageView.decorateView(param: parametersObject1)
        addButton.decorateView(param: parametersObject2)
        cleanButton.decorateView(param: parametersObject3)
    }

    @objc func deleteNote(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        tableView.reloadData()
        if count > 1 {
            updateTab(indexPath: indexPath)
        } else if count == 1 {
            updateTab(indexPath: indexPath)
            addButton.isHidden = false
            addButton.isEnabled = true
            cleanButton.isHidden = true
        }
    }
    
    private func updateTab(indexPath: IndexPath) {
        
        count -= 1
        
        if count < 5 {
            plugArray.remove(at: indexPath.row)
            addButton.isHidden = false
        }
        
        if childDataArray.isEmpty {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            if childDataArray.count - 1 >= indexPath.row {
                childDataArray.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                addButton.isEnabled = true
            } else {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                addButton.isEnabled = true
            }
        }
    }
    
    private func createActionSheet() {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let resetDataAction = UIAlertAction(title: "Сбросить данные", style: .default) { _ in
            self.nameTextfield.text = ""
            self.ageTextfield.text = ""
            self.cleanButton.isHidden = true
            self.addButton.isHidden = false
            self.addButton.isEnabled = true
            self.count = 0
            self.plugArray.removeAll()
            self.childDataArray.removeAll()
            self.counter = 0
            self.firstVar = ""
            self.secondVar = ""
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        menu.addAction(resetDataAction)
        menu.addAction(cancelAction)
        
        self.present(menu, animated: true, completion: nil)
    }
}

//
//  Extensions.swift
//  TestTask
//
//  Created by Мария on 03.03.2022.
//

import Foundation
import UIKit

extension UIView {
    func decorateView(param: ViewParameters) {
        self.layer.borderColor = CGColor(srgbRed: param.borderColorData.0, green: param.borderColorData.1, blue: param.borderColorData.2, alpha: param.borderColorData.3)
        self.layer.borderWidth = param.borderWidthData
        self.layer.cornerRadius = param.cornerRadiusData
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ChildrenTableViewCell
        cell.nameTextfield.delegate = self
        cell.ageTextfield.delegate = self
        
        if childDataArray.isEmpty {
            cell.nameTextfield.text = ""
            cell.ageTextfield.text = ""
        } else {
            let result = count - 1
            if indexPath.row < result || indexPath.row == childDataArray.count - 1 {
                cell.nameTextfield.text = childDataArray[indexPath.row].name
                cell.ageTextfield.text = childDataArray[indexPath.row].age
            } else {
                cell.nameTextfield.text = ""
                cell.ageTextfield.text = ""
            }
        }
        
        cell.nameTextfield.tag = 0
        cell.ageTextfield.tag = 1
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteNote(sender:)), for: .touchDown)
        
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField.tag == 0 {
                if !(textField.text!.isEmpty) {
                    firstVar = textField.text!
                    counter += 1
                } else {
                    firstVar = ""
                    counter += 1
                }
            } else if textField.tag == 1 {
                if !(textField.text!.isEmpty) {
                    secondVar = textField.text!
                    counter += 1
                } else {
                    secondVar = ""
                    counter += 1
                }
            }
        
            if counter == 2 {
                let child = Child(name: firstVar, age: secondVar)
                self.childDataArray.append(child)
                counter = 0
                firstVar = ""
                secondVar = ""
            }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            addButton.isEnabled = false
        } else if textField.tag == 1 {
            addButton.isEnabled = true
        }
    }
}

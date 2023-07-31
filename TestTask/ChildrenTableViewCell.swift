//
//  ChildrenTableViewCell.swift
//  TestTask
//
//  Created by Мария on 03.03.2022.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var childNameView: UIView!
    @IBOutlet weak var childAgeView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ageTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let parametersObject = ViewParameters(borderColorData: (0.969, 0.969, 0.969, 1.0), borderWidthData: 1.5, cornerRadiusData: 7)
        childNameView.decorateView(param: parametersObject)
        childAgeView.decorateView(param: parametersObject)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

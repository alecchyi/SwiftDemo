//
//  LoginViewCell.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/26.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

enum LoginCellType {
    case Nickname, Phone, Password
}

class LoginViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtView: UITextField!
    
    var cellObj:[String]?
    
    var cellType:LoginCellType = .Nickname
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
        if let obj = self.cellObj {
            self.lblTitle.text = obj[0] as String
            switch cellType {
            case .Nickname:
                self.txtView.placeholder = obj[1]
            case .Phone:
                self.txtView.placeholder = obj[1]
            case .Password:
                self.txtView.placeholder = obj[1]
                self.txtView.secureTextEntry = true
            }
        }
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

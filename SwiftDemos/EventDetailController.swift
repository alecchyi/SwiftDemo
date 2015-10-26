//
//  EventDetailController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/26.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class EventDetailController: UIViewController {

    @IBOutlet weak var txtContentView: UITextView!
    
    var eventContent:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let content = self.eventContent {
            self.txtContentView.text = content
        }
    }
    
}

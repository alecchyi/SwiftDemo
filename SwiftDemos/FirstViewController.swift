//
//  FirstViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/9.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var btnText: UIButton!
    
    @IBOutlet weak var imgDemo: UIImageView!
    
    @IBOutlet weak var testView: UIView!
    
    @IBOutlet weak var txtDemo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = self.lblText.frame
        let bounds = self.lblText.bounds
        println(frame)
        println(bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


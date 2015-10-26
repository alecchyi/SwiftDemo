//
//  RegistViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/26.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class RegistViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var loginItems = [["昵称","请输入你的昵称"],["手机","请输入你的手机号"],["密码","请输入你的密码"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.registerNib(UINib(nibName: "LoginViewCell", bundle: nil), forCellReuseIdentifier: "LoginViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegistViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LoginViewCell", forIndexPath: indexPath) as! LoginViewCell
        let item = self.loginItems[indexPath.row] as [String]
        cell.cellObj = item
        if indexPath.row == 0 {
            cell.cellType = .Nickname
        }else if indexPath.row == 1 {
            cell.cellType = .Phone
        }else if indexPath.row == 2 {
            cell.cellType = .Password
        }
        cell.awakeFromNib()
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginItems.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
}

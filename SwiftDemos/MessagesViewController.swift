//
//  MessagesViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/22.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var messagesList = [Dictionary<String,AnyObject>]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        var editItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "clickEditItem:")
        
        for i in 0...10 {
            let dic = ["title":"item\(i)"]
            self.messagesList.append(dic)
        }
        
        if self.messagesList.count > 0 {
            self.navigationItem.leftBarButtonItem = editItem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func clickEditItem(sender:UIBarButtonItem) {
        
        self.tableView.setEditing(!self.tableView.editing, animated: true)
        if self.tableView.editing {
            sender.title = "Done"
        }else {
            sender.title = "Edit"
        }
    }

}

extension MessagesViewController:UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        let item = self.messagesList[indexPath.row]  as Dictionary<String,AnyObject>
        if let title = item["title"] as? String {
            cell.textLabel?.text = title
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesList.count
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if self.tableView.editing {
            if editingStyle == UITableViewCellEditingStyle.Delete {
                self.messagesList.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
}

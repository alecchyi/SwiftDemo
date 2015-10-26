//
//  EventsViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/22.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class EventObj:NSObject {
    
    var title:String?
    var content:String?
    var pic:String?
    
    override init(){
        super.init()
    }
    
    convenience init(title:String, content:String?, pic:String?) {
        self.init()
        self.title = title
        self.content = content
        self.pic = pic
    }
    
}

class EventsViewController: UIViewController {

    @IBOutlet weak var insertBtn: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentTextView: UITextView!
    
    var eventsList = [EventObj]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickInsertBtn(sender: AnyObject) {
        
    }

    @IBAction func clickSaveBtn(sender: AnyObject) {
        if let text = self.contentTextView.text {
            if text != "" {
                var count = self.eventsList.count + 1
                var obj = EventObj(title: "事项\(count)", content: text, pic: "")
                self.eventsList.append(obj)
                self.tableView.reloadData()
                self.contentTextView.text = ""
                self.contentTextView.resignFirstResponder()
            }
        }
    }
}

extension EventsViewController:UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        let item = self.eventsList[indexPath.row] as EventObj
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.content
        cell.imageView?.image = UIImage(named: "1_10_2")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.selectionStyle = UITableViewCellSelectionStyle.Blue
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsList.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyBoard.instantiateViewControllerWithIdentifier("EventDetailController") as! EventDetailController
        let item = self.eventsList[indexPath.row] as EventObj
        viewController.eventContent = item.content
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

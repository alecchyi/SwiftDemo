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
        
//        self.contentTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
//        self.contentTextView.dataDetectorTypes = UIDataDetectorTypes.Link
//        self.contentTextView.attributedText = self.createAttributedString()
//        self.contentTextView.delegate = self
    }
    
        func createAttributedString() -> NSAttributedString {
            var boldFont = UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
            var boldAttr = [NSFontAttributeName: boldFont]
            let normalAttr = [NSForegroundColorAttributeName : UIColor.brownColor(),
                NSBackgroundColorAttributeName : UIColor.whiteColor()]
            
            var attrString: NSAttributedString = NSAttributedString(string: "Born: ",
                attributes:boldAttr)
            
            var astr:NSMutableAttributedString = NSMutableAttributedString()
            astr.appendAttributedString(attrString)
            
            attrString = NSAttributedString(string: "January 1, 2014 ", attributes:normalAttr)
            astr.appendAttributedString(attrString)
            
            attrString = EventsViewController.hyperlinkFromString("Haddonfield, NJ", withURLString:"link://www.baidu.com")
            astr.appendAttributedString(attrString)
            
            attrString = NSAttributedString(string: " January 1, 2014 好说歹说但是的啊是是爱上爱上但是但是的是的的所得税但是的 ", attributes:normalAttr)
            astr.appendAttributedString(attrString)
            
            return astr
        }
        
        func preferredContentSizeChanged(notification:NSNotification) {
            self.contentTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        }
        
        // could make this an NSAttributedString extension
        /// creates and returns an NSAttributedString with a hyperlink
        class func hyperlinkFromString(string:NSString, withURLString:String) -> NSAttributedString {
            
            var attrString = NSMutableAttributedString(string: string as String)
            // the entire string
            var range:NSRange = NSMakeRange(0, attrString.length)
            
            attrString.beginEditing()
            attrString.addAttribute(NSLinkAttributeName, value:withURLString, range:range)
            attrString.addAttribute(NSForegroundColorAttributeName, value:UIColor.blueColor(), range:range)
            attrString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range)
            attrString.endEditing()
            return attrString
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

extension EventsViewController : UITextViewDelegate {
    
    func textView(UITextView,
        shouldInteractWithURL URL: NSURL,
        inRange characterRange: NSRange) -> Bool {
            
            println("url as is \(URL.absoluteString)")
            println("url scheme is \(URL.scheme)")
            
            if URL.scheme == "link" {
                var whichmap = URL.host
                
                var alert = UIAlertController(title: "Alert",
                    message: "the chosen link is \(whichmap)",
                    preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                return false
            }
            
            return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        println("begining")
    }
}

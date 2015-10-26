//
//  PersonalViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/22.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {
    @IBOutlet weak var personalHeaderView: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblBU: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var longTapHeadView:UILongPressGestureRecognizer?

    var dataList = [["组织机构","数据中心"],["帮助","版权协议"],["设置","退出"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        self.longTapHeadView = UILongPressGestureRecognizer(target: self, action: "longTapHeadView:")
        self.headImageView.addGestureRecognizer(longTapHeadView!)
        
        
        fetchUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    func fetchUserInfo() {
        if IJReachability.isConnectedToNetwork() {
//            http://9.119.117.155:3000/say/demo.json
            //http://demos.alecchyi.bluemix.net/say/demo.json
            var url = NSURL(string: "http://demos.alecchyi.bluemix.net/say/demo.json")
            if let u = url {
                let request = NSURLRequest(URL: u, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
                    let task = session.dataTaskWithRequest(request, completionHandler: {(let data, let response, let error) -> Void in
                        if let jsonData = data {
                            if let dic = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments, error: nil) as? Dictionary<String, AnyObject> {
                                if let nickname = dic["uNickname"] as? String {
                                    self.lblNickname.text = nickname
                                }
                                if let bu = dic["uBU"] as? String {
                                    self.lblBU.text = bu
                                }
                                if let pic = dic["uHeadUrl"] as? String {
                                    self.headImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: pic)!)!)
//                                    if let imgUrl = NSURL(string: pic) {
//                                        session.downloadTaskWithURL(imgUrl, completionHandler: {[weak self](let fileUrl, let resp, let erro1) -> Void in
//                                            if let weakSelf = self {
//                                            println(fileUrl)
//                                            weakSelf.headImageView.image = UIImage(data: NSData(contentsOfURL: fileUrl)!)
//                                            }
//                                        })
//                                    }
                                }
//                                println(dic)
                            }
                        }
//                        println(response)
                    })
                    
                    task.resume()
                
            }
        }
    }
    
    func longTapHeadView(sender:UILongPressGestureRecognizer) {
        let alert = UIAlertController(title: "选择照片", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "图片库", style: UIAlertActionStyle.Default, handler: {[weak self](let action) -> Void in
            if let weakSelf = self {
                weakSelf.pickerFromSource(0)
            }
        }))
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: {[weak self](let action) -> Void in
                if let weakSelf = self {
                    weakSelf.pickerFromSource(1)
                }
                }))
        }
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

extension PersonalViewController:UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
        let item = self.dataList[indexPath.section][indexPath.row]
        cell.textLabel?.text = item
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.imageView?.image = UIImage(named: "AppIcon")
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList[section].count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            self.performSegueWithIdentifier("helpViewIdentifier", sender: nil)
        }else if indexPath.section == 1 && indexPath.row == 1 {
            self.performSegueWithIdentifier("protocolViewIdentifier", sender: nil)
        }
    }
}

extension PersonalViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func pickerFromSource(source:Int){
        var imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        if source == 1 {
            imgPicker.sourceType = UIImagePickerControllerSourceType.Camera
        }else {
            imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.headImageView.image = UIImage(CGImage:image.CGImage)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        picker.dismissViewControllerAnimated(true, completion: {() -> Void in
            
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

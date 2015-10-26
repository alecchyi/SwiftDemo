//
//  ProtocolViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/23.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class ProtocolViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var res = NSBundle.mainBundle().pathForResource("protocol", ofType: "html")
        var url:NSURL = NSURL(fileURLWithPath: (res! as String))!
        var req:NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: NSTimeInterval.abs(5.0))
        self.webView.loadRequest(req)
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

extension ProtocolViewController:UIWebViewDelegate {

    func webViewDidFinishLoad(webView: UIWebView) {
        if let title = self.webView.stringByEvaluatingJavaScriptFromString("document.title") {
            self.navigationItem.title = title
            self.webView.stringByEvaluatingJavaScriptFromString("set_content('ha ha')")
        }
    }
}

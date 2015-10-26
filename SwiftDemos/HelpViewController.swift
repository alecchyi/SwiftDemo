//
//  HelpViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/23.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: "http://wwww.baidu.com")
        var request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HelpViewController:UIWebViewDelegate {

    func webViewDidFinishLoad(webView: UIWebView) {
        if let title = self.webView.stringByEvaluatingJavaScriptFromString("document.title") {
            self.navigationItem.title = title
        }
    }
    
}

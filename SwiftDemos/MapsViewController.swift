//
//  MapsViewController.swift
//  SwiftDemos
//
//  Created by dst-macpro1 on 15/10/22.
//  Copyright (c) 2015年 ibm. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var moveBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let center:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.029915, longitude: 116.347082)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: center, span: span)
        
//        self.mapView.setRegion(region, animated: true)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchLocationCities()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickMoveBtnEvent(sender: AnyObject) {
        
        UIView.animateWithDuration(2.0,
            delay: 0.0,
            options: UIViewAnimationOptions.BeginFromCurrentState,
            animations: {() -> Void in
            var btnFrame = self.moveBtn.frame
            var frame = self.view.bounds
            var imgFrame = self.picImageView.frame
            if imgFrame.origin.x + imgFrame.size.width < frame.size.width {
                imgFrame.origin.x = frame.size.width - imgFrame.size.width
            }else {
                imgFrame.origin.x = btnFrame.origin.x + btnFrame.size.width + 5
            }
            self.picImageView.frame = imgFrame
            }, completion: {[weak self](let b) -> Void in
                if let weakSelf = self {
                    weakSelf.moveToEnd()
                }
        })

    }
    
    func moveToEnd() {
        UIView.animateKeyframesWithDuration(2.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {() -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0/2.0, animations: {() -> Void in
                var frame = self.picImageView.frame
                frame.origin.y = self.view.frame.size.height
                self.picImageView.frame = frame
            })
            UIView.addKeyframeWithRelativeStartTime(1.0/2.0, relativeDuration: 1.0/2.0, animations: {() -> Void in
                var frame = self.picImageView.frame
                var btnFrame = self.moveBtn.center
                self.picImageView.center = CGPointMake(btnFrame.x + frame.size.width, btnFrame.y)
            })
            }, completion: nil)
    }
    
    func fetchLocationCities() {
        var res = NSBundle.mainBundle().pathForResource("locations", ofType: "plist")
        if let resources = res {
            if let citiesData = NSMutableArray(contentsOfFile: resources) {

                if (citiesData.count > 0) {
                    for c in citiesData {
                        if let city = c as? Dictionary<String,AnyObject> {
                            self.addAnchorPoint(city)
                        }
                        
                    }
                }
            }
        }
    }
    
    func addAnchorPoint(city:Dictionary<String, AnyObject>) {
        var pointAnnotation = MKPointAnnotation()
        let point = city["coordinate"] as! Dictionary<String, AnyObject>
        if let lat = point["lat"] as? Double, lng = point["lng"] as? Double {
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: lng )
        }
        pointAnnotation.title = city["location"] as! String
        pointAnnotation.subtitle = ""
        self.mapView.addAnnotation(pointAnnotation)
    }

}

extension MapsViewController:MKMapViewDelegate {

    
}

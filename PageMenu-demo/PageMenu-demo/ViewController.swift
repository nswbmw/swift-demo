//
//  ViewController.swift
//  PageMenu-demo
//
//  Created by nswbmw on 2018/5/14.
//  Copyright © 2018年 nswbmw. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController {
  var pageMenu: CAPSPageMenu?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Test"
    
    var controllerArray : [UIViewController] = []
    
    let controller : UIViewController = UIViewController(nibName: "1", bundle: nil)
    controller.title = "SAMPLE TITLE"
    controllerArray.append(controller)
    
    let controller2 : UIViewController = UIViewController(nibName: "2", bundle: nil)
    controller2.title = "SAMPLE TITLE2"
    controllerArray.append(controller2)

    let parameters: [CAPSPageMenuOption] = [
      .menuItemSeparatorWidth(4.3),
      .useMenuLikeSegmentedControl(true),
      .menuItemSeparatorPercentageHeight(0.1)
    ]

    pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
    self.view.addSubview(pageMenu!.view)
  }
}


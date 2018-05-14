//
//  AppDelegate.swift
//  swift-pageMenu-demo
//
//  Created by nswbmw on 16/4/2.
//  Copyright © 2016年 nswbmw. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController {
    
  var pageMenu : CAPSPageMenu?
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Initialize view controllers to display and place in array
    var controllerArray: [UIViewController] = []
        
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let controller1 = mainStoryboard.instantiateViewController(withIdentifier: "myTableView")
    controller1.title = "哈哈"
    controllerArray.append(controller1)
        
    let controller2 = mainStoryboard.instantiateViewController(withIdentifier: "myTableView")
    controller2.title = "呵呵"
    controllerArray.append(controller2)
    
    // Customize menu (Optional)
    let parameters: [CAPSPageMenuOption] = [
      .scrollMenuBackgroundColor(UIColor.white),
      .viewBackgroundColor(UIColor.white),
      .selectionIndicatorColor(UIColor.orange),
      .selectedMenuItemLabelColor(UIColor.black),
      .bottomMenuHairlineColor(UIColor.lightGray),
      .menuItemFont(UIFont(name: "HelveticaNeue", size: 17.0)!),
      .menuHeight(44.0),
      .menuItemWidth(34.0),
      .centerMenuItems(true)
    ]
    
    // Initialize scroll menu
    pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 20.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
    
    self.view.addSubview(pageMenu!.view)
  }
}

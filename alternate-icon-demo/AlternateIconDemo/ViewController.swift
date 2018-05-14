//
//  ViewController.swift
//  AlternateIconDemo
//
//  Created by Gao on 13/07/2017.
//  Copyright © 2017 leave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBAction func didTapDefault() {
    setIcon(name: nil)
  }

  @IBAction func didTapBlack(_ sender: Any) {
    setIcon(name: "black")
  }
  
  func setIcon(name: String?) {
    if #available(iOS 10.3, *) {
      UIApplication.shared.setAlternateIconName(name) { (error) in
        if let error = error {
          print(error)
        }
      }
    }
  }
}

extension DispatchQueue {
  private static var _onceTracker = [String]()
  public class func once(token: String, block: () -> ()) {
    objc_sync_enter(self)
    defer {
      objc_sync_exit(self)
    }
    if _onceTracker.contains(token) {
      return
    }
    _onceTracker.append(token)
    block()
  }
  
  func async(block: @escaping ()->()) {
    self.async(execute: block)
  }
  
  func after(time: DispatchTime, block: @escaping ()->()) {
    self.asyncAfter(deadline: time, execute: block)
  }
}

extension UIViewController {
  public class func runtimeReplaceAlert() {
    DispatchQueue.once(token: "UIAlertController") {
      let originalSelector = #selector(self.present(_:animated:completion:))
      let swizzledSelector = #selector(self.noAlert_present(_:animated:completion:))
      
      let originalMethod = class_getInstanceMethod(self, originalSelector)
      let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
      
      let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
      
      if didAddMethod{
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
      }else{
        if originalMethod != nil {
          method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
      }
    }
  }
  
  @objc fileprivate func noAlert_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
    //判断是否是alert弹窗
    if viewControllerToPresent.isKind(of: UIAlertController.self) {
      print("title: \(String(describing: (viewControllerToPresent as? UIAlertController)?.title))")
      print("message: \(String(describing: (viewControllerToPresent as? UIAlertController)?.message))")
      
      // 换图标时的提示框的title和message都是nil，由此可特殊处理
      let alertController = viewControllerToPresent as? UIAlertController
      if alertController?.title == nil && alertController?.message == nil {
        //是更换icon的提示
        changeAction()
        return
      } else {
        //其他的弹框提示正常处理
        noAlert_present(viewControllerToPresent, animated: flag, completion: completion)
      }
    }
    noAlert_present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
  func changeAction(){
    print("change success")
  }
}

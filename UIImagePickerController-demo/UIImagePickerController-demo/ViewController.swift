//
//  ViewController.swift
//  UIImagePickerController-demo
//
//  Created by nswbmw on 2018/5/14.
//  Copyright © 2018年 nswbmw. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var editSwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //选取相册
  @IBAction func fromAlbum(_ sender: AnyObject) {
    //判断设置是否支持图片库
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      //初始化图片控制器
      let picker = UIImagePickerController()
      //设置代理
      picker.delegate = self
      //指定图片控制器类型
      picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
      //设置是否允许编辑
      picker.allowsEditing = editSwitch.isOn
      
      //弹出控制器，显示界面
      self.present(picker, animated: true, completion: {
        () -> Void in
      })
    }else{
      print("读取相册错误")
    }
    
  }
  
  //选择图片成功后代理
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    //查看info对象
    print(info)
    
    //显示的图片
    let image:UIImage!
    if editSwitch.isOn {
      //获取编辑后的图片
      image = info[UIImagePickerControllerEditedImage] as! UIImage
    }else{
      //获取选择的原图
      image = info[UIImagePickerControllerOriginalImage] as! UIImage
    }
    
    imageView.image = image
    //图片控制器退出
    picker.dismiss(animated: true, completion: {
      () -> Void in
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

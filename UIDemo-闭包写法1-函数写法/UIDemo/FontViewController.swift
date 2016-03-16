//
//  FontViewController.swift
//  UIDemo
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import Foundation
import UIKit

// oc-->
// @objc  UIDemo-Swift.h Swift项目内部会存放一个 XXX-Swift.h
class FontViewController : UIViewController {
    // 定义一个协议对象
    var fontSize :Int = 20;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor();
        
        let rect3 = CGRect(x:0, y:300, width:320, height:44);
        var button2 = UIButton.buttonWithType(.System) as UIButton;
        button2.frame = rect3;
        button2.setTitle("增加字体大小", forState:.Normal);
        button2.addTarget(self, action:"clickMe:", forControlEvents:.TouchUpInside);
        button2.tag = 100;
        self.view.addSubview(button2);
    }
    func clickMe(b:UIButton) {
        fontSize++;
        saveCb?();
        saveCb2?(fontSize);
        saveCb3?(controller:self, fontSize:fontSize);
        let ret = saveCb4?(controller:self, fontSize:fontSize, withColor:UIColor.redColor());
        if (ret) {
            println("is true");
        }
    }
    // 申明闭包 (  () -> ()    )
    var saveCb : (  () -> ()   )?;
    // closure函数
    // () -> () 是一个参数void 返回值void的闭包
    func setCallback( cb : () -> () ) {
        // cb要存起来
        saveCb = cb; // 把cb存放在saveCb中
        // 保存
    }
    var saveCb2 : (  (Int)->() )?
    func setCallback2(cb : (Int)->()) {
        saveCb2 = cb;
    }
    var saveCb3 : ( (controller:FontViewController, fontSize:Int)->()  )?;
    func setCallback3(cb: (controller: FontViewController, fontSize:Int ) -> ()) {
        saveCb3 = cb;
    }
    var saveCb4 : ( ( controller:FontViewController,
                fontSize:Int, withColor:UIColor )->(Bool) )?
    func setCallback4(cb: ( controller:FontViewController,
        fontSize:Int, withColor:UIColor )->(Bool) ) {
            saveCb4 = cb;
    }
}

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
@objc protocol FontViewControllerDelegate : NSObjectProtocol {
    @optional func fontViewController(controller:FontViewController, fontColor:UIColor, fontSize:Int);
    @optional func fontViewController(controller:FontViewController, fontColor:UIColor);
    // require
    func fontViewController(controller:FontViewController, fontSize:Int);
}
class FontViewController : UIViewController {
    // 定义一个协议对象
    var delegate :FontViewControllerDelegate?;
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
        delegate?.fontViewController(self, fontSize:fontSize);
    }
}

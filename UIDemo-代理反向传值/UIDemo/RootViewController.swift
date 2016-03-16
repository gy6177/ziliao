//
//  RootViewController.swift
//  UIDemo
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, FontViewControllerDelegate {
    var counter : Int = 0;

//    init() {
//        super.init(nibName:nil, bundle:nil);
//    }
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        // Custom initialization
//    }

    // 全局变量一定要初始化 除非在构造中主动初始化
    var label:UILabel?;
    // 如果继承一个基类的方法 那么需要写上了个 override
    // 之类要重写方法 那么需要明确写override
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGrayColor();

        let rect = CGRect(x:0, y:100, width:320, height:44);
        label = UILabel(frame:rect);
        label!.text = "ios/swift千锋";
        let font = UIFont.systemFontOfSize(30.0);
        label!.font = font;
        self.view.addSubview(label);
        
        let rect2 = CGRect(x:0, y:200, width:320, height:44);
        let button = UIButton(frame:rect2);
        // alloc] initWithFrame
        // .Normal 系统会自动的补上  UIControlState 
        // 就是Swift中的名字空间namespace
        button.setTitle("点击我", forState:.Normal);
        button.addTarget(self, action:"clickMe:", forControlEvents:.TouchUpInside);
        button.tag = 2;
        self.view.addSubview(button);
        
        let rect3 = CGRect(x:0, y:300, width:320, height:44);
        var button2 = UIButton.buttonWithType(.System) as UIButton;
        button2.frame = rect3;
        button2.setTitle("Label计数器+1", forState:.Normal);
        button2.addTarget(self, action:"clickMe:", forControlEvents:.TouchUpInside);
        button2.tag = 100;
        self.view.addSubview(button2);
        
        addNavItem();
    }
    func addNavItem() {
        //     init(title: String!, style: UIBarButtonItemStyle, target: AnyObject!, action: Selector)

        let nextPage = UIBarButtonItem(title:"选择字体", style:.Plain, target:self, action:"gotoNextPage");
        self.navigationItem.rightBarButtonItem = nextPage;
        // Swift--->OC-->Binary
        // Swift -->OC
    }
    func gotoNextPage() {
        let fvc = FontViewController();
        // 直接修改fvc 成员变量
        fvc.delegate = self;
        self.navigationController.pushViewController(fvc, animated:true);
    }
    // 协议的实现...
    func fontViewController(controller:FontViewController, fontSize:Int) {
        println("font controller size is \(fontSize)");
        label!.font = UIFont.systemFontOfSize(Float(fontSize));
    }

    func clickMe(sender:UIButton) {
        counter++;
        println("button is \(sender) count = \(counter)");
        if (sender.tag == 100) {
            label!.text = "ios/swift千锋\(counter)";
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

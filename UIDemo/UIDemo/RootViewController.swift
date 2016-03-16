//
//  RootViewController.swift
//  UIDemo
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
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
    
    func gotoNextPageTailClosure() {
        let fvc = FontViewController();
        fvc.setCallback() {
            () -> () in
            println("change font size");
        };
        fvc.setCallback2() {
            (fontSize : Int) -> () in
            println("change font2 size \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            };
        
        fvc.setCallback3() {
            (controller: FontViewController, fontSize:Int) -> () in
            println("font controller size is \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            };
        
        fvc.setCallback4("hello /swift"){
            (controller:FontViewController, fontSize:Int, color:UIColor)->Bool in
            println("font controller size is \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            return true;
            };
        
        // 直接修改fvc 成员变量
        self.navigationController.pushViewController(fvc, animated:true);
    }

    // 尾部闭包 tail Closure.
    // 闭包是作为参数的最后一个参数 尾部闭包
    func gotoNextPage() {
        let fvc = FontViewController();
        fvc.setCallback({
            () -> () in
            println("change font size");
            });
        fvc.setCallback2({
            (fontSize : Int) -> () in
            println("change font2 size \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            });
        
        fvc.setCallback3({
            (controller: FontViewController, fontSize:Int) -> () in
            println("font controller size is \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            });
        
        fvc.setCallback4("ios/swift") {
            (controller:FontViewController, fontSize:Int, color:UIColor)->Bool in
            println("font tail closure is \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            return true;
            };
        
        // 直接修改fvc 成员变量
        self.navigationController.pushViewController(fvc, animated:true);
    }

    func gotoNextPageWithoutParameter() {
        let fvc = FontViewController();
        fvc.setCallback({
            println("change font size");
            });
        fvc.setCallback2({
            var fontSize = $0; //$0表示第0个参数
            println("change font2 size \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            });
        
        fvc.setCallback3({
            let controller = $0;
            let fontSize = $1;
            println("font controller size is \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            });
        // autolayout/massory
        fvc.setCallback4("value", {
            let controller = $0;
            let fontSize = $1;
            let color = $2;
            println("font controller size is \(fontSize)");
            self.label!.font = UIFont.systemFontOfSize(Float(fontSize));
            return true;
            });

        // 直接修改fvc 成员变量
        self.navigationController.pushViewController(fvc, animated:true);
    }
    func changeFontSize2(fontSize:Int) {
        println("change font2 size \(fontSize)");
        label!.font = UIFont.systemFontOfSize(Float(fontSize));
    }

    // 参数是 void, 返回值是void
    func changeFontSize() {
        println("change font size");
    }
    
    func fontViewController2(controller:FontViewController,
        fontSize:Int, withColor:UIColor) -> Bool {
        println("font controller size is \(fontSize)");
        label!.font = UIFont.systemFontOfSize(Float(fontSize));
        return true;
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

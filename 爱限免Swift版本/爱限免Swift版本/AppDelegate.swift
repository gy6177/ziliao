//
//  AppDelegate.swift
//  爱限免Swift版本
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        
        // 定义一个数组 Array =~ NSMutableArray
        // NSMutableArray, NSDictionary, NSString.
        let titleArray = ["限免","降价","免费","主题","热榜"];
        let iconNormalArray = ["tabbar_limitfree",
        "tabbar_reduceprice",
        "tabbar_appfree",
        "tabbar_subject",
        "tabbar_rank"];
        let iconSelectedArray = ["tabbar_limitfree_press",
        "tabbar_reduceprice_press",
        "tabbar_appfree_press",
        "tabbar_subject_press",
        "tabbar_rank_press"];
        
        let tabbar = UITabBarController();
        
        var vcArray = NSMutableArray();
        // titleArray.count 数组的长度
        for(var i = 0 ; i<titleArray.count ; i++)
        {
            if(i == 3)
            {
                let proVc = ProViewController()
                let navi = UINavigationController(rootViewController:proVc);
                let barItem = UITabBarItem(title: titleArray[i], image: UIImage(named: iconNormalArray[i]), selectedImage: UIImage(named: iconSelectedArray[i]));
                navi.tabBarItem = barItem;
                vcArray.addObject(navi);
                continue;
            }
            // 创建一个RootViewController
            let root = RootViewController(type:i);
            let navi = UINavigationController(rootViewController:root);
            let barItem = UITabBarItem(title: titleArray[i],
                image: UIImage(named: iconNormalArray[i]),
                selectedImage: UIImage(named: iconSelectedArray[i]));
            navi.tabBarItem = barItem;
            // vcArray是给TabBarController的一个数组
            vcArray.addObject(navi);
        }
        tabbar.viewControllers = vcArray;
        self.window!.rootViewController = tabbar;
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


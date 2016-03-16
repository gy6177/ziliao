//
//  CollectionViewController.swift
//  爱限免Swift版本
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController : UIViewController
{
    var appArray:NSArray?
    override func viewDidLoad()
    {
        super.viewDidLoad();
        self.navigationItem.title="我的收藏";
        self.view.backgroundColor = UIColor.whiteColor();
        
        let dbm: DBManager = DBManager.sharedManager() as DBManager;
        appArray = dbm.fetchAllData();
        println(appArray!);
        for(var i = 0 ; i < appArray!.count ; i++)
        {
            let model = appArray![i] as AppModel;
            println(model.applicationId)
            let button = UIButton.buttonWithType(.System) as UIButton;
            button.frame = CGRectMake(CGFloat(15 + 100 * (i % 3)),CGFloat(15 + 120 * (i / 3)), 90, 110);
            self.view.addSubview(button);
            button.backgroundColor = UIColor.whiteColor();
            button.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside);
            button.tag = 100 + i;
            
            let iconImgView = UIImageView(frame:CGRectMake(15,5,60,60));
            button.addSubview(iconImgView);
            iconImgView.setImageWithURL(NSURL(string:model.iconUrl));
            
            let nameLabel = UILabel(frame:CGRectMake(0,70,90,30));
            nameLabel.text = model.name;
            nameLabel.font = UIFont.systemFontOfSize(12);
            button.addSubview(nameLabel);
            nameLabel.numberOfLines = 2;
            nameLabel.textAlignment = .Center;
        }
        
    }
    
    func click(btn : UIButton!)
    {
        let dvc:DetailViewController? = DetailViewController();
        dvc!._model = appArray!.objectAtIndex( btn.tag - 100 ) as? AppModel;
        self.navigationController.pushViewController(dvc, animated:true);
    }
    
}




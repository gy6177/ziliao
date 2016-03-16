//
//  AppCell.swift
//  爱限免Swift版本
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import Foundation
import UIKit

// IBOutlet 主要给xib用的 
// OC Xcode3.2
// #define IBOutlet
// #define IBAction void
class AppCell : UITableViewCell
{
    @IBOutlet var iconImageView : UIImageView
    @IBOutlet var titleLabel : UILabel
    @IBOutlet var starImageView : UIImageView
    @IBOutlet var priceLabel : UILabel
    @IBOutlet var lineImageView : UIImageView
    @IBOutlet var otherLabel : UILabel
    // model的set函数支持赋值
    var model:AppModel?;
    var _starArray:NSMutableArray?;

    func fillData()
    {
        let name:String = model!.name;
        let icon:String = model!.iconUrl;
        let priceStr:String = model!.lastPrice;
        lineImageView.hidden = Tools.stringToDouble(priceStr) == 0.0;
        titleLabel.text = name;
        otherLabel.text = "分享:\(model!.shares)次  收藏:\(model!.favorites)次  下载:\(model!.downloads)次";
        // setImageWithURL SDWebImage里面的方法
        iconImageView.setImageWithURL(NSURL(string:icon));
        priceLabel.text = Tools.toPriceStr(model!.lastPrice);
        
        
        let star = CGFloat(Tools.stringToDouble( model!.starCurrent ));
        let starI=Int(star * 2);
        let oneStar = starI/2;
        for (var i=0; i<5; i++) {
            var picName = "";
            picName = i < oneStar ? "appproduct_starforeground_Topic.png" : "appproduct_starbackground_Topic.png";
            if (starI%2 != 0 && oneStar == i) {
                picName="appproduct_starforeground_half_Topic.png";
            }
            var imgView = _starArray!.objectAtIndex(i) as UIImageView;
            imgView.image = UIImage(named:picName);
        }
        
    }
    
    // Xib加载完成自动调用
    override func awakeFromNib()
    {
        iconImageView!.frame = CGRectMake(10,5,60,60);
        // 改成圆角
        iconImageView!.layer.cornerRadius = 10;
        iconImageView!.layer.masksToBounds = true
        
        _starArray = NSMutableArray();
        
        for (var i = 0.0; i < 5; i++) {
            var starImg = UIImageView(image:UIImage(named:""));
            starImg.frame = CGRectMake(CGFloat(16.4*i), 0, 16.4, 23);
            starImageView!.addSubview(starImg);
            _starArray!.addObject(starImg);
        }
    }
    
}


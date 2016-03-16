//
//  DetailViewController.swift
//  爱限免Swift
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import Foundation
import UIKit

// autolayout, massory第三方开源库
class DetailViewController : UIViewController
{
    var _dataDic:NSDictionary?
    var _activityView:UIActivityIndicatorView?
    var _mainScrollView:UIScrollView?;
    var _infoView:UIView?
    
    var _model:AppModel?
    var isExists:Bool?;
    override func viewDidLoad()
    {
        super.viewDidLoad();
        self.title = "应用详情页"
        self.view.backgroundColor=UIColor.whiteColor();
        
        //
        _activityView = UIActivityIndicatorView(activityIndicatorStyle:.Gray);
        _activityView!.center = self.view.center;
        self.view.addSubview(_activityView);
        _activityView!.startAnimating();
        
        // DBManager.sharedManager()是一个单例single instance
        isExists = false;
        let dbm:DBManager = DBManager.sharedManager() as DBManager;
        isExists = dbm.isExists(_model);
        
        _mainScrollView = UIScrollView(frame:CGRectMake(0, 0, 320, self.view.frame.size.height-64-49));
        self.view.addSubview(_mainScrollView);
        loadData();
    }
    
    func loadData()
    {
        let url = "\(Host)/api/app.php?appId=\(_model!.applicationId)";
        println("url is \(url)");
        //缓存处理
        let cm = CacheManager.sharedManager() as CacheManager;
        // 取得json数据缓存对象
        // isCacheExist是否有
        if( cm.isCacheExist(url) )
        {
            //取缓存
            let data = cm.getCacheWithType(url);
            // 取得data 数据 缓存数据
            // NSJSONSerialization json解析器
            let result:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil);
            self._dataDic = result as? NSDictionary;
            self._activityView!.stopAnimating();
            self.uiConfig();
        }
        else
        {
            //否则,发起请求
            //AFNetWorking
            var operation:AFJSONRequestOperation = AFJSONRequestOperation.JSONRequestOperationWithRequest(
                NSURLRequest(URL: NSURL(string:url)),
                success: { (req:NSURLRequest!,res:NSHTTPURLResponse!,json:AnyObject!) in
                    //数据下载完成后,保存到缓存
                    let cm = CacheManager.sharedManager() as CacheManager;
                    let data:NSData = NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted, error: nil);
                    cm.saveCache(data, withType:url);
                    //保存缓存完成
                    self._dataDic = json as? NSDictionary;
                    self._activityView!.stopAnimating();
                    self.uiConfig();
                } ,
                failure: {(request:NSURLRequest!,response:NSHTTPURLResponse!,  error:NSError!,json:AnyObject!) in
                    println("下载失败 \(error)")
                }
            );
            operation.start();
        }
        
        
        
    }
    
    func uiConfig()
    {
        var infoHeight = appInfoConfig();
        var roundHeight = roundApp(infoHeight + 20);
        _mainScrollView!.contentSize = CGSizeMake(320, CGFloat(infoHeight + roundHeight) + 20);
    }

    func roundApp(startY: Int) -> Int
    {
        let y = 10 + startY
        var roundView = UIImageView(frame:CGRectMake(10, CGFloat(y), 300, 100))
        roundView.image = UIImage(named:"appdetail_recommend");
        _mainScrollView!.addSubview(roundView);
        roundView.userInteractionEnabled=true;
        return  120;
    }

    func appInfoConfig() -> Int
    {
        _infoView = UIView(frame:CGRectMake(10, 10, 300, 100));
        _mainScrollView!.addSubview(_infoView);
        _infoView!.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1);
        _infoView!.layer.cornerRadius=10;
        _infoView!.layer.shadowOffset=CGSizeMake(3, 4);
        _infoView!.layer.shadowColor=UIColor.lightGrayColor().CGColor;
        
        let height1 = drawHeader(5);
        let height2 = drawButtons(height1 + 5);
        let height3 = drawPics(height1 + height2 + 5);
        let height4 = drawDesc(height1 + height2 + height3 + 5);
        let wholeHeight = height1 + height2 + height3 + height4 ;
        _infoView!.frame = CGRectMake(10, 10, 300, CGFloat(wholeHeight));
        return wholeHeight;
    }

    func drawHeader(startY : Int) -> Int
    {

        let detailInfoView = UIView(frame:CGRectMake(0, CGFloat(startY), 300, 80));
        _infoView!.addSubview(detailInfoView);
        
        let imgView = UIImageView(frame:CGRectMake(10, 10, 60, 60));
        imgView.layer.cornerRadius = 5;
        imgView.layer.masksToBounds = true;
        imgView.setImageWithURL(NSURL(string:_dataDic!["iconUrl"] as String));
        detailInfoView.addSubview(imgView);
        
        let titleLabel = UILabel(frame:CGRectMake(80, 8, 220, 20));
        titleLabel.text = _dataDic!["name"] as String;
        titleLabel.font = UIFont.boldSystemFontOfSize(16);
        titleLabel.backgroundColor = UIColor.clearColor();
        titleLabel.textColor = UIColor.blackColor();
        detailInfoView.addSubview(titleLabel);

        let lastPrice:String = _dataDic!["lastPrice"] as String;
        let fileSize:String = _dataDic!["fileSize"] as String;
        let starCurrent:String = _dataDic!["starCurrent"] as String;
        let categoryName:String = _dataDic!["categoryName"] as String;
        let showStr = "原价:¥\(lastPrice)  限免中  \(fileSize)MB\n类型:\(categoryName)  评价:\(starCurrent)"
        let detailLabel = UILabel(frame:CGRectMake(80, 30, 220, 40));
        detailInfoView.addSubview(detailLabel);
        detailLabel.text = showStr;
        detailLabel.font = UIFont.systemFontOfSize(12);
        detailLabel.textColor = UIColor.grayColor();
        detailLabel.numberOfLines = 2;
        
        return 80;
    }
    
    func drawButtons(startY : Int) -> Int
    {
        let btnView = UIView(frame:CGRectMake(0,CGFloat(startY),280,42));
        _infoView!.addSubview(btnView);
        
        var titleArray = ["分享", "收藏","下载"];
        var backPicArray = ["Detail_btn_left","Detail_btn_middle","Detail_btn_right"];
        if(isExists! == true)
        {
            titleArray = ["分享", "已收藏" ,"下载"];
            backPicArray = ["Detail_btn_left","","Detail_btn_right"];
        }
        let x = [0,99.5,199];
        for(var i = 0 ; i < 3 ; i++)
        {
            var button = UIButton.buttonWithType(.Custom) as UIButton;
            button.frame = CGRectMake( x[i] as CGFloat , 0, 99.5, 42 ) ;
            button.setBackgroundImage(UIImage(named:backPicArray[i] as String), forState: .Normal);
            button.setTitle(titleArray[i] as String ,forState:.Normal);
            button.tag = i+150;
            button.font = UIFont.systemFontOfSize(14);
            button.setTitleColor(UIColor.purpleColor(), forState:.Normal);
            btnView.addSubview(button);
            button.addTarget(self,action:"click:",forControlEvents:.TouchUpInside);
        }
        return 42;
    }

    func drawPics(startY : Int) -> Int
    {
        let scrollView = UIScrollView(frame:CGRectMake(10, CGFloat(startY+5) , 280, 70));
        _infoView!.addSubview(scrollView);
    
        let picArray:NSArray = _dataDic!["photos"] as NSArray;
        for(var i = 0 ; i < picArray.count ; i++)
        {
            let imgView = UIImageView(frame:CGRectMake(CGFloat(i*60), 0, 50, 70));
            scrollView.addSubview(imgView);
            let dic:NSDictionary = picArray.objectAtIndex(i) as NSDictionary;
            imgView.setImageWithURL(NSURL(string:dic["smallUrl"] as String));
        }
        scrollView.contentSize = CGSizeMake(CGFloat(60*picArray.count-10), 70);
        return 80;
    }

    func drawDesc(startY : Int) -> Int
    {
        let descStr:String! = _dataDic!["description"] as String;
        let font:UIFont = UIFont.systemFontOfSize(12);
        let size : CGSize = Tools.sizeOfStr(descStr, andFont:font ,andMaxSize: CGSizeMake(270,99999), andLineBreakMode:.ByWordWrapping);
        let descLabel = UILabel(frame:CGRectMake(15, CGFloat(startY+10), 270, size.height));
        descLabel.font = font;
        descLabel.lineBreakMode = .ByWordWrapping;
        descLabel.text = descStr;
        descLabel.numberOfLines = 0;
        _infoView!.addSubview(descLabel);
        return Int(size.height + 20);
    }

    func click(btn : UIButton)
    {
        switch (btn.tag)
            {
        case 150:
            //分享
            break;
        case 151:
            //收藏
            let dbm:DBManager = DBManager.sharedManager() as DBManager;
            if(isExists! == true)
            {
                dbm.deleteData(_model);
                isExists = false;
                btn.setTitle("收藏", forState:.Normal);
                btn.setBackgroundImage(UIImage(named:"Detail_btn_middle"), forState:.Normal);
            }
            else
            {
                dbm.insertData(_model);
                isExists = true;
                btn.setTitle("已收藏", forState:.Normal);
                btn.setBackgroundImage(UIImage(named:""), forState:.Normal);
            }
            
            break;
        case 152:
            //下载
            let itunesUrl = _dataDic!["itunesUrl"] as String;
            UIApplication.sharedApplication().openURL(NSURL(string:itunesUrl));
            break;
        default:
            break;
        }
    }
    

}


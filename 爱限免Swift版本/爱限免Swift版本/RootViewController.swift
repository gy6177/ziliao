//
//  RootViewController.swift
//  爱限免Swift
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import Foundation
import UIKit

// 定义一个常量
//let Host = "http://192.168.88.10/app/qfts/iAppFree";
let Host = "http://192.168.77.12/app/qfts/iAppFree";

class URLObjc : NSObject
{
    var page:Int?;
    var currentType:Int?;
    
    func getUrl() -> String!
    {
        var str = "";
        switch (currentType!) {
        case 0:
            str = "\(Host)/api/limited.php?page=\(page!)";
            break;
        case 1:
            str = "\(Host)/api/reduce.php?page=\(page!)";
            break;
        case 2:
            str = "\(Host)/api/free.php?page=\(page!)";
            break;
        case 4:
            str = "\(Host)/api/hot.php?page=\(page!)";
            break;
        default:
            break;
        }
        return str;
    }
}

class RootViewController : UIViewController , UITableViewDelegate , UITableViewDataSource , NSURLConnectionDataDelegate{
    var type:Int?;
    var _url:URLObjc?;
    var _tableView : UITableView?;
    var _dataArray : NSMutableArray?;
    var _data : NSMutableData?
    override func viewDidLoad()
    {
        super.viewDidLoad();
        // 界面入口函数
        let titleArray = ["限免","降价","免费","主题","热榜"];
        self.navigationItem.title = titleArray[type!];
        self.navigationController.navigationBar.translucent = false;
        
        prepareData();
        uiConfig();
    }
    // 构造函数 有一个参数 当前界面的分类
    init(type : Int)
    {
        super.init(nibName:nil, bundle: nil);
        self.type = type;
    }
    
    func prepareData()
    {
        //
        _data = NSMutableData();
        _dataArray = NSMutableArray();
        // 创建一个URLObjc
        _url = URLObjc();
        _url!.page = 1;
        _url!.currentType = type;
        // 准备好第几页和第几类
        // 网络请求数据
        loadData();
    }
    
    func uiConfig()
    {
        let item = UIBarButtonItem(title: "我的收藏", style: .Plain, target: self, action: "myCollection");
        self.navigationItem.rightBarButtonItem = item;
        // 创建一个TableView
        let frame:CGRect = CGRectMake(0, 0, 320, self.view.bounds.size.height-64);
        _tableView = UITableView(frame:frame , style:.Plain);
        self.view.addSubview(_tableView);
        _tableView!.delegate = self;
        _tableView!.dataSource = self;
    }
    
    func myCollection()
    {
        let colVC:CollectionViewController  = CollectionViewController();
        self.navigationController.pushViewController(colVC, animated:true);
    }
    
    func loadNextPage()
    {
        var p:Int = _url!.page!;
        p = p + 1
        _url!.page = p ;
        loadData();
    }
    
    var _myconnection: NSURLConnection?;
    var _recvData:NSMutableData?;
    func loadDataWithURLConnection() {
        let url = NSURL(string: _url!.getUrl());
        let r = NSURLRequest(URL:url);
        _myconnection = NSURLConnection(request:r, delegate:self);
    }
     func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        _recvData = NSMutableData();
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        _recvData!.appendData(data);
    }
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // json解析
        
    }
    

    func loadData()
    {
//        let _connection:NSURLConnection? = NSURLConnection(request: NSURLRequest(URL: NSURL(string : _url!.getUrl())), delegate: self)
        
        let url = NSURL(string : _url!.getUrl());
        let request:NSURLRequest = NSURLRequest(URL:url);
        // Swift no/Blocks Closure闭包
        //调用AFNetWorking的方法,能用闭包closure
        //列表页没有做缓存
        // AFJSONRequestOperation下载并且json解析
        // application/json 
        // AFNetworking/ASI
        var operation:AFJSONRequestOperation = AFJSONRequestOperation.JSONRequestOperationWithRequest(
            request,
            success: { (req:NSURLRequest!, res:NSHTTPURLResponse!, json:AnyObject!) in
                //在闭包中调用外部类的属性需要用self.
                //addObjectsFromArray(otherArray: AnyObject[]!)
                // AFNetworking下载完成的闭包函数
                 self._dataArray!.addObjectsFromArray(AppModel.parsingJsonData(json));
                //  刷新表
                self._tableView!.reloadData()
            } ,
            failure: {
                (request:NSURLRequest!, response:NSHTTPURLResponse!, error:NSError!,json:AnyObject!) in
                println("下载失败 \(error)");
            }
        );
        // 开始在下载
        operation.start();
        
    }
    
    // 行高
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
        return indexPath.row == _dataArray!.count ? 44 : 100
    }
    // 选中点击cell中
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if( indexPath.row == _dataArray!.count )
        {
            // 点击了加载更多
            // deselectRowAtIndexPath取消点击
            tableView.deselectRowAtIndexPath(indexPath, animated:true)
            loadNextPage();
            return;
        }
        // 创建一个详情页面
        let dvc:DetailViewController = DetailViewController();
        // _dataArray!.objectAtIndex(indexPath.row)
        // 从NSMutableArray中取得第 indexPath.row元素 AnyObject
        dvc._model = _dataArray!.objectAtIndex(indexPath.row) as? AppModel;
        self.navigationController.pushViewController(dvc, animated:true);
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    
    // cellForRow
    // 返回值是一个 UITableViewCell
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        if( indexPath.row == _dataArray!.count )
        { // 表示处理最后一行 加载更多
            let cellId:String! = "loadmorecellid";
            var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell;
            if(cell == nil)
            {
                cell = UITableViewCell(style: .Default, reuseIdentifier: cellId);
            }
            // cell显然是系统缺省的cell 不是定制的
            cell!.text = "加载更多"
            return cell;
        }
        
        // 定制cell
        let cellId:String = "cellid";
        var cell:AppCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? AppCell;
        if(cell == nil)
        { // 通过AppCell.xib来加载 lastObject
            cell = NSBundle.mainBundle().loadNibNamed("AppCell"
                ,owner:self ,options:nil)[0] as? AppCell;
        }
        // 取得数据模型
        var model:AppModel? = _dataArray!.objectAtIndex(indexPath.row) as? AppModel;
        // 给cell放一个model
        cell!.model = model
        cell!.fillData();
        
        return cell;
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return _dataArray!.count + 1;
    }
    
    /////////////////////////
    
//    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
//    {
//        _data!.length = 0
//    }
//    
//    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
//    {
//        _data!.appendData(data);
//    }
//    
//    func connectionDidFinishLoading(connection: NSURLConnection!)
//    {
//        _dataArray = AppModel.parsingJsonData(_data)
//        _tableView!.reloadData()
//    }
    
    
}





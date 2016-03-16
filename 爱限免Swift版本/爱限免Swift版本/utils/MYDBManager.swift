//
//  DBManager.swift
//  爱限免Swift版本
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

import Foundation

var sharedInstance: MYDBManager?;
class MYDBManager : NSObject
{
    class func sharedInstance() -> MYDBManager {
        struct saveDb {
            static var saveInstance:MYDBManager?;
        }
        if (saveDb.saveInstance == nil) {
            saveDb.saveInstance = MYDBManager();
        }
        return saveDb.saveInstance!;
    }

    // 类方法
    class func sharedDBM() -> MYDBManager
    {
        struct myDBM {
            // 2个变量和结构体没关系 类方法
            static var once : dispatch_once_t = 0
            static var instance : MYDBManager? = nil
        }
        if(myDBM.instance == nil)
        {
            // dispatch_once gcd多线程一个函数
            dispatch_once(&myDBM.once,
                 {
                    // 闭包
                myDBM.instance = MYDBManager()
                }
            )
        }
        return myDBM.instance!
    }
//创建表总是失败,可变长参数不知道怎么用
    init()
    {
        let dbPath = "\(NSHomeDirectory())/Documents/app.db"
        // FMDatabase.databaseWithPath(dbPath)
        // 以dbPath为路径创建一个数据库
        let _fmdb : FMDatabase = FMDatabase.databaseWithPath(dbPath) as FMDatabase;
        if(_fmdb.open())
        {
            // 定义一个sql语句
            let sqlStr:String! = "create table if not exists myapp(id integer primary autoincrement,name varchar(256) )";
            println(dbPath)
            // 执行这个sql语句 fmdb
            let success:Bool = _fmdb.executeUpdate(sqlStr, withParameterDictionary:nil)
            if(success)
            {
                println("创建表成功")
            }
            else
            {
                println("创建表失败")
            }
        }
        else
        {
            println("数据库打开失败")
        }
    }
}


//
//  DBManager.m
//  数据库-通讯录
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
@implementation DBManager
{
    FMDatabase *_dataBase;
}

static DBManager *dbm;
+(id)sharedManager
{
    @synchronized(self)
    {
        if (!dbm) {
            dbm = [[DBManager alloc]init];
        }
    }
    return dbm;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *dbPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/app.db"];
        _dataBase = [[FMDatabase alloc]initWithPath:dbPath];
        BOOL isOpenSuccess=[_dataBase open];
        if (isOpenSuccess) {
            NSString *createTableSql=@"create table if not exists app(id integer primary key autoincrement,appid varchar (32),name varchar (128),iconUrl varchar (256))";
            BOOL creteTableSuccess=[_dataBase executeUpdate:createTableSql];
            if (!creteTableSuccess) {
                NSLog(@"create error:%@",_dataBase.lastErrorMessage);
            }
        }
    }
    return self;
}

-(void)insertData:(AppModel *)model
{
    NSString *insertSql=@"insert into app (appid,name,iconUrl) values(?,?,?)";
    BOOL isSuccess=[_dataBase executeUpdate:insertSql,model.applicationId,model.name,model.iconUrl];
    if (!isSuccess) {
        NSLog(@"insert error:%@",_dataBase.lastErrorMessage);
    }
}

-(void)deleteData:(AppModel *)model
{
    NSString *deleteSql=@"delete from app where appid=?";
    BOOL isSuccess=[_dataBase executeUpdate:deleteSql, model.applicationId];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_dataBase.lastErrorMessage);
    }
}

-(NSMutableArray *)fetchAllData
{
    NSMutableArray *dataArray=[[NSMutableArray alloc]init];
    NSString *selectSql=@"select * from app";
    FMResultSet *set=[_dataBase executeQuery:selectSql];
    while ([set next]) {
        NSString *appId=[set stringForColumn:@"appid"];
        AppModel *p=[[AppModel alloc]init];
        p.applicationId = appId;
        p.name = [set stringForColumn:@"name"];
        p.iconUrl = [set stringForColumn:@"iconUrl"];
        [dataArray addObject:p];
    }
    
    return dataArray;
}

-(BOOL)isExists:(AppModel *)model
{
    NSString *sql=@"select * from app where appid = ?";
    FMResultSet *set = [_dataBase executeQuery:sql,model.applicationId];
    if ([set next]) {
        return YES;
    }
    return NO;
}


@end









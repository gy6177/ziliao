//
//  DBManager.h
//  数据库-通讯录
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppModel.h"

@interface DBManager : NSObject

+(id)sharedManager;

-(void)insertData:(AppModel *)model;

-(void)deleteData:(AppModel *)model;

-(NSMutableArray *)fetchAllData;

-(BOOL)isExists:(AppModel*)model;

@end



















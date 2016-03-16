//
//  CacheManager.h
//  爱限免项目
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5Addition.h"
@interface CacheManager : NSObject

+(id)sharedManager;

//是否有缓存
-(BOOL)isCacheExist:(NSString *)type;

//取缓存
-(NSData *)getCacheWithType:(NSString *)type;

//写缓存
-(void)saveCache:(NSData *)data withType:(NSString *)type;

//缓存首页
-(void)saveCache:(NSData *)data withType:(NSString *)type andPage:(NSInteger)page;

//取得首页的缓存
//返回数据NSData
//返回已经保存的缓存页码
-(NSDictionary *)getRootCacheWithType:(NSString *)type;


@end















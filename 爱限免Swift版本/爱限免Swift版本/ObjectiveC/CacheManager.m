//
//  CacheManager.m
//  爱限免项目
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
{
    NSString *_cachePath;
}
static CacheManager *cm;
+(id)sharedManager
{
    if (!cm) {
        cm = [[CacheManager alloc]init];
    }
    return cm;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cachePath = [NSString stringWithFormat:@"%@/Documents/mycache",NSHomeDirectory()];
        NSFileManager *fm=[NSFileManager defaultManager];
        if (![fm fileExistsAtPath:_cachePath]) {
            [fm createDirectoryAtPath:_cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

//是否有缓存
-(BOOL)isCacheExist:(NSString *)type
{
    NSFileManager *fm=[NSFileManager defaultManager];
    return [fm fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", _cachePath, [type stringFromMD5]]];
}

//取缓存
-(NSData *)getCacheWithType:(NSString *)type
{
    return [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", _cachePath, [type stringFromMD5]]];
}

//写缓存
-(void)saveCache:(NSData *)data withType:(NSString *)type
{
    NSString *dataFile=[NSString stringWithFormat:@"%@/%@", _cachePath , [type stringFromMD5]];
    [data writeToFile:dataFile atomically:YES];
}

-(void)saveCache:(NSData *)data withType:(NSString *)type andPage:(NSInteger)page
{
    //取出原来的数据
    NSData *oldData=[self getCacheWithType:[type stringFromMD5]];
    if (oldData) {
        //已经存在
        id result=[NSJSONSerialization JSONObjectWithData:oldData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic=(NSDictionary *)result;
        NSMutableArray *arr=(NSMutableArray *)[dic objectForKey:@"applications"];
        
        //将新的数据加到原数据上
        NSDictionary *newDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *newArr=[newDic objectForKey:@"applications"];
        
        
        [arr addObjectsFromArray:newArr];
        NSMutableDictionary *savedDic=[[NSMutableDictionary alloc]init];
        [savedDic setObject:arr forKey:@"applications"];
        NSData *newData=[NSJSONSerialization dataWithJSONObject:savedDic options:NSJSONWritingPrettyPrinted error:nil];
        
        //保存数据
        [self saveCache:newData withType:[type stringFromMD5]];
    }
    else
    {
        [self saveCache:data withType:[type stringFromMD5]];
    }
    
    
    //保存新的页数
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:[NSNumber numberWithInteger:page] forKey:[type stringFromMD5]];
    [def synchronize];
}

-(NSDictionary *)getRootCacheWithType:(NSString *)type
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    //存放NSData
    NSData *data=[self getCacheWithType:[type stringFromMD5]];
    [dic setObject:data forKey:@"data"];
    //存放页数
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSNumber *num=[def objectForKey:[type stringFromMD5]];
    [dic setObject:num forKey:@"page"];
    return dic;
}





@end








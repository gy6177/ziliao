//
//  AppModel.m
//  爱限免项目
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel

// 把data字典里面的键值对全部解析放在AppModel里面 然后把AppModel存在returnArray中
+(NSMutableArray *)parsingJsonData:(id)data
{
    id result=data;
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic=(NSDictionary *)result;
        NSArray *arr= [dic objectForKey:@"applications"];
        NSMutableArray *returnArray=[[NSMutableArray alloc]init];
        for (NSDictionary *subDic in arr) {
            AppModel *model=[[AppModel alloc]init];
            [model setValuesForKeysWithDictionary:subDic];
            [returnArray addObject:model];
        }
        return returnArray;
    }
    return nil;
}


@end














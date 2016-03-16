//
//  Tools.m
//  爱限免Swift版本
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import "Tools.h"

//有些功能在swift里面没找到,所以只能用oc的方法了
@implementation Tools

+(double)stringToDouble:(NSString *)str
{
    return [str doubleValue];
}

+(NSString *)toPriceStr:(NSString *)str
{
    float f = [str floatValue];
    return [NSString stringWithFormat:@"%.2f",f];
}

+(CGSize)sizeOfStr:(NSString *)str andFont:(UIFont *)font andMaxSize:(CGSize)size andLineBreakMode:(NSLineBreakMode)mode
{
    NSLog(@"版本号:%f",[[[UIDevice currentDevice]systemVersion]doubleValue]);
    CGSize s;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue]>=7.0) {
        NSLog(@"ios7以后版本");
        NSDictionary *dic=@{NSFontAttributeName:font};
        dic = dic;
        NSMutableDictionary  *mdic=[NSMutableDictionary dictionary];
        [mdic setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        [mdic setObject:font forKey:NSFontAttributeName];
        s = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:mdic context:nil].size;
    }
    else
    {
        NSLog(@"ios7之前版本");
        s=[str sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return s;
}


@end

//
//  AppModel.h
//  爱限免项目
//
//  Created by yang on 14/6/14.
//  Copyright (c) 2014 北京千锋互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AppModel : NSObject

#define DefineString(key) @property (nonatomic,copy) NSString * key;

+(NSMutableArray *)parsingJsonData:(id)data;


DefineString(applicationId);
DefineString(categoryId);
DefineString(categoryName);

DefineString(currentPrice);
DefineString(description);
//DefineString(desc)
DefineString(downloads);

DefineString(expireDatetime);
DefineString(favorites);
DefineString(fileSize);

DefineString(iconUrl);
DefineString(ipa);
DefineString(itunesUrl);

DefineString(lastPrice);
DefineString(name);
DefineString(priceTrend);

DefineString(ratingOverall);
DefineString(releaseDate);
DefineString(releaseNotes);

DefineString(shares);
DefineString(slug);
DefineString(starCurrent);
DefineString(starOverall);

DefineString(updateDate);
DefineString(version);

DefineString(language);
DefineString(appType);
DefineString(id);
DefineString(sellerName);
DefineString(newversion);
DefineString(currentVersion);
DefineString(sellerId);
DefineString(systemRequirements);
DefineString(description_long);



@end

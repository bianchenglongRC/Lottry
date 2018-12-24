//
//  BaseModelObject.h
//  iOSInstaReport
//
//  Created by TCH on 15/10/29.
//  Copyright © 2015年 TCH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface BaseModelObject : JSONModel

//- (instancetype)initWithDictionary: (NSDictionary *) data;
//+ (instancetype)modelWithDictionary: (NSDictionary *) data;

-(void)assginToPropertyWithDictionary: (NSDictionary *) data;

@end

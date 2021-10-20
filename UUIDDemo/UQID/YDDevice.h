//
//  YDDevice.h
//  UQIDDemo
//
//  Created by jimzhao on 21/10/16.
//  Copyright © 2021年 jimzhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YDDevice : NSObject

//获取IDFA
+ (NSString *)getIDFA;

//获取IDFV
+ (NSString *)getIDFV;

//获取UUID
+ (NSString *)getUUID;

//获取UQID
+ (NSString *)getUQID;

@end

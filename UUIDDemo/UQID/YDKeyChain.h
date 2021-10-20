//
//  IWKeyChain.h
//  KeyChainTest
//
//  Created by jimzhao on 21/10/16.
//  Copyright © 2021年 jimzhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDKeyChain : NSObject

+ (void)saveObject:(id)object forKey:(NSString *)key;
+ (id)readObjectForKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;
+ (void)deleteAllObject;

@end

@interface SaveKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end

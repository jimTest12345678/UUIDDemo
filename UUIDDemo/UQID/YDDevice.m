//
//  YDDevice.m
//  UQIDDemo
//
//  Created by jimzhao on 21/10/16.
//  Copyright © 2021年 jimzhao. All rights reserved.
//

#import "YDDevice.h"
#import "YDKeyChain.h"
#import <AdSupport/ASIdentifierManager.h>
#import <DeviceCheck/DCDevice.h>

#define UQID_KEY @"com.device.uqid"

@implementation YDDevice

//获取IDFA
+ (NSString *)getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

//获取IDFV
+ (NSString *)getIDFV
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//获取UUID
+ (NSString *)getUUID
{
    return [[NSUUID UUID] UUIDString];
}

//获取UQID
+ (NSString *)getUQID
{
    //从本地沙盒取
    NSString *uqid = [[NSUserDefaults standardUserDefaults] objectForKey:UQID_KEY];
    
    if (!uqid) {
        //从keychain取
        uqid = (NSString *)[YDKeyChain readObjectForKey:UQID_KEY];
        
        if (uqid) {
            [[NSUserDefaults standardUserDefaults] setObject:uqid forKey:UQID_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } else {
            //从pasteboard取
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            id data = [pasteboard dataForPasteboardType:UQID_KEY];
            if (data) {
                uqid = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            
            if (uqid) {
                [[NSUserDefaults standardUserDefaults] setObject:uqid forKey:UQID_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [YDKeyChain saveObject:uqid forKey:UQID_KEY];
                
            } else {
                
                //获取idfa
                uqid = [self getIDFA];
                
                //idfa获取失败的情况，获取idfv
                if (!uqid || [uqid isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
                    uqid = [self getIDFV];
                    
                    //idfv获取失败的情况，获取uuid
                    if (!uqid) {
                        uqid = [self getUUID];
                    }
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:uqid forKey:UQID_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [YDKeyChain saveObject:uqid forKey:UQID_KEY];
                
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                NSData *data = [uqid dataUsingEncoding:NSUTF8StringEncoding];
                [pasteboard setData:data forPasteboardType:UQID_KEY];
                
            }
        }
    }
    return uqid;
}
+ (void)getDeviceCheckTokenWithBlock:(ReturnValueBlock) block{
    if ([[DCDevice currentDevice] isSupported]) {
        [[DCDevice currentDevice] generateTokenWithCompletionHandler:^(NSData * _Nullable token, NSError * _Nullable error) {
            NSString *deviceToken = [token base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]; NSLog(@"deviceToken %@", deviceToken);
            if (block) {
                block(deviceToken);
            }
        }];
    } else{
        if (block) {
            block(@"");
        }
    }
}
@end

//
//  ViewController.m
//  UUIDDemo
//
//  Created by 张无忌 on 2021/10/20.
//

#import "ViewController.h"
#import "YDDevice.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"设备名称：ihpone11");
    NSLog(@"bundle：com.skip.demo.UUIDDemo2");
    NSLog(@"QUID：%@",[YDDevice getUQID]);
    // DeviceCheckToken
    [YDDevice getDeviceCheckTokenWithBlock:^(id returnValue) {
        NSLog(@"设备名称：ihpone11");
        NSLog(@"bundle：com.skip.demo.UUIDDemo2");
        NSLog(@"DeviceCheckToken：%@",returnValue);
    }];
}
@end

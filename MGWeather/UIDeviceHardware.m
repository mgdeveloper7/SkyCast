//
//  UIDeviceHardware.m
//
//  Used to determine EXACT version of device software is running on.

#import "UIDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDeviceHardware

- (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

- (NSString *) platformString{
    NSString *platform = [self platform];
    
    NSString *deviceString;
    
    if ([platform isEqualToString:@"iPhone1,1"])    deviceString =  @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    deviceString =  @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    deviceString =  @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    deviceString =  @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    deviceString =  @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    deviceString =  @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    deviceString =  @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    deviceString =  @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    deviceString =  @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    deviceString =  @"iPhone 5c (Global)";
    if ([platform isEqualToString:@"iPhone6,1"])    deviceString =  @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    deviceString =  @"iPhone 5s (Global)";
    if ([platform isEqualToString:@"iPhone7,1"])    deviceString =  @"iPhone 6+";
    if ([platform isEqualToString:@"iPhone7,2"])    deviceString =  @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      deviceString =  @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      deviceString =  @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      deviceString =  @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      deviceString =  @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      deviceString =  @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      deviceString =  @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      deviceString =  @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      deviceString =  @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      deviceString =  @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      deviceString =  @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      deviceString =  @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      deviceString =  @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      deviceString =  @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      deviceString =  @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      deviceString =  @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      deviceString =  @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      deviceString =  @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      deviceString =  @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      deviceString =  @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      deviceString =  @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      deviceString =  @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      deviceString =  @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      deviceString =  @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      deviceString =  @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      deviceString =  @"iPad Mini 2 (Rev)";
    if ([platform isEqualToString:@"iPad4,7"])      deviceString =  @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      deviceString =  @"iPad Mini 3 (A1600)";
    if ([platform isEqualToString:@"iPad4,9"])      deviceString =  @"iPad Mini 3 (A1601)";
    if ([platform isEqualToString:@"iPad5,3"])      deviceString =  @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      deviceString =  @"iPad Air 2 (Cellular)";
    
    if ([platform isEqualToString:@"i386"])         deviceString =  @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       deviceString =  @"Simulator";
    
    return deviceString;

}

@end
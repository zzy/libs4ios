//
//  COMMON.m
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-1.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import "COMMON.h"

@implementation COMMON

static COMMON *sharedInstance = nil;

+ (COMMON *) sharedInstance
{
    if(!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

- (NSString *)md5:(NSString *)string Format:(int)format
{
    const char *charUTF8 = [string UTF8String];
    unsigned char result[format]; // the format value can be 16/32/64/...
    
    CC_MD5( charUTF8, strlen(charUTF8), result);
    
    return [NSString stringWithFormat: 
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            // @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            // @"XXXXXXXXXXXXXXXX",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7], 
            result[8], result[9], result[10], result[11], 
            result[12], result[13], result[14], result[15] 
            ]; 
}

- (NSString *)current_time
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//    [dateFormatter setDateFormat:@"hh:mm:ss"];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
//    [dateFormatter release];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)defTabBar:(UITabBar *)tabBar
{
    for(UIView *levelFirst in [tabBar subviews]) {
        
        if(![levelFirst isKindOfClass:NSClassFromString(@"UITabBarButton")])
            continue;
        
        for(id levelSecond in [levelFirst subviews]) {
            [levelSecond setBounds:CGRectMake(0, 0, 100, 50)];
            
            if(![levelSecond isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")])
                continue;
            
            [levelSecond setFont: [UIFont boldSystemFontOfSize:20]]; 
            [levelSecond setFrame: CGRectMake(0, 0, 96, 48)];
            [levelSecond setTextAlignment:UITextAlignmentCenter];
        }
    }
}

@end

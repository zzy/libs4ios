//
//  COMMON.h
//  House_iOS
//
//  Created by Zhongyu Zhang on 11-12-1.
//  Copyright (c) 2011年 OUDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface COMMON : NSObject

+ (COMMON *) sharedInstance;

- (NSString *)md5:(NSString *)string Format:(int)format;

- (NSString *)current_time;

- (void)defTabBar:(UITabBar *)tabBar;

@end

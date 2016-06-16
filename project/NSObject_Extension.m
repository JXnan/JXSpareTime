//
//  NSObject_Extension.m
//  project
//
//  Created by dfxd on 16/6/13.
//  Copyright © 2016年 dfxd. All rights reserved.
//


#import "NSObject_Extension.h"
#import "project.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[project alloc] initWithBundle:plugin];
        });
    }
}
@end

//
//  project.h
//  project
//
//  Created by dfxd on 16/6/13.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <AppKit/AppKit.h>

@class project;

static project *sharedPlugin;

@interface project : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end
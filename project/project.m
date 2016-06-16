//
//  project.m
//  project
//
//  Created by dfxd on 16/6/13.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "project.h"

@interface project()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation project

{
    NSTextView * _view;
}


+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    sharedPlugin = self;
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Archive" action:@selector(doMenuAction:) keyEquivalent:@""];
        [actionMenuItem setTag:10000];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(captureSourceTextViewNotification:) name:NSViewDidUpdateTrackingAreasNotification object:nil];
}

- (void)captureSourceTextViewNotification:(NSNotification *)not{
    Class class = NSClassFromString(@"DVTSourceTextView");
    
    if ([not.object isKindOfClass: class] && _view != not.object){
        NSLog(@"%@",not.name);
        _view = not.object;
    }
}


- (void)doMenuAction:(NSMenuItem *)Item
{
    if (_view) {
        NSLog(@"%@",_view.textStorage.string);
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

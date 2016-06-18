//
//  JXClassFileModel.h
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXClassifiedModel.h"
#import "JXEnumModel.h"


@interface JXClassFileModel : NSObject

@property(nonatomic,copy)NSString * name;
@property(nonatomic,strong)NSArray<JXEnumModel *> *enums;
@property(nonatomic,strong)NSArray<NSString *> *consts;
@property(nonatomic,strong)NSArray<JXClassifiedModel *> *classs;

- (instancetype)initWithDeclarationString:(NSString *)str;

+ (instancetype)ClassFileModelDeclarationString:(NSString *)str;

- (void)test;
@end

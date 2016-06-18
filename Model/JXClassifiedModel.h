//
//  JXClassifiedModel.h
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JXPropertyModel,JXMethodModel;


@interface JXClassifiedModel : NSObject
@property(nonatomic,copy)NSString * statement;
@property(nonatomic,copy,readonly)NSString * declaration;
@property(nonatomic,strong)NSMutableArray<JXPropertyModel *> * propertys;
@property(nonatomic,strong)NSMutableArray<JXMethodModel *> * methods;

- (instancetype)initWithDeclaration:(NSString *)declara;
+ (instancetype)classifiedModelWithDeclaration:(NSString *)declara;

@end

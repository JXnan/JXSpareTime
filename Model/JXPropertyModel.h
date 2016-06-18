//
//  JXPropletyModel.h
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXPropertyModel : NSObject

extern NSString * const JXPropertyExpression;


@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * declaration;
@property(nonatomic,copy)NSString * type;

- (instancetype)initWithDeclaration:(NSString *)declara;
+ (instancetype)propertyModelWithDeclaration:(NSString *)declara;

@end

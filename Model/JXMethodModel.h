//
//  JXMethodModel.h
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MethodType){
    MethodClassType = 0,
    MethodObjectType
};
OBJC_EXTERN NSString * const JXMethodExpression;

@interface JXMethodModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * declaration;
@property(nonatomic,assign)MethodType type;
@property(nonatomic,strong)NSArray<NSDictionary *> *parameters;
@property(nonatomic,copy)NSString * returnType;


- (instancetype)initWithDeclaration:(NSString *)declara;

+ (instancetype)methodModelWithDeclaration:(NSString *)declara;


@end

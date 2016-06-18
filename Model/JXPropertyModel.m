//
//  JXPropletyModel.m
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXPropertyModel.h"
#import "NSString+JXRegular.h"



NSString * const JXPropertyExpression = @"@.*;";
//NSString * const JXPropertyNameExpression = @"[A-Z][a-zA-Z]* \\*?[A-Za-z]*";
NSString * const JXPropertyNameExpression = @"\\b[a-z][a-zA-Z]*[a-z]";
@implementation JXPropertyModel


- (instancetype)init{
    
    return [self initWithDeclaration:nil];
}

-(instancetype)initWithDeclaration:(NSString *)declara{
    self = [super init];
    if (self && declara) {
        
        //判断格式是否正确
        if ([declara beganMatchWithType:JXPropertyExpression]) {
            _declaration = [declara copy];

            
            NSArray<NSString *> * array = [declara getTheTextFromTheExpression:JXPropertyNameExpression];
            if (array) {
                NSString * str = array[0];
                NSArray * properArray = [str componentsSeparatedByString:@" " ofMaxCount:2];
                if (properArray.count >= 2) {
                    _name = properArray[1];
                    _type = properArray[0];
                }
            }
        }
    }
    return self;
}

+ (instancetype)propertyModelWithDeclaration:(NSString *)declara{
    
    return [[self alloc] initWithDeclaration:declara];
}

/*
 @property(nonatomic,copy)NSString * name;
 @property(nonatomic,copy)NSString * declaration;
 @property(nonatomic,copy)NSString * type;
*/

#pragma mark - override
- (NSString *)description{
    return [NSString stringWithFormat:@"JXPropertyModel{name:%@---type:%@---declaration:%@ \n }",_name,_type,_declaration];
}
@end

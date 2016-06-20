//
//  JXClassifiedModel.m
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXClassifiedModel.h"
#import "NSString+JXRegular.h"
#import "JXPropertyModel.h"
#import "JXMethodModel.h"

@implementation JXClassifiedModel

#pragma mark - init

- (instancetype)init{
    return [self initWithDeclaration:nil];
}

- (instancetype)initWithDeclaration:(NSString *)declara{
    self = [super init];
    if (self && declara) {
        _declaration = [declara copy];
        
        [self serializationEnumModelWithString:declara];
        
        
    }
    return self;
}

+ (instancetype)classifiedModelWithDeclaration:(NSString *)declara{
    return [[JXClassifiedModel alloc] initWithDeclaration:declara];
}

#pragma mark - private
- (void)serializationEnumModelWithString:(NSString *)str{
    NSArray * array = [str componentsSeparatedByString:@"\n"];
    if (array) {
        _statement = array[0];
    }
    
    NSArray *propertyArray = [str getTheTextFromTheExpression:JXPropertyExpression];
    if (propertyArray) {
        NSMutableArray * tmpArray = [NSMutableArray array];
        for (NSString * obj in propertyArray) {
            JXPropertyModel * model = [JXPropertyModel propertyModelWithDeclaration:obj];
            [tmpArray addObject:model];
        }
        _propertys = tmpArray;
    }
    NSArray *methodArray = [str getTheTextFromTheExpression:JXMethodExpression];
    if (methodArray) {
        NSMutableArray * tmpArray = [NSMutableArray array];
        for (NSString * obj in methodArray) {
            JXMethodModel * model = [JXMethodModel methodModelWithDeclaration:obj];
            [tmpArray addObject:model];
        }
        _methods = tmpArray;
        
        
    }

    
}


#pragma mark - override
/*
 @property(nonatomic,copy)NSString * statement;
 @property(nonatomic,copy,readonly)NSString * declaration;
 @property(nonatomic,strong)NSMutableArray<JXPropertyModel *> * propertys;
 @property(nonatomic,strong)NSMutableArray<JXMethodModel *> * methods;
 */
- (NSString *)description{
    return [NSString stringWithFormat:@"JXClassifiedModel{statement:%@--decalration:%@--property:%@--method:%@}",_statement,_declaration,_propertys,_methods];
}

@end

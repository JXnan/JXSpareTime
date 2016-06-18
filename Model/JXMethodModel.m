//
//  JXMethodModel.m
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXMethodModel.h"
#import "NSString+JXRegular.h"

NSString * const JXMethodExpression = @"[-+].*;";
NSString * const JXMethodNameExpression = @"(?:\\))[a-zA-Z]+?(?=[:;])";
NSString * const JXMethodParameterExpression = @":.*?\\)[a-zA-Z]*";

@implementation JXMethodModel

#pragma mark - init
- (instancetype)init{
    return [self initWithDeclaration:nil];
}

- (instancetype)initWithDeclaration:(NSString *)declara{
    //- (void)removeObjectsFromIndices:(NSUInteger *)indices numIndices:(NSUInteger)cnt NS_DEPRECATED(10_0, 10_6, 2_0, 4_0);
    
    self = [super init];
    if (self && declara) {
        if([declara beganMatchWithType:JXMethodExpression]){
            _declaration = [declara copy];
            
            //  )removeObjectsFromIndices
            NSString * str = [[declara getTheTextFromTheExpression:JXMethodNameExpression] lastObject];
            //  removeObjectsFromIndices
            _name = [str substringFromIndex:1];
            _parameters = [self extractionParametersWithDeclaration:declara];
            NSRange range1 = [declara rangeOfString:@"("];
            NSRange range2 = [declara rangeOfString:@")"];
            _returnType = [declara substringWithRange:NSMakeRange(range1.location, range2.location - range1.location)];
            
            if ([[declara substringToIndex:1] isEqualToString:@"-"]) {
                _type = MethodObjectType;
            }else{
                _type = MethodClassType;
            }
            
            
        }
    }
    return self;
}

+ (instancetype)methodModelWithDeclaration:(NSString *)declara{
    return [[JXMethodModel alloc] initWithDeclaration:declara];
}

#pragma mark - public

#pragma mark - private
- (NSArray *)extractionParametersWithDeclaration:(NSString *)declara{
    // :(NSUInteger)cnt
    NSMutableArray * array = [[declara getTheTextFromTheExpression:JXMethodParameterExpression] mutableCopy];
    [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array replaceObjectAtIndex:idx withObject:[obj substringFromIndex:1]];
        
    }];
    return array;
}

#pragma mark - override

/*
 
 @property(nonatomic,copy)NSString * name;
 @property(nonatomic,copy)NSString * declaration;
 @property(nonatomic,assign)MethodType type;
 @property(nonatomic,strong)NSArray<NSDictionary *> *parameters;
 @property(nonatomic,copy)NSString * returnType;
 
 */
- (NSString *)description{
    return [NSString stringWithFormat:@"JXMethodModel{name:%@---type:%ld---return:%@ \n parameters:%@ \n }",_name,(long)_type,_returnType,_parameters];
}



@end

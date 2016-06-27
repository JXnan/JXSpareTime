//
//  JXMethodModel.m
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXMethodModel.h"
#import "NSString+JXRegular.h"

NSString * const JXMethodExpression = @"[+-]\\s\\([a-zA-Z_ <>*]*\\)[\\w\\W]*?;";
NSString * const JXMethodNameExpression = @"\\b[a-z][a-zA-Z]+?(?=[ ;])";
NSString * const JXMethodAllNameExpression = @"\\b[a-z][a-zA-Z]+?(?=[:])";
//NSString * const JXMethodNameExpression = @"[+-]\\s\\([a-zA-Z_ <>*]*\\)[\\w\\W]*?(?=[;])";
NSString * const JXMethodParameterExpression = @":.*?\\)[a-zA-Z]+";

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
            
            NSArray<NSString *> *versionArray = [declara componentsSeparatedByString:@"NS_"];
            _declaration = [versionArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (versionArray.count > 1) {
                _declaration = [_declaration stringByAppendingString:@";"];
            }
            
            //  )removeObjectsFromIndices
            NSArray * array = [_declaration getTheTextFromTheExpression:JXMethodAllNameExpression];
            if (array.count == 0) {
                array = [_declaration getTheTextFromTheExpression:JXMethodNameExpression];
                if (array.count == 0) {
                    return nil;
                }
            }
            NSMutableString *nameString = [NSMutableString string];
            for (NSString *str in array) {
                [nameString appendFormat:@"%@:",str];
            }
            _name = [nameString substringToIndex:nameString.length - 1];
            
            
            _parameters = [self extractionParametersWithDeclaration:declara];
            NSRange range1 = [_declaration rangeOfString:@"("];
            NSRange range2 = [_declaration rangeOfString:@")"];
            _returnType = [declara substringWithRange:NSMakeRange(range1.location + 1, range2.location - range1.location - 1)];
            
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
    if (array.count == 0) return nil;
    [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array replaceObjectAtIndex:idx withObject:[obj substringFromIndex:1]];
        
    }];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSString *str in array) {
        NSArray * tmpArray = [str componentsSeparatedByString:@")"];
        NSString * key = [tmpArray lastObject];
        NSString * value = [tmpArray[0] substringFromIndex:1];
        NSDictionary * dic = @{key:value};
        [resultArray addObject:dic];
    }
    return resultArray;
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
    return [NSString stringWithFormat:@"JXMethodModel{name:%@---type:%ld---return:%@---parameters:%@",_name,(long)_type,_returnType,_parameters];
}



@end

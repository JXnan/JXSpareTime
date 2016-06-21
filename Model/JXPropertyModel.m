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
        //@property (readonly) BOOL boolValue NS_AVAILABLE(10_5, 2_0);
        //判断格式是否正确
        if ([declara beganMatchWithType:JXPropertyExpression]) {
            _declaration = [declara copy];
            NSArray * array = [declara componentsSeparatedByString:@" "];
            NSMutableString * mStr = [NSMutableString stringWithString:_declaration];
            //去除版本标志
            for (NSUInteger i = 0; i < array.count ; i++) {
                NSRange range = [array[i] rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
                if (range.length == 0 && ![array[i] isEqualToString:@"BOOL"]) {
                    [mStr deleteCharactersInRange:[mStr rangeOfString:array[i]]];
                    //删除首尾空格
                    mStr = [NSMutableString stringWithString:[mStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                }
            }
            //@property (readonly) BOOL boolValue
            NSArray *spaceArray = [mStr componentsSeparatedByString:@" "];
            _name = [spaceArray lastObject];
            NSMutableString * typeString = [NSMutableString string];
            for (NSUInteger i = 1; i < spaceArray.count - 1; i++) {
                NSString * tmpStr = spaceArray[i];
                NSRange range = [tmpStr rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]];
                if (range.length == 0) {
                    [typeString appendString:tmpStr];
                }
            }
            _type = typeString;
            
            
            
            
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
    return [NSString stringWithFormat:@"JXPropertyModel{name:%@---type:%@---declaration:%@ \n } \n",_name,_type,_declaration];
}
@end

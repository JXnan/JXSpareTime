//
//  JXEnumModel.m
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXEnumModel.h"

#import "NSString+JXRegular.h"

@interface JXEnumModel()
//@property(nonatomic,strong) NSMutableArray<NSDictionary *> *values;
@end

@implementation JXEnumModel


#pragma mark - init

- (instancetype)initWithDeclaration:(NSString *)declara{
    self = [super init];
    if (self && declara) {
        _declaration = [declara copy];
        [self serializationEnumModelWithString:declara];
    }
    return self;
}

- (void)serializationEnumModelWithString:(NSString *)str{
    NSArray * array = [str componentsSeparatedByString:@"\n"];
    //  NS_ENUM(NSStringEncoding) {\n  NSASCIIStringEncoding = 1,\t\t\n
    if (!array) return ;
    //array[0] = NS_ENUM(NSStringEncoding) {
    NSRange nameRange = [array[0] rangeOfLetfString:@"(" rightString:@")" greedy:NO];
    if (nameRange.length ==0) return ;
    //property = NSStringEncoding
    NSString * property = [array[0] substringWithRange:nameRange];
    NSArray * propertyArray = [property componentsSeparatedByString:@", "];
    if (!propertyArray) return ;
    
    
    _name = [propertyArray lastObject];
    _type = @"NSUInteger";
    if (propertyArray.count == 2) {
        _type = propertyArray [0];
    }
    
    NSMutableArray * listArray = [NSMutableArray array];
    for (int i = 1; i< array.count-1; i++) {
        NSString  * obj = array[i];
        NSArray * objArray = [obj componentsSeparatedByString:@"="];
        NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@",    "];
        [objArray makeObjectsPerformSelector:@selector(stringByTrimmingCharactersInSet:) withObject:set];
        if ([objArray[0] rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].length == 0) continue;
        NSDictionary * dic = @{objArray[0]:@""};
        
        
        if (objArray.count >= 2) {
            //NSLog(@"::::::%@----%@",objArray[0],objArray[1]);
            
            dic = @{objArray[0]:objArray[1]};
        }
        [listArray addObject:dic];
        
    }
    
    
    _values = listArray;
 
}

#pragma mark - public
#pragma mark - private

#pragma mark - <#注释#> delegate

/*
@property(nonatomic,copy,readonly) NSString * name;
@property(nonatomic,copy,readonly) NSString * type;
@property(nonatomic,copy,readonly)NSString * declaration;
@property(nonatomic,strong) NSArray<NSDictionary *> *values;

*/
#pragma mark - override

- (NSString *)description{
    return [NSString stringWithFormat:@"JXEnumModel{name:%@---type:%@---declaration:%@\n values:%@\n }",_name,_type,_declaration,_values];
}

@end

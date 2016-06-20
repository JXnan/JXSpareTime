//
//  JXClassFileModel.m
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import "JXClassFileModel.h"
#import "NSString+JXRegular.h"

NSString * const JXClassifiedExpression = @"@[^c][\\w\\W]*?@end";
NSString * const JXEnumExpression = @".*\\{[\\w\\W]*?\\}.*;";
NSString * const JXConstExpression = @".*NSString.{3}const.*";
NSString * const JXCommentMoreExpression = @"/\\*[\\w\\W]*?\\*/";
NSString * const JXCommentSingleExpression = @"//.*";




@implementation JXClassFileModel

{
    NSArray * _classifiedArray;
    NSArray * _enumArray;
    NSArray * _constArray;
}


#pragma mark - init


- (instancetype)init{
    return [self initWithDeclarationString:nil];
}

- (instancetype)initWithDeclarationString:(NSString *)str{
    self = [super init];
    if (self && str) {
        str = [self deleteCommentForString:str];
        _classifiedArray = [str getTheTextFromTheExpression:JXClassifiedExpression];
        _enumArray = [str getTheTextFromTheExpression:JXEnumExpression];
        _constArray = [str getTheTextFromTheExpression:JXConstExpression];
        _consts = _constArray;
    }
    return self;
}






+ (instancetype)ClassFileModelDeclarationString:(NSString *)str{
    return [[JXClassFileModel alloc] initWithDeclarationString:str];
}






#pragma mark - public
- (void)test{
    //NSLog(@"-----%@",_classifiedArray);
    
    
    
    //NSLog(@"!!!!!%@",_enumArray);
    //NSLog(@"=====%@",_constArray);

    
    NSLog(@"const---%@",_consts);
    NSMutableArray * classArray = [NSMutableArray array];
    for (NSString * obj in _classifiedArray) {
        JXClassifiedModel * model = [JXClassifiedModel classifiedModelWithDeclaration:obj];
        [classArray addObject: model];
        NSLog(@"class----%lu",(unsigned long)model.propertys.count);
        NSLog(@"class----%@",model.propertys);
        NSLog(@"class----%lu",(unsigned long)model.methods.count);
        NSLog(@"class----%@",model.methods);
    }
    _classs = classArray;

    
    NSMutableArray * enumArray = [[NSMutableArray alloc] init];
    for (NSString * obj in _enumArray) {
        JXEnumModel * model = [[JXEnumModel alloc] initWithDeclaration:obj];
        [enumArray addObject:model];
    }
    _enums = enumArray;
    NSLog(@"enum-----%lu",(unsigned long)enumArray.count);
    NSLog(@"enum----%@",_enums);
}

#pragma mark - private


//删除注释
- (NSString *)deleteCommentForString:(NSString *)str{
    NSMutableString * mStr = [NSMutableString stringWithString:str];
    NSArray * array = [mStr getTheTextFromTheExpression:JXCommentMoreExpression];
    //NSLog(@">>>>%@",array);
    
    for (NSString * obj in array) {
        NSRange range = [mStr rangeOfString:obj];
        [mStr deleteCharactersInRange:range];
    }
    array = [mStr getTheTextFromTheExpression:JXCommentSingleExpression];
    //NSLog(@">>>>%@",array);
    for (NSString * obj in array) {
        NSRange range = [mStr rangeOfString:obj];
        [mStr deleteCharactersInRange:range];
    }
    return [mStr copy];
}



#pragma mark - override
/*
 @property(nonatomic,copy)NSString * name;
 @property(nonatomic,strong)NSArray<JXEnumModel *> *enums;
 @property(nonatomic,strong)NSArray<NSString *> *consts;
 @property(nonatomic,strong)NSArray<JXClassifiedModel *> *classs;
 */
 
- (NSString *)description{
    return [NSString stringWithFormat:@"neums:%@\n consts:%@\n classs:%@",_enums,_consts,_classs];
}
@end

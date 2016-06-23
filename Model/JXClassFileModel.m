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

NSString * const JXFilePath = @"/Users/admin/Desktop/";
NSString * const JXFileType = @".md";

@implementation JXClassFileModel

{
    NSArray * _classifiedArray;
    NSArray * _enumArray;
    NSArray * _constArray;
    NSMutableString *_allString;
    NSString *_fileName;
}


#pragma mark - init


- (instancetype)init{
    return [self initWithDeclarationString:nil];
}

- (instancetype)initWithDeclarationString:(NSString *)str{
    self = [super init];
    if (self && str) {
        _allString = [NSMutableString string];
        NSArray * array = [str componentsSeparatedByString:@"\n"];
        if (array.count == 0) return self;
        _fileName = [array[0] substringFromIndex:2];
        [_allString appendFormat:@"##%@\n\n",_fileName];
        
        
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
- (void)serialization{

    NSMutableArray * classArray = [NSMutableArray array];
    for (NSString * obj in _classifiedArray) {
        JXClassifiedModel * model = [JXClassifiedModel classifiedModelWithDeclaration:obj];
        [classArray addObject: model];
    }
    _classs = classArray;

    
    NSMutableArray * enumArray = [[NSMutableArray alloc] init];
    for (NSString * obj in _enumArray) {
        JXEnumModel * model = [[JXEnumModel alloc] initWithDeclaration:obj];
        [enumArray addObject:model];
    }
    _enums = enumArray;

}

- (void)print{
    [_allString appendString:@"##概要\n\n"];
    [self printConst];
    [self printEnumDeclare];
    [self printPropertyDeclare];
    [self printMethodDeclare];
    [_allString appendString:@"##详细说明\n\n"];
    [self printEnumDescription];
    [self printPropertyDescription];
    [self printMethodDescription];
    NSError * error;
    NSString *filePath = [NSString stringWithFormat:@"%@%@%@",JXFilePath,_fileName,JXFileType];
    
    [_allString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"失败!%ld",(long)error.code);
    }
    NSLog(@"%@",_allString);
    
}

#pragma mark - private


- (void)printConst{
    if (_consts.count == 0) return;
    
    [_allString appendString:@"###常量\n\n"];
    [_allString appendString:@"||\n"];
    [_allString appendString:@"|-|\n"];
    for (NSString *obj in _consts) {
        [_allString appendFormat:@"|%@|\n",obj];
        [_allString appendFormat:@"|`描述`|\n"];
    }
    [_allString appendString:@"\n"];
}

- (void)printEnumDeclare{
    if (_enums.count == 0) return;
    [_allString appendString:@"###枚举\n\n"];
    [_allString appendString:@"|名称|类型|说明|\n"];
    [_allString appendString:@"|-|-|-|\n"];
    for (JXEnumModel *obj in _enums) {
        [_allString appendFormat:@"|[%@](#%@)|%@|`描述`|\n",obj.name,obj.name,obj.type];
    }
    [_allString appendString:@"\n"];
    
}

- (void)printEnumDescription{
    if (_enums.count == 0) return;
    [_allString appendString:@"###枚举\n\n"];

    for (JXEnumModel *obj in _enums) {
        [_allString appendFormat:@"**<span id = \"%@\">%@</span>**\n",obj.name,obj.name];
        for (NSDictionary * dic in obj.values) {
            [_allString appendFormat:@">- %@\t%@\n",[[dic allKeys] lastObject],[dic.allValues lastObject]];
            [_allString appendFormat:@"`描述`\n"];
        }
        [_allString appendFormat:@"\n"];
    }
    [_allString appendString:@"\n"];
    NSURLRequest
    
}



-(void)printPropertyDeclare{
    
    if (_classs.count == 0) return;
    NSMutableArray *propertyArray = [NSMutableArray array];
    for (JXClassifiedModel *obj in _classs) {
        [propertyArray addObjectsFromArray:obj.propertys];
    }
    if (propertyArray.count == 0) return;
    

    [_allString appendString:@"###属性\n\n"];
    [_allString appendString:@"|名称|类型|说明|\n"];
    [_allString appendString:@"|-|-|-|\n"];
    for (JXPropertyModel *obj in propertyArray) {
        [_allString appendFormat:@"|[%@](#%@)|%@|`描述`|\n",obj.name,obj.name,obj.type];
    }
    [_allString appendString:@"\n"];
    
}


- (void)printPropertyDescription{
    if (_classs.count == 0) return;
    NSMutableArray *propertyArray = [NSMutableArray array];
    for (JXClassifiedModel *obj in _classs) {
        [propertyArray addObjectsFromArray:obj.propertys];
    }
    if (propertyArray.count == 0) return;
    [_allString appendString:@"###属性\n\n"];
    for (JXPropertyModel *obj in propertyArray) {
        [_allString appendFormat:@">- <span id = \"%@\">%@</span>\n",obj.name,obj.declaration];
        [_allString appendFormat:@"`描述`\n"];
    }
    [_allString appendString:@"\n"];
}



- (void)printMethodDeclare{
    if (_classs.count == 0) return;
    NSMutableArray *MethodArray = [NSMutableArray array];
    for (JXClassifiedModel *obj in _classs) {
        [MethodArray addObjectsFromArray:obj.methods];
    }
    if (MethodArray.count == 0) return;
    [_allString appendString:@"###方法\n\n"];
    [_allString appendString:@"|类型|名称|返回值|说明|\n"];
    [_allString appendString:@"|-|-|-|-|\n"];
    for (JXMethodModel *obj in MethodArray) {
        NSString * str = obj.type == MethodClassType ? @"+":@"-";
        [_allString appendFormat:@"|%@|[%@](#%@)|%@|`描述`|\n",str,obj.name,obj.name,obj.returnType];
    }
    [_allString appendString:@"\n"];
}

- (void)printMethodDescription{
    if (_classs.count == 0) return;
    NSMutableArray *MethodArray = [NSMutableArray array];
    for (JXClassifiedModel *obj in _classs) {
        [MethodArray addObjectsFromArray:obj.methods];
    }
    if (MethodArray.count == 0) return;
    [_allString appendString:@"###方法\n\n"];
    for (JXMethodModel *obj in MethodArray) {
        [_allString appendFormat:@"**<span id = \"%@\">%@</span>**\n",obj.name,obj.declaration];
        [_allString appendFormat:@"`描述`\n\n"];
        [_allString appendFormat:@"**参数说明**\n"];
        [_allString appendFormat:@"```\n"];
        [_allString appendFormat:@"@return: 描述\n"];
        for (NSDictionary * dic in obj.parameters) {
            [_allString appendFormat:@"@%@: 描述\n",[dic.allKeys lastObject]];
        }
        [_allString appendFormat:@"```\n"];
        [_allString appendFormat:@"**例句**\n"];
        [_allString appendFormat:@"```\n"];
        [_allString appendFormat:@"例句代码\n"];
        [_allString appendFormat:@"```\n"];
    }
    [_allString appendString:@"\n"];
}



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

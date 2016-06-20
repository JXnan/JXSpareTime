//
//  JXEnumModel.h
//  project
//
//  Created by dfxd on 16/6/16.
//  Copyright © 2016年 dfxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXEnumModel : NSObject

@property(nonatomic,copy,readonly) NSString * name;
@property(nonatomic,copy,readonly) NSString * type;
@property(nonatomic,copy,readonly)NSString * declaration;
@property(nonatomic,strong) NSArray<NSDictionary *> *values;

- (instancetype)initWithDeclaration:(NSString *)declara;
+ (instancetype)enumModelWithDeclaration:(NSString *)declara;




//- (void)addEnumListValue:(id)value forKey:(NSString *)key;
@end

//
//  NSString+JXRegular.m
//  ab
//
//  Created by admin on 15-12-27.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSString+JXRegular.h"

@implementation NSString (JXRegular)


- (BOOL)beganMatchWithType:(NSString *)type{
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self matches %@",type];
    return [predicate evaluateWithObject:self];
}

- (NSArray <NSString *> *)getTheTextFromTheExpression:(NSString *)expression{
    NSMutableArray * array = [NSMutableArray array];
    NSRegularExpression * regular = [[NSRegularExpression alloc] initWithPattern:expression options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * resultArray = [regular matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    for (NSTextCheckingResult * obj in resultArray) {
        NSString * str  = [self substringWithRange:obj.range];
        [array addObject:str];
    }
    return array;
}


- (NSArray <NSString *> *)componentsSeparatedByString:(NSString *)separator ofMaxCount:(NSInteger)count{
    NSMutableArray * array = [NSMutableArray array];
    if (count == 0) {
        [array addObject:self];
        return array;
    }
    NSRange range = [self rangeOfString:separator];
    if (range.length == 0) {
        [array addObject:self];
        return array;
    }
    
    [array addObject:[self substringWithRange:NSMakeRange(0, range.location)]];
    NSString * str = [self substringWithRange:NSMakeRange(range.location + range.length,self.length - (range.location + range.length))];
    [array addObjectsFromArray:[str componentsSeparatedByString:separator ofMaxCount:--count]];
    
    return array;
    
}


- (NSRange)rangeOfLetfString:(NSString *)leftStr rightString:(NSString *)rightStr greedy:(BOOL)greedy{
    NSRange range1 = [self rangeOfString:leftStr];
    NSRange range2 = [self rangeOfString:rightStr options:NSBackwardsSearch];
    if (range1.length == 0) range1.location = 0;
    if (range2.length == 0) range2.location = self.length;
    
    NSUInteger locations;
    NSUInteger lengths;
    if (range1.location > range2.location) {
        return NSMakeRange(-1, -1);
    }
    if (greedy) {
        locations = range1.location;
        lengths = range2.length + range2.location - range1.location;
        NSLog(@"%lu,%lu",(unsigned long)locations,(unsigned long)lengths);
        
    }else{
        locations = range1.location + range1.length;
        lengths = range2.location - locations;
    }
    return NSMakeRange(locations, lengths);
}



@end

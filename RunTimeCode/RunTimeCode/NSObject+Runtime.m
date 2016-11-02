//
//  NSObject+Runtime.m
//  RunTimeCode
//
//  Created by Yan on 16/11/2.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

+ (NSArray *)getObjectProperties {
    NSLog(@"getObjectProperties获取类的属性数组");
    unsigned int count = 0;
    /** 获取类的属性数组 */
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSLog(@"属性个数为%d",count);
    NSMutableArray *arrayProperties = [NSMutableArray array];
    /** 遍历所有属性 */
    for (unsigned int i = 0; i < count; i ++) {
        /** 从数组中获取属性名称 */
        objc_property_t property = propertyList[i];
        const char *propertyNameC = property_getName(property);
        NSLog(@"%s",propertyNameC);
        NSString *propertyName = [NSString stringWithCString:propertyNameC encoding:NSUTF8StringEncoding];
        [arrayProperties addObject:propertyName];
    }
    
    /**  You must free the array with free(). C语言数组需要rlease 否则内存泄漏 */
    free(propertyList);
    return arrayProperties.copy;
}

+ (instancetype)objectWithDictnory:(NSDictionary *)dict {
    id object = [[self alloc]init];
    /** 获得self属性列表 */
    NSArray *arrayProperties = [self getObjectProperties];
    /** 遍历字典 判断 字典中的属性KEY是否在属性列表中 */
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@--%@",obj,key);
        /** 如果存在就 KVC */
        if ([arrayProperties containsObject:key]) {
            [object setValue:obj forKey:key];
        }
    }];
    return object;
}

@end

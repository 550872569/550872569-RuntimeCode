//
//  NSObject+Runtime.m
//  RunTimeCode
//
//  Created by Yan on 16/11/2.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

const char * kPropertiesListKey = "PropertiesListKey";

+ (NSArray *)getObjectProperties {
    
    /** 获取关联对象的属性数组 */
    NSArray *ptyList = objc_getAssociatedObject(self, kPropertiesListKey);
    /** 如果属性数组有值就返回  可以提高效率 */
    if (ptyList != nil) {
        return ptyList;
    }

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
    
    // --- 2. 到此为止，对象的属性数组已经获取完毕，利用关联对象，动态添加属性
    /**
     参数
     
     1. 对象 self [OC 中 class 也是一个特殊的对象]
     2. 动态添加属性的 key，获取值的时候使用
     3. 动态添加的属性值
     4. 对象的引用关系
     */
    objc_setAssociatedObject(self, kPropertiesListKey, arrayProperties.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
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

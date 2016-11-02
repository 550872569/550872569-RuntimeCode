//
//  NSObject+Runtime.h
//  RunTimeCode
//
//  Created by Yan on 16/11/2.
//  Copyright © 2016年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Runtime)

/** 获取属性数组 */
+ (NSArray *)getObjectProperties;

/** 根据属性创建对象 */
+ (instancetype)objectWithDictnory:(NSDictionary *)dict;

@end

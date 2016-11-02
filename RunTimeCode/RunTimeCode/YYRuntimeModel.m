//
//  YYRuntimeModel.m
//  RunTimeCode
//
//  Created by Yan on 16/11/2.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "YYRuntimeModel.h"

@implementation YYRuntimeModel

- (NSString *)description {
    NSArray *keys = @[@"name",@"age",@"height",@"sex"];
    return [self dictionaryWithValuesForKeys:keys].description;
}
@end

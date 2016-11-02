//
//  ViewController.m
//  RunTimeCode
//
//  Created by Yan on 16/11/2.
//  Copyright © 2016年 YY. All rights reserved.
//

#import "ViewController.h"
#import "YYRuntimeModel.h"
#import "NSObject+Runtime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"self%@",self);
    [self runtimeGetPropertiesCode];
    NSDictionary *dict = @{@"name":@"yhp",
                           @"age":@18,
                           @"height":@1.8,
                           @"sex":@1,
                           @"propertyNil":@"objProperty"
                           };
    [self initObjWithDict:dict];
}

/** 获取属性列表 */
- (void)runtimeGetPropertiesCode {
    NSArray * array = [YYRuntimeModel getObjectProperties];
    NSLog(@"通过运行时获取到 %ld 个类属性",array.count);
}

/** 字典转模型 */
- (void)initObjWithDict:(NSDictionary *)dict {
    YYRuntimeModel *model = [YYRuntimeModel objectWithDictnory:dict];
    NSLog(@"model%@",model);
}

@end

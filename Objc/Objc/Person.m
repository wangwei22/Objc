//
//  Person.m
//  Objc
//
//  Created by wang_wei on 2018/3/14.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person
//默认参数
void eat(id objc,SEL _cmd,id obj){
    NSLog(@"哥么吃了!!%@ ",obj);
}

//调用了一个没有实现的对象方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    //添加一个方法eat
    if (sel == @selector(eat:)) {
        //IMP 方法实现 就是一个函数指针!!
        //types:返回值类型
        class_addMethod([Person class], @selector(eat:), (IMP)eat, "v");
        
    }
    
    
    return  [super resolveInstanceMethod:sel];
}

@end

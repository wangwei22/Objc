//
//  UIButton+Custom.m
//  Objc
//
//  Created by wang_wei on 2018/3/14.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import "UIButton+Custom.h"
#import <objc/runtime.h>
static  const char  Name;
@implementation UIButton (Custom)
-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, &Name, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)name{
  return     objc_getAssociatedObject(self, &Name);
}
@end

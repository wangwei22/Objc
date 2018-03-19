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
static const char btnKey;
@implementation UIButton (Custom)
-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, &Name, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)name{
  return     objc_getAssociatedObject(self, &Name);
}

- (void)handelWithBlock:(btnBlock)block
{
    if (block)
    {
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction
{
    btnBlock block = objc_getAssociatedObject(self, &btnKey);
    block();
}

@end

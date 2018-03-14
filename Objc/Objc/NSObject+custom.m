//
//  NSObject+custom.m
//  Objc
//
//  Created by wang_wei on 2018/3/14.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import "NSObject+custom.h"
#import <objc/runtime.h>
#import "OriginalObject.h"
@implementation NSObject (custom)
-(void)setObjc_weak_id:(id)objc_weak_id{
    OriginalObject  * obj = [[OriginalObject  alloc] initWithBlock:^{
        objc_setAssociatedObject(self, @selector(objc_weak_id), nil, OBJC_ASSOCIATION_ASSIGN);
    }];
    objc_setAssociatedObject(self, @selector(objc_weak_id), (__bridge id _Nullable)((__bridge const void*)(obj.block)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(objc_weak_id), objc_weak_id, OBJC_ASSOCIATION_ASSIGN);
}
-(id)objc_weak_id{
    return  objc_getAssociatedObject( self, _cmd);
}

@end




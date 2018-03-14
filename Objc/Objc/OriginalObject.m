//
//  OriginalObject.m
//  Objc
//
//  Created by wang_wei on 2018/3/14.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import "OriginalObject.h"

@implementation OriginalObject
-(instancetype)initWithBlock:(DellocBlock)block{
    if (self = [super  init]) {
        self.block= block;
    }
    return   self;
}
-(void)dealloc{
    self.block ?self.block():nil;
}
@end

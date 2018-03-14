//
//  OriginalObject.h
//  Objc
//
//  Created by wang_wei on 2018/3/14.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DellocBlock) ();
@interface OriginalObject : NSObject
@property(nonatomic,copy)DellocBlock  block;
-(instancetype)initWithBlock:(DellocBlock)block;
@end

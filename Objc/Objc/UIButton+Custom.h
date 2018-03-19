//
//  UIButton+Custom.h
//  Objc
//
//  Created by wang_wei on 2018/3/14.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnBlock)();
@interface UIButton (Custom)
@property(nonatomic,copy)NSString  * name;
- (void)handelWithBlock:(btnBlock)block;
@end

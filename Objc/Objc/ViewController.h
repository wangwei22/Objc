//
//  ViewController.h
//  Objc
//
//  Created by wang_wei on 2018/3/12.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  ViewControllerDelegate <NSObject>
@optional
-(void)name;
-(void)pushViewController;
@end
@interface ViewController : UIViewController
@property(nonatomic,assign)id<ViewControllerDelegate>delegate;

@end


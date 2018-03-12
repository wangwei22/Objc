//
//  ViewController.m
//  Objc
//
//  Created by wang_wei on 2018/3/12.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    __block    int t =1;
    void (^foo)(void)=^{
        int  a;
        t++;
        a= t;
        NSLog(@"=%d",a);
    };
    foo();
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

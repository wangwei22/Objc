//
//  ViewController.m
//  Objc
//
//  Created by wang_wei on 2018/3/12.
//  Copyright © 2018年 wangwei. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+custom.h"
#import "UIButton+Custom.h"
@interface ViewController ()
@property(nonatomic,strong) NSMutableArray  * arr;
@property(nonatomic,strong)   UIButton  * btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1");
    NSLog(@"00=%@",[NSThread  currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"qq2");
    });
    NSLog(@"3");
    NSLog(@"33=%@",[NSThread  currentThread]);
    __block    int t =1;
    void (^foo)(void)=^{
        int  a;
        t++;
        a= t;
        NSLog(@"=%d",a);
    };
    foo();
    NSMutableArray  * arr_1 = [NSMutableArray  new];
    self.arr = arr_1;
    [self.arr  addObject:@"123"];
    NSLog(@"==%@",self.arr);
  
    UIButton  * btn = [UIButton  buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 30, 200, 30);
    btn.backgroundColor = [UIColor  redColor];
    [btn  addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.name = @"按钮";
    [self.view  addSubview:btn];
    _btn = btn;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)btnClick{
    NSLog(@"......%@",_btn.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

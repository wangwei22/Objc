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
#import "Person.h"
#import <objc/message.h>
#import <objc/runtime.h>
@interface ViewController ()
@property(nonatomic,strong) NSMutableArray  * arr;
@property(nonatomic,strong)   UIButton  * btn;
@end

@implementation ViewController
//load方法会在类第一次加载的时候被调用
//调用的时间比较靠前，适合在这个方法里做方法交换
+(void)load{
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL  systemSel = @selector(viewWillAppear:);
         //自己实现的将要被交换的方法的selector
        SEL  swizzSel = @selector(swizz_viewWillAppear:);
        //两个方法的Method
        Method  systemMethod = class_getInstanceMethod([self  class], systemSel);
        Method  swizzMethod = class_getInstanceMethod([self class], swizzSel);
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL  isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod([self  class], swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
             //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

-(void)swizz_viewWillAppear:(BOOL)animated{
    //这时候调用自己，看起来像是死循环
    //但是其实自己的实现已经被替换了
    [self swizz_viewWillAppear:animated];
    NSLog(@"交换方法------->swizzle");
}
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
    [btn  handelWithBlock:^{
        NSLog(@"....%@----%@",[NSThread currentThread],btn.name);
        
    }];
    [btn  addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.name = @"按钮";
    [self.view  addSubview:btn];
    _btn = btn;
    // Do any additional setup after loading the view, typically from a nib.
    
    unsigned  int  count;
    //获取属性列表
    objc_property_t  * propertyList = class_copyPropertyList([self  class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char  * propertyName = property_getName(propertyList[i]);
        NSLog(@"property----->%@",[NSString  stringWithUTF8String:propertyName]);
    }
    free(propertyList);
    // 获取方法列表
    Method  * methodList = class_copyMethodList([self  class], &count);
    for (unsigned  int i=0; i<count; i++) {
        Method  method = methodList[i];
        NSLog(@"method----->%@",NSStringFromSelector(method_getName(method)));
    }
    free(methodList);
    //获取成员变量列表
    Ivar  * ivarList = class_copyIvarList([self class], &count);
    for (unsigned int  i=0; i<count; i++) {
        const  char  * ivar = ivar_getName(ivarList[i]);
        NSLog(@"Ivar------>%@",[NSString  stringWithUTF8String:ivar]);
    }
    free(ivarList);
    // 获取协议列表
    __unsafe_unretained  Protocol  **protocolList = class_copyProtocolList([self  class], &count);
    for (unsigned  int i = 0; i<count; i++) {
        Protocol  * myProtocol = protocolList[i];
        const  char  * protocolName = protocol_getName(myProtocol);
        NSLog(@"protocol----->%@",[NSString  stringWithUTF8String:protocolName]);
    }
    free(protocolList);
    
    Person  * p = [Person  new];
    [p performSelector:@selector(eat:) withObject:@"板烧鸡腿堡" afterDelay:0.5];
}
-(NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray  array];
    }
    return   _arr;
}
-(void)btnClick{
    NSLog(@"......%@",_btn.name);
}
/*
void  eat( id self, SEL _cmd,NSString * string){
    NSLog(@"add C IMP %@", string);
}

+(BOOL)resolveClassMethod:(SEL)sel{
   
    return   YES;
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    if ([NSStringFromSelector(sel) isEqualToString:@"eat:"]) {
        class_addMethod(self, sel, (IMP)eat, "v@:*");
    }
    return  YES;
}
//后两个方法需要转发到其他的类处理
-(id)forwardingTargetForSelector:(SEL)aSelector{
    return  NSStringFromClass([self  class]);
}
-(void)forwardInvocation:(NSInvocation *)anInvocation{
    
}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

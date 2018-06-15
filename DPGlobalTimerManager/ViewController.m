//
//  ViewController.m
//  DPGlobalTimerManager
//
//  Created by 人众 on 2018/6/15.
//

#import "ViewController.h"
#import "DPGlobalTimerManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[DPGlobalTimerManager standardManger]addTarget:self withBlock:^{
        NSLog(@"全局的定时器!");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

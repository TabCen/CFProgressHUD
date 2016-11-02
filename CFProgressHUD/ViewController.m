//
//  ViewController.m
//  CFProgressHUD
//
//  Created by  chenfei on 2016/11/2.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "ViewController.h"
#import "CFProgressHUD.h"

@interface ViewController ()

@property(nonatomic,strong)CFProgressHUD *hud;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClicked:(id)sender {
    CFProgressHUD *hud=[[CFProgressHUD alloc]init];
    [hud show];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CFProgressHUD hide];
    });
    
}

- (IBAction)buttonClicked2:(id)sender {
    //1
//    CFProgressHUD *hud=[[CFProgressHUD alloc]init];
//    [hud showWithTittle:@"请稍等～"];
    
    //2
    [CFProgressHUD _showWithTittle:@"请稍等~"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

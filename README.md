#CFProgressHUD

>简陋加载框（有待改进）

--------

###效果图

![image](https://github.com/TabCen/ImageFile/blob/master/CFProgressHUD.gif)

###代码
```objectivec
- (IBAction)buttonClicked2:(id)sender {
    //1
//    CFProgressHUD *hud=[[CFProgressHUD alloc]init];
//    [hud showWithTittle:@"请稍等～"];
    
    //2
    [CFProgressHUD _showWithTittle:@"请稍等~"];
}
```
```objectivec
- (IBAction)buttonClicked:(id)sender {
    CFProgressHUD *hud=[[CFProgressHUD alloc]init];
    [hud show];
    模仿网络请求结束后掉用hide
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CFProgressHUD hide];
    });
    
}
```

###说明

* 渐变转圈的代码归属[@Leo](https://github.com/LeoMobileDeveloper/WCGradientCircleLayer)





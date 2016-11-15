//
//  CFProgressHub.h
//  TestForCFProgressHub
//
//  Created by  chenfei on 2016/11/2.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFProgressHUD : UIView

-(instancetype)init;
+(instancetype)shareFile;

+(void)_show;
+(void)_showWithTittle:(NSString *)tittle;


-(void)show;
-(void)showWithTittle:(NSString *)tittle;

-(void)stop;
+(void)hide;

@end

@interface UILabel (utils)

+ (CGFloat)HeightForText:(NSString *)text withFontSize:(CGFloat)fontSize withTextWidth:(CGFloat)textWidth;

+ (CGFloat)WidthForText:(NSString *)text withFontSize:(CGFloat)fontSize withTextHeight:(CGFloat)textHeight;

@end

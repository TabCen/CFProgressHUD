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
+(void)_showWithImage:(UIImage *)image;
+(void)_showWithTittle:(NSString *)tittle;
+(void)_showWithImage:(UIImage *)image withTittle:(NSString *)tittle;

-(void)show;
-(void)showWithImage:(UIImage *)image;
-(void)showWithTittle:(NSString *)tittle;
-(void)showWithImage:(UIImage *)image withTittle:(NSString *)tittle;


-(void)stop;
+(void)hide;

//+(void)_showWithTittle:(NSString *)tittle

@end

@interface UILabel (utils)

+ (CGFloat)HeightForText:(NSString *)text withFontSize:(CGFloat)fontSize withTextWidth:(CGFloat)textWidth;

+ (CGFloat)WidthForText:(NSString *)text withFontSize:(CGFloat)fontSize withTextHeight:(CGFloat)textHeight;

@end

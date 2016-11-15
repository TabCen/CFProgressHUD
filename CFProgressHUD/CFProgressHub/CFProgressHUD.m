//
//  CFProgressHub.m
//  TestForCFProgressHub
//
//  Created by  chenfei on 2016/11/2.
//  Copyright © 2016年 chenfei. All rights reserved.
//

#import "CFProgressHUD.h"
#import "WCGraintCircleLayer.h"


#define COLOR_RGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


static NSString *const AnimationID=@"KCBasicAnimation_Rotation";

@interface CFProgressHUD ()
@property(nonatomic,strong)UIControl            *bgView;
@property(nonatomic,strong)WCGraintCircleLayer  *circleLayer;
@property(nonatomic,strong)UILabel              *label;
@property(nonatomic,strong)UIView               *smallbgView;
@property(nonatomic,strong)NSString             *tittle;
@property(nonatomic,strong)NSTimer              *timer;

@end

@implementation CFProgressHUD

static CFProgressHUD *hub=nil;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hub=[super allocWithZone:zone];
    });
    return hub;
}

+(instancetype)shareFile{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hub=[[self alloc] init];
    });
    
    return hub;
}


-(void)dealloc{
    NSLog(@"CFProgressHub中dealloc方法中，应该不走这个方法");
}

-(instancetype)init{
    self=[super init];
    if (self) {
    }
    return self;
}

+(void)_show{
    [CFProgressHUD shareFile];
    [hub show];
}



+(void)_showWithTittle:(NSString *)tittle{
    [CFProgressHUD shareFile];
    [hub showWithTittle:tittle];
}

-(void)show{
    [self cleanMemory];
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    self.bgView.frame=window.frame;
    self.circleLayer.position=self.bgView.center;
    
    [_bgView.layer addSublayer:self.circleLayer];
    [window addSubview:_bgView];
    [self startAnimation];
    
    //开启计时器
    [self timeToFire];
}

-(void)showWithTittle:(NSString *)tittle{
    [self cleanMemory];
    self.tittle=tittle;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    self.bgView.frame=window.frame;
    
    self.smallbgView.backgroundColor=COLOR_RGBA(0x000000, 0.8);
    _smallbgView.layer.cornerRadius=5;
    _smallbgView.layer.masksToBounds=YES;
    
    self.label.text=tittle;
    _label.textColor=[UIColor whiteColor];
    
    [self.smallbgView addSubview:self.label];
    
    [self.smallbgView.layer addSublayer:self.circleLayer];
    
    [self.bgView addSubview:self.smallbgView];
    
    self.smallbgView.layer.position=self.bgView.center;
    
    [window addSubview:_bgView];
    
    [self animationTopShake];
    
    [self startAnimation];
    //开启计时器
    [self timeToFire];
}
+(void)hide{
    [hub stop];
}

-(void)stop{
    [self stopAnimation];
    [self cleanMemory];
    [self removeFromSuperview];
    [self timerStop];
}

-(void)timeToFire{
//    self.timer=[NSTimer timerWithTimeInterval:4 target:self selector:@selector(stop) userInfo:nil repeats:nil];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stop) userInfo:nil repeats:NO];
//    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
//    [_timer fire];
}

-(void)timerStop{
    if (_timer) {
        if (_timer.isValid) {
            [_timer invalidate];
        }
        _timer=nil;
    }
}



-(void)cleanMemory{
    if (_bgView) {
        [_bgView removeFromSuperview];
        _bgView=nil;
    }
    if (_circleLayer) {
        [_circleLayer removeFromSuperlayer];
        _circleLayer=nil;
    }
    if (_smallbgView) {
        [_smallbgView removeFromSuperview];
        _smallbgView=nil;
    }
    if (_label) {
        [_label removeFromSuperview];
        _label=nil;
    }
    if (_tittle) {
        _tittle=nil;
    }
}


-(void)startAnimation{
    //添加动画
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI*2];
    basicAnimation.duration=0.7;
    basicAnimation.repeatCount=HUGE_VALF;
    
    [self.circleLayer addAnimation:basicAnimation forKey:AnimationID];
}

-(void)stopAnimation{
    if (_circleLayer) {
        [_circleLayer removeAnimationForKey:AnimationID];
    }
}

#pragma mark - 懒加载

-(UIControl *)bgView{
    if (!_bgView) {
        _bgView=[[UIControl alloc]init];
        _bgView.backgroundColor=COLOR_RGBA(0x000000, 0.4);
    }
    return _bgView;
}

-(WCGraintCircleLayer *)circleLayer{
    if (!_circleLayer) {
        _circleLayer=[[WCGraintCircleLayer alloc]initGraintCircleWithBounds:CGRectMake(0, 0, 45, 45) Position:CGPointMake(25, 25) FromColor:[UIColor clearColor] ToColor:[UIColor greenColor] LineWidth:5];
    }
    return _circleLayer;
}

-(UIView *)smallbgView{
    if (!_smallbgView) {
        CGFloat weight=[UILabel WidthForText:self.tittle withFontSize:13 withTextHeight:50];
        
        _smallbgView=[[UIView alloc]initWithFrame:CGRectMake(0 , 0, weight+50+5*self.tittle.length, 50)];
    }
    return _smallbgView;
}

-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.smallbgView.frame.size.width-50, 50)];
    }
    return _label;
}

-(void)animationTopShake{
    
    CGPoint toPoint=self.smallbgView.layer.position;
    
    CGPoint startPoint = CGPointMake(toPoint.x, -self.frame.size.height);
    
    self.smallbgView.layer.position=startPoint;
    //damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
    //velocity:弹性复位的速度
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.smallbgView.layer.position=toPoint;
        
    } completion:^(BOOL finished) {
        
    }];
}



@end


@implementation UILabel (utils)

+ (CGFloat)HeightForText:(NSString *)text withFontSize:(CGFloat)fontSize withTextWidth:(CGFloat)textWidth{
    // 获取文字字典
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    // 设定最大宽高
    CGSize size = CGSizeMake(textWidth, 2000);
    // 计算文字Frame
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}

+ (CGFloat)WidthForText:(NSString *)text withFontSize:(CGFloat)fontSize withTextHeight:(CGFloat)textHeight{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake(2000, textHeight);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.width;
}

@end

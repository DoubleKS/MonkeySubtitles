//
//  ShowWordsViewController.m
//  跑马字幕
//
//  Created by huang hua on 2018/11/26.
//  Copyright © 2018年 doublek. All rights reserved.
//

#import "ShowWordsViewController.h"
#import "DKScrollTextLable.h"
@interface ShowWordsViewController ()
@property (nonatomic,strong)DKScrollTextLable *label;
@end

@implementation ShowWordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
     [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    self.view.backgroundColor =[UIColor blackColor];
    DKScrollTextLable *label = [[DKScrollTextLable alloc]initWithFrame:CGRectMake(0, self.view.center.y-44, [UIScreen mainScreen].bounds.size.width, 100)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:50];
    label.text = @"😇😇🐷一些事一些情,🐔一些好音乐,🐺一起陪你到八十岁🥓,八十岁的约定!😜😜✈️ 哈哈哈哈啊哈哈";
    self.label = label;
    [self.view addSubview:label];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}
    
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.label.text = self.showString;
    self.label.font = [UIFont systemFontOfSize:self.fontSize];
    self.label.frame = CGRectMake(0, self.view.center.y-44, [UIScreen mainScreen].bounds.size.width, self.fontSize);
}


- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    //1.获取 当前设备 实例
    UIDevice *device = [UIDevice currentDevice] ;
    /**
     *  2.取得当前Device的方向，Device的方向类型为Integer
     *
     *  必须调用beginGeneratingDeviceOrientationNotifications方法后，此orientation属性才有效，否则一直是0。orientation用于判断设备的朝向，与应用UI方向无关
     *
     *  @param device.orientation
     *
     */
    switch (device.orientation) {
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"竖屏");
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
    self.label.frame = CGRectMake(0, self.view.center.y-44, [UIScreen mainScreen].bounds.size.width, self.fontSize);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

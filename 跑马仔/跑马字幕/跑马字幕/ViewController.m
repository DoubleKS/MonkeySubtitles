//
//  ViewController.m
//  跑马字幕
//
//  Created by doublek on 2017/4/17.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "ViewController.h"
#import "ShowWordsViewController.h"
@interface ViewController ()<UITextViewDelegate>
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)NSString *showString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跑马仔字幕";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [self.view addSubview:({
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 90, self.view.frame.size.width-40, 200)];
        textView.backgroundColor = [UIColor grayColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
        textView.layer.cornerRadius = 10;
        textView.editable = YES;        //设置是否允许编辑内容，默认为“YES”
        textView.delegate = self;       //设置代理方法的实现类
        textView.font=[UIFont fontWithName:@"Arial" size:20.0]; //设置字体名字和字体大小;
        textView.returnKeyType = UIReturnKeyDefault;//设置return键的类型
        textView.keyboardType = UIKeyboardTypeDefault;//设置键盘类型一般为默认
        textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        textView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        textView.textColor = [UIColor blackColor];// 设置显示文字颜色
        self.textView = textView;
    })];
    
    [self.view addSubview:({
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-50, self.view.center.y+44, 100, 50)];
        self.button.backgroundColor = [UIColor grayColor];
        self.button.layer.cornerRadius = 10;
        [self.button setTitle:@"确认" forState:UIControlStateNormal];
        self.button;
    })];
    [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.topItem.title = @"跑马仔字幕";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.showString = textView.text;
}

- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    //1.获取 当前设备 实例
    UIDevice *device = [UIDevice currentDevice] ;
    switch (device.orientation) {
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"屏幕向左横置");
            self.textView.frame = CGRectMake(20, 60, self.view.frame.size.width-40, 150);
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"屏幕向右橫置");
            self.textView.frame = CGRectMake(20, 60, self.view.frame.size.width-40, 150);
            break;
        case UIDeviceOrientationPortrait:
            NSLog(@"竖屏");
             self.textView.frame = CGRectMake(20, 90, self.view.frame.size.width-40, 200);
            break;
        default:
            NSLog(@"无法辨识");
            break;
    }
    self.button.frame = CGRectMake(self.view.center.x-50, self.view.center.y+44, 100, 50);

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)buttonClick:(UIButton *)button{
    
    [self fontSizeClick];
}

-(void)fontSizeClick{
    
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入字体大小" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            UITextField*fontSize = alertController.textFields.firstObject;
            ShowWordsViewController *show = [[ShowWordsViewController alloc]init];
           self.showString = [self.showString stringByReplacingOccurrencesOfString:@"\n" withString:@"   "];
            show.showString = self.showString;
            show.fontSize = [fontSize.text integerValue];
            [self.navigationController pushViewController:show animated:YES];
        
            }]];
    
        [alertController addTextFieldWithConfigurationHandler:^(UITextField*_NonnulltextField) {
             _NonnulltextField.text = @"100";
            _NonnulltextField.keyboardType = UIKeyboardTypeNumberPad;
         }];
    
        [self presentViewController:alertController animated:YES completion:nil];
    
}

@end

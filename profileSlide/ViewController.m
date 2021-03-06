//
//  ViewController.m
//  profileSlide
//
//  Created by S on 15/10/12.
//  Copyright © 2015年 S. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"
#import "UIScrollView+SRefresh.h"
#import "StartView.h"

#define ANGLE(angle) ((M_PI*angle)/180)

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * iview;
    UITableView * _tableview;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    [self leftBtn];
    
}

- (void)leftBtn {
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(slideCLick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn1 setTitle:@"stop" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(rightCLick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn1];
 
    
    
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] init];
    [_tableview addRefreshBlock:^(PanState state) {
        if (state == Pull) {
            NSLog(@"1111");
        }else if (state == Push) {
            NSLog(@"2222");
        }
    }];
     
     [self.view addSubview:_tableview];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identify = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)slideCLick {
    
    LoadingView * loading = [LoadingView share];
    
    loading.frame = CGRectMake(0, 0, 40, 40);
    loading.center = self.view.center;
    
    [loading startLoading];
}

- (void)rightCLick {
    LoadingView * loading = [LoadingView share];
    [loading stopLoading];
    
    [_tableview stopRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

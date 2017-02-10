//
//  FFRootViewController.m
//  FFAnimation
//
//  Created by 张玲玉 on 2017/2/9.
//  Copyright © 2017年 bj.zly.com. All rights reserved.
//

#import "FFRootViewController.h"
#import "FFAViewController.h"
#import "FFBViewController.h"
#import "FFCViewController.h"
#import "FFDViewController.h"

@interface FFRootViewController ()

@property(nonatomic,strong)NSMutableArray *classArray;

@end

@implementation FFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.classArray=[NSMutableArray array];
    [self.classArray addObject:[FFAViewController class]];
    [self.classArray addObject:[FFBViewController class]];
    [self.classArray addObject:[FFCViewController class]];
    [self.classArray addObject:[FFDViewController class]];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text=NSStringFromClass(self.classArray[indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc=[[self.classArray[indexPath.row] alloc] init];
    vc.title=NSStringFromClass(self.classArray[indexPath.row]);
    vc.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  MoreTableView.m
//  KissHealth
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 LWHTteam. All rights reserved.
//

#import "MoreTableView.h"
#import "MoreCell.h"
#import "profileVC.h"
#import "TargetVC.h"
#import "RemindVC.h"
#import "SettingVC.h"


@implementation MoreTableView
{
    NSArray *_imgArray;
    NSArray *_titleArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        _imgArray = @[@"ic_menu_editprofile@2x",@"ic_menu_goals@2x",@"ic_menu_reminders@2x",@"ic_menu_messages@2x",@"ic_menu_settings@2x",@"ic_menu_sync@2x",@"ic_menu_help@2x"];
        _titleArray = @[@"个人资料",@"目标",@"提醒",@"系统邮件",@"设置",@"同步",@"关于版本"];
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"MoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"moreCell"];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imgArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleImg.image = [UIImage imageNamed:_imgArray[indexPath.row]];
    cell.titleLabel.text = _titleArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    headerView.backgroundColor = [UIColor grayColor];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [[self responder].navigationController pushViewController:[[ProfileVC alloc] init] animated:YES];
            break;
        case 1:
            [[self responder].navigationController pushViewController:[[TargetVC alloc] init] animated:YES];
            break;
        case 2:
            [[self responder].navigationController pushViewController:[[RemindVC alloc] init] animated:YES];
            break;
        case 3:

            break;
        case 4:
            [[self responder].navigationController pushViewController:[[SettingVC alloc] init] animated:YES];
            break;

        default:
            break;
    }
}

- (UIViewController *)responder
{
    UIResponder *next = self.nextResponder;
  
    while (next != nil) {
        
        if ([next isKindOfClass:[UIViewController class]]) {
           
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return  nil;
}

@end

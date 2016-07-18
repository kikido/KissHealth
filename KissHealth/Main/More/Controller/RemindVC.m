//
//  RemindVC.m
//  KissHealth
//
//  Created by Apple on 16/2/3.
//  Copyright © 2016年 LWHTteam. All rights reserved.
//

#import "RemindVC.h"

@interface RemindVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray *_weightArray;
    NSArray *_weekArray;
    NSArray *_frequencyArray;
    NSMutableArray *_dateArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minutesArray;

    NSMutableArray *_sectionArray;
    NSMutableArray *_rowTextArray;
    NSMutableArray *_sectionArraySure;
    NSMutableArray *_rowTextArraySure;
    
    UIView *_weightView;
    UIView *_frequencyView;
    UIView *_weekView;
    UIView *_dateView;
    UIView *_timeView;
    UIView *_glassView;
    
    UITableView *_addReminderTV;
    
    NSInteger _index;
    
    UIView *_NoReminderView;
    UIView *_addReminderView;
}

@end

@implementation RemindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    [self _createRightLeftItem];
    [self _createNoReminderView];
    [self _createAddReminderView];
    [self _createArrayAndView];
}

- (void)_createRightLeftItem
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftButton.tag = 300;
    [leftButton setImage:[UIImage imageNamed:@"ic_nav_arrow_left@2x"] forState:UIControlStateNormal];
    leftButton.showsTouchWhenHighlighted = YES;
    [leftButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    rightButton.tag = 301;
    [rightButton setImage:[UIImage imageNamed:@"ic_nav_add@2x"] forState:UIControlStateNormal];
    rightButton.showsTouchWhenHighlighted = YES;
    [rightButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)_createNoReminderView
{
    _NoReminderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _NoReminderView.center = self.view.center;
    NSString *str = @"你尚未设置提醒。";
    NSString *str1 = @"点击上面的“+”按钮添加新提醒";
    NSString *str2 = [NSString stringWithFormat:@"           %@\n%@",str,str1];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2 + 20, 70)];
    label.text = str2;
    label.font = [UIFont systemFontOfSize:13];
    label.center = _NoReminderView.center;
    label.numberOfLines = 0;
    
    [self.view addSubview:_NoReminderView];
    [_NoReminderView addSubview:label];
}

- (void)_createArrayAndView
{
    NSArray *arr = @[@"如果我未记录,提醒我",@"频率",@"周几",@"时间"];
    _sectionArray = [NSMutableArray array];
    _sectionArraySure = [NSMutableArray array];
    [_sectionArray addObjectsFromArray:arr];
    [_sectionArraySure addObjectsFromArray:arr];
    
    NSArray *arr1 = @[@"体重",@"每周",@"星期一",@"07:30"];
    _rowTextArray = [NSMutableArray array];
    _rowTextArraySure = [NSMutableArray array];
    [_rowTextArray addObjectsFromArray:arr1];
    [_rowTextArraySure addObjectsFromArray:arr1];

    _weightArray = @[@"体重",@"早餐",@"午餐",@"晚餐",@"零食",@"任何项目达到1天",@"任何项目达到3天",@"任何项目达到7天"];
    _weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    _frequencyArray = @[@"每天",@"每周",@"每月"];
    
    _dateArray = [NSMutableArray array];
    
    for (int i = 1 ; i < 32; i++) {
        [_dateArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    _hourArray = [NSMutableArray array];
    
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
           [_hourArray addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
           [_hourArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    _minutesArray = [NSMutableArray array];
    
    for (int i = 0; i < 60; i++) {
        
        if (i < 10) {
            [_minutesArray addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
            [_minutesArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    
    _glassView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _glassView.backgroundColor = [UIColor blackColor];
    _glassView.alpha = .3;
    _glassView.hidden = YES;
    _weightView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight,kScreenWidth, kPkViewHeight)];
    _frequencyView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight,kScreenWidth, kPkViewHeight)];
    _dateView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight,kScreenWidth, kPkViewHeight)];
    _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight,kScreenWidth, kPkViewHeight)];
    _weekView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight,kScreenWidth, kPkViewHeight)];
    
    NSArray *arr2 = @[_weightView,_frequencyView,_weekView,_dateView,_timeView];
    for (int i = 0; i < arr2.count; i++) {

        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kPkViewHeight)];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self;
        picker.dataSource = self;
        picker.tag = 500 + i;
        [arr2[i] addSubview:picker];
    }

    [self addHeaderView:_weightView];
    [self addHeaderView:_frequencyView];
    [self addHeaderView:_weekView];
    [self addHeaderView:_dateView];
    [self addHeaderView:_timeView];
    
    [self.view addSubview:_glassView];
    [self.view addSubview:_weightView];
    [self.view addSubview:_frequencyView];
    [self.view addSubview:_weekView];
    [self.view addSubview:_dateView];
    [self.view addSubview:_timeView];
}

- (void)addHeaderView:(UIView *)view
{
    UIView *pkHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    pkHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bar_background@2x.png"]];
    
    CGFloat MinY = (40 - 30) / 2;
    UIButton *pkHeadLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, MinY, 30, 30)];
    pkHeadLeftBtn.tag = 302;
    [pkHeadLeftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [pkHeadLeftBtn setImage:[UIImage imageNamed:@"ic_nav_close@2x"] forState:UIControlStateNormal];
    UIButton *pkHeadRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, MinY, 30, 30)];
    pkHeadRightBtn.tag = 303;
    [pkHeadRightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [pkHeadRightBtn setImage:[UIImage imageNamed:@"ic_nav_checkmark@2x"] forState:UIControlStateNormal];
    [pkHeaderView addSubview:pkHeadRightBtn];
    [pkHeaderView addSubview:pkHeadLeftBtn];
    
    [view addSubview:pkHeaderView];
}

- (void)_createAddReminderView
{
    _addReminderView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    _addReminderView.backgroundColor = [UIColor redColor];
    
    _addReminderTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _addReminderTV.delegate = self;
    _addReminderTV.dataSource = self;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_bar_background@2x.png"]];
    
    CGFloat minX = headerView.center.x - 34;
    CGFloat minY = headerView.center.y + 3.5;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(minX, minY, 68, 7)];
    label.text = @"添加提醒";
    label.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
    leftButton.tag = 304;
    leftButton.showsTouchWhenHighlighted = YES;
    [leftButton setImage:[UIImage imageNamed:@"ic_nav_close@2x"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 45, 25, 30, 30)];
    rightButton.tag = 305;
    rightButton.showsTouchWhenHighlighted = YES;
    [rightButton setImage:[UIImage imageNamed:@"ic_nav_checkmark@2x"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
   
    [headerView addSubview:label];
    [headerView addSubview:leftButton];
    [headerView addSubview:rightButton];
    [self.view addSubview:_addReminderView];
    [_addReminderView addSubview:_addReminderTV];
    [_addReminderView addSubview:headerView];
}

- (void)btnAction:(UIButton *)button
{
    CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    CGRect frame1 = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
    switch (button.tag) {
        case 300:
            self.tabBarController.tabBar.hidden = NO;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 301:
        {[UIView animateWithDuration:.5 animations:^{
            _addReminderView.frame = frame;
        } completion:^(BOOL finished) {
            self.navigationController.navigationBar.hidden = YES;
        }];}
            break;
        case 302:
            [self pkViewHiddenOpen];
            break;
        case 303:
            _rowTextArray = _rowTextArraySure;
            _sectionArray = _sectionArraySure;
            [self pkViewHiddenOpen];
            [_addReminderTV reloadData];
            break;
        case 304:
        {[UIView animateWithDuration:.5 animations:^{
            self.navigationController.navigationBar.hidden = NO;
            _addReminderView.frame = frame1;
        }];}
            break;
        case 305:
        {[UIView animateWithDuration:.5 animations:^{
            self.navigationController.navigationBar.hidden = NO;
            _addReminderView.frame = frame1;
            _NoReminderView.hidden = YES;
        }];}
            break;
        default:
            break;
    }
}

- (void)pkViewHiddenClose
{
    _glassView.hidden = NO;
    CGRect frame = CGRectMake(0, kPkViewHeight + 64, kScreenWidth, kPkViewHeight);
    if ([_rowTextArray[0] isEqualToString:@"体重"]) {
        
        if ([_rowTextArray[1] isEqualToString:@"每周"]) {

            switch (_index) {
                case 0:
                {[UIView animateWithDuration:.3 animations:^{
                    _weightView.frame = frame;
                }];}
                    break;
                case 1:
                {[UIView animateWithDuration:.3 animations:^{
                    _frequencyView.frame = frame;
                }];}
                    break;
                case 2:
                {[UIView animateWithDuration:.3 animations:^{
                    _weekView.frame = frame;
                }];}
                    break;
                case 3:
                {[UIView animateWithDuration:.3 animations:^{
                    _timeView.frame = frame;
                }];}
                    break;
                case 4:
                {[UIView animateWithDuration:.3 animations:^{
                    _dateView.frame = frame;
                }];}
                    break;
                default:
                    break;
                }
        }
        if ([_rowTextArray[1] isEqualToString:@"每天"]) {
            switch (_index) {
                case 0:
                {[UIView animateWithDuration:.3 animations:^{
                    _weightView.frame = frame;
                }];}
                    break;
                case 1:
                {[UIView animateWithDuration:.3 animations:^{
                    _frequencyView.frame = frame;
                }];}
                    break;
                case 2:
                {[UIView animateWithDuration:.3 animations:^{
                    _timeView.frame = frame;
                }];}
                    break;
                default:
                    break;
                }
        }
        if ([_rowTextArray[1] isEqualToString:@"每月"]) {
            
            switch (_index) {
                case 0:
                {[UIView animateWithDuration:.3 animations:^{
                    _weightView.frame = frame;
                }];}
                    break;
                case 1:
                {[UIView animateWithDuration:.3 animations:^{
                    _frequencyView.frame = frame;
                }];}
                    break;
                case 2:
                {[UIView animateWithDuration:.3 animations:^{
                    _dateView.frame = frame;
                }];}
                    break;
                case 3:
                {[UIView animateWithDuration:.3 animations:^{
                    _timeView.frame = frame;
                }];}
                    break;
                default:
                    break;
                }
        }
    }else{
        switch (_index) {
            case 0:
            {[UIView animateWithDuration:.3 animations:^{
                _weightView.frame = frame;
            }];}
                break;
            case 1:
            {[UIView animateWithDuration:.3 animations:^{
                _timeView.frame = frame;
            }];}
            default:
                break;
        }
    }
}

- (void)pkViewHiddenOpen
{
    _glassView.hidden = YES;
    CGRect frame = CGRectMake(0, kScreenHeight, kScreenWidth, kPkViewHeight);
    if ([_rowTextArray[0] isEqualToString:@"体重"]) {
        
        if ([_rowTextArray[1] isEqualToString:@"每周"]) {
            
            switch (_index) {
                case 0:
                {[UIView animateWithDuration:.3 animations:^{
                    _weightView.frame = frame;
                }];}
                    break;
                case 1:
                {[UIView animateWithDuration:.3 animations:^{
                    _frequencyView.frame = frame;
                }];}
                    break;
                case 2:
                {[UIView animateWithDuration:.3 animations:^{
                    _weekView.frame = frame;
                }];}
                    break;
                case 3:
                {[UIView animateWithDuration:.3 animations:^{
                    _timeView.frame = frame;
                }];}
                    break;
                case 4:
                {[UIView animateWithDuration:.3 animations:^{
                    _dateView.frame = frame;
                }];}
                    break;
                default:
                    break;
            }
        }
        if ([_rowTextArray[1] isEqualToString:@"每天"]) {
            switch (_index) {
                case 0:
                {[UIView animateWithDuration:.3 animations:^{
                    _weightView.frame = frame;
                }];}
                    break;
                case 1:
                {[UIView animateWithDuration:.3 animations:^{
                    _frequencyView.frame = frame;
                }];}
                    break;
                case 2:
                {[UIView animateWithDuration:.3 animations:^{
                    _timeView.frame = frame;
                }];}
                    break;
                default:
                    break;
            }
        }
        if ([_rowTextArray[1] isEqualToString:@"每月"]) {
            
            switch (_index) {
                case 0:
                {[UIView animateWithDuration:.3 animations:^{
                    _weightView.frame = frame;
                }];}
                    break;
                case 1:
                {[UIView animateWithDuration:.3 animations:^{
                    _frequencyView.frame = frame;
                }];}
                    break;
                case 2:
                {[UIView animateWithDuration:.3 animations:^{
                    _dateView.frame = frame;
                }];}
                    break;
                case 3:
                {[UIView animateWithDuration:.3 animations:^{
                    _timeView.frame = frame;
                }];}
                    break;
                default:
                    break;
            }
        }
    }else{
        switch (_index) {
            case 0:
            {[UIView animateWithDuration:.3 animations:^{
                _weightView.frame = frame;
            }];}
                break;
            case 1:
            {[UIView animateWithDuration:.3 animations:^{
                _timeView.frame = frame;
            }];}
            default:
                break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _rowTextArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"remindCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"remindCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _rowTextArray[indexPath.section];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionArray[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _index = indexPath.section;
    [self pkViewHiddenClose];
}

#pragma - mark UIPickerView  datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag == 504) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 500:
            return _weightArray.count;
            break;
        case 501:
            return _frequencyArray.count;
            break;
        case 502:
            return _weekArray.count;
            break;
        case 503:
            return _dateArray.count;
            break;
        case 504:
            if (component == 0) {
                return _hourArray.count;
            }
            return _minutesArray.count;
            break;
     
        default:
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 500:
            return _weightArray[row];
            break;
        case 501:
            return _frequencyArray[row];
            break;
        case 502:
            return _weekArray[row];
            break;
        case 503:
            return _dateArray[row];
            break;
        case 504:
            if (component == 0) {
                return _hourArray[row];
            }
            return _minutesArray[row];
            break;
        default:
            break;
    }
    return nil;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (pickerView.tag == 504) {
        return 80;
    }
    return 220;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 500:
            {NSString *str = _weightArray[row];
            NSInteger i = [_weightArray indexOfObject:str];
            if (i == 0) {
                
                NSArray *arr = @[@"如果我未记录,提醒我",@"频率",@"周几",@"时间"];
                _sectionArraySure = [NSMutableArray array];
                [_sectionArraySure addObjectsFromArray:arr];
                
                NSArray *arr1 = @[@"体重",@"每周",@"星期一",@"07:30"];
                _rowTextArraySure = [NSMutableArray array];
                [_rowTextArraySure addObjectsFromArray:arr1];
            }
            if (i != 0 && _rowTextArray.count > 2) {
                
//                if (_index >= 2) {
//                    _index = 1;
//                }
                
                if (_rowTextArray.count == 4) {
                   
                    [_rowTextArraySure removeObjectsInRange:NSMakeRange(1,2)];
                    [_sectionArraySure removeObjectsInRange:NSMakeRange(1,2)];
                }else{
                    
                    [_rowTextArraySure removeObjectAtIndex:1];
                    [_sectionArraySure removeObjectAtIndex:1];
                }
            }
                [_rowTextArraySure replaceObjectAtIndex:0 withObject:str];
            }
            break;
        case 501:
            {NSString *str = _frequencyArray[row];
            NSInteger i = [_frequencyArray indexOfObject:str];
            if (i == 0) {
                
                [_sectionArraySure removeObjectAtIndex:2];
                [_rowTextArraySure removeObjectAtIndex:2];
                [_rowTextArraySure replaceObjectAtIndex:1 withObject:@"每天"];
            }
            if (i == 1) {
               
                NSArray *arr = @[@"如果我未记录,提醒我",@"频率",@"周几",@"时间"];
                _sectionArraySure = [NSMutableArray array];
                [_sectionArraySure addObjectsFromArray:arr];
                
                NSArray *arr1 = @[@"体重",@"每周",@"星期一",@"07:30"];
                _rowTextArraySure = [NSMutableArray array];
                [_rowTextArraySure addObjectsFromArray:arr1];
            }
            if (i == 2) {
                
                NSArray *arr = @[@"如果我未记录,提醒我",@"频率",@"日期",@"时间"];
                _sectionArraySure = [NSMutableArray array];
                [_sectionArraySure addObjectsFromArray:arr];
               
                NSArray *arr1 = @[@"体重",@"每月",@"1",@"07:30"];
                _rowTextArraySure = [NSMutableArray array];
                [_rowTextArraySure addObjectsFromArray:arr1];
            }
            }
            break;
        case 502:
            {NSString *str = _weekArray[row];
                [_rowTextArraySure replaceObjectAtIndex:2 withObject:str];
            }
            break;
        case 503:
            {NSString *str = _dateArray[row];
                [_rowTextArraySure replaceObjectAtIndex:2 withObject:str];
            }
            break;
        case 504:
        {
            NSInteger selectIndex1 = [pickerView selectedRowInComponent:0];
            NSInteger selectIndex2 = [pickerView selectedRowInComponent:1];

            NSString *str2 = [NSString stringWithFormat:@"%@:%@",[_hourArray objectAtIndex:selectIndex1],[_minutesArray objectAtIndex:selectIndex2]];
            if (_rowTextArray.count < 3) {
                
                [_rowTextArraySure replaceObjectAtIndex:1 withObject:str2];
            }else if (_rowTextArray.count == 3){
                [_rowTextArraySure replaceObjectAtIndex:2 withObject:str2];
            }else{
                [_rowTextArraySure replaceObjectAtIndex:3 withObject:str2];
            }
            }
            break;
        default:
            break;
    }
}

@end

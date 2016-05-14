//
//  ViewController.m
//  XYHKeyBoardTableView
//
//  Created by xyh on 16/5/14.
//  Copyright © 2016年 XYH. All rights reserved.
//

#import "ViewController.h"
#import "XYHTableView.h"
@interface ViewController ()

/**tableView*/
@property (nonatomic , strong) XYHTableView *tableView;

/**dataArray*/
@property (nonatomic , strong) NSMutableArray <NSNumber *>*dataArray;


@end

@implementation ViewController

#pragma mark --life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadDataWithArray:self.dataArray];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark event Response


#pragma mark --setter/getter

- (XYHTableView *)tableView{
    if(!_tableView){
        _tableView = [XYHTableView tableViewWithFram:self.view.bounds style:1];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = @[].mutableCopy;
        for (NSInteger i = 0; i < 20; i++) {
            [_dataArray addObject:@(i)];
        }
    }
    return _dataArray;
}
@end

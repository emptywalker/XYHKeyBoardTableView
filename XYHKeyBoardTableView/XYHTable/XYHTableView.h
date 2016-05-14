//
//  XYHTableView.h
//  XYHKeyBoardTableView
//
//  Created by xyh on 16/5/14.
//  Copyright © 2016年 XYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYHTableView : UITableView

+ (instancetype)tableViewWithFram:(CGRect)fram style:(UITableViewStyle)style;


- (void)reloadDataWithArray:(NSMutableArray <NSNumber *>*)dataArray;

@end

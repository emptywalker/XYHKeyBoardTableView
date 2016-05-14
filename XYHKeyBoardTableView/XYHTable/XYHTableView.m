//
//  XYHTableView.m
//  XYHKeyBoardTableView
//
//  Created by xyh on 16/5/14.
//  Copyright © 2016年 XYH. All rights reserved.
//

#import "XYHTableView.h"
#import "XYHTableViewCell.h"

@interface XYHTableView ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

/**dataArray*/
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) CGRect currentTextViewRect;
@end

static NSString *cellID = @"cellID";

@implementation XYHTableView

#pragma mark --life cycle
+ (instancetype)tableViewWithFram:(CGRect)fram style:(UITableViewStyle)style{
    return [[XYHTableView alloc]initWithFrame:fram style:style];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 100.f;
        self.sectionFooterHeight = 100.f;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        UIGestureRecognizer *gesture = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(missKeyBoard)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYHTableViewCell *cell = [XYHTableViewCell tableViewCellWithTabelView:tableView reuseIdentifier:cellID];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100.f)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 2.5, self.frame.size.width - 20.f, 20.f)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"买家留言";
    [footerView addSubview:label];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 25, self.frame.size.width - 10.f, 70.f)];
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 0.5;
    textView.text = @"买家留言";
    textView.tag = section;
    textView.delegate = self;
    textView.textColor = [UIColor grayColor];
    [footerView addSubview:textView];
    return footerView;
}

#pragma mark --UITextFieldDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.currentTextViewRect = [textView convertRect:textView.frame toView:self];
    return YES;
}


#pragma mark --public Method
- (void)reloadDataWithArray:(NSMutableArray <NSNumber *>*)dataArray{
    self.dataArray = dataArray;
    [self reloadData];
}


#pragma mark --event Response
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    //取出键盘最终的frame
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //取出键盘弹出需要花费的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //获取最佳位置距离屏幕上方的距离
    /**
     *这个距离是有相对偏移位置 - 屏幕上方空余高度的偏移量
     */
    if ((self.currentTextViewRect.origin.y + self.currentTextViewRect.size.height) >  ([UIScreen mainScreen].bounds.size.height - rect.size.height)) {//键盘的高度 高于textView的高度 需要滚动
        [UIView animateWithDuration:duration animations:^{
            self.contentOffset = CGPointMake(0, self.currentTextViewRect.origin.y + self.currentTextViewRect.size.height - ([UIScreen mainScreen].bounds.size.height - rect.size.height));
        }];
    }
    
//    NSLog(@"keyRect - %@ \n TVRect - %@ \n contentOffset - %@  ",NSStringFromCGRect(rect), NSStringFromCGRect(self.currentTextViewRect), NSStringFromCGPoint(self.contentOffset));

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];

}

- (void)missKeyBoard{
    [self endEditing:YES];
}


@end

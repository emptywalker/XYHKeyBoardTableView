//
//  XYHTableViewCell.m
//  XYHKeyBoardTableView
//
//  Created by xyh on 16/5/14.
//  Copyright © 2016年 XYH. All rights reserved.
//

#import "XYHTableViewCell.h"

@interface XYHTableViewCell ()

/**goodsImage*/
@property (nonatomic , strong) UIImageView *goodsImage;

/**goodsName*/
@property (nonatomic , strong) UILabel *nameLabel;

/**goodsPrice*/
@property (nonatomic , strong) UILabel *priceLabel;

/**goodsNumber*/
@property (nonatomic , strong) UILabel *numberLabel;

@end

@implementation XYHTableViewCell

#pragma mark --life cycle
+ (instancetype )tableViewCellWithTabelView:(UITableView *)tableView reuseIdentifier:(NSString *)identifier{
    XYHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XYHTableViewCell alloc]initWithStyle:0 reuseIdentifier:identifier];
        cell.selectionStyle = 0;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.goodsImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.numberLabel];
    }
    return self;
}
#pragma mark --setter/getter
- (UIImageView *)goodsImage{
    if(!_goodsImage){
        _goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
        _goodsImage.backgroundColor = [UIColor redColor];
        _goodsImage.image = [UIImage imageNamed:@"tizen"];
    }
    return _goodsImage;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 200, 20)];
        _nameLabel.text = @"我是一件商品";
        _nameLabel.font = [UIFont fontWithName:@"" size:15];

    }
    return _nameLabel;
}

- (UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 100, 20)];
        _priceLabel.font = [UIFont fontWithName:@"" size:16];
        _priceLabel.text = @"￥99.99";
        _priceLabel.textColor = [UIColor lightGrayColor];
    }
    return _priceLabel;
}

- (UILabel *)numberLabel{
    if(!_numberLabel){
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 75, 50, 20)];
        _numberLabel.font = [UIFont fontWithName:@"" size:14];
        _numberLabel.textColor = [UIColor lightGrayColor];
        _numberLabel.text = @"x10";
    }
    return _numberLabel;
}


@end

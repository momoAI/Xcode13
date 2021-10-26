//
//  STableViewCell.m
//  Xcode13
//
//  Created by momo on 2021/10/26.
//

#import "STableViewCell.h"

static NSDictionary * const myConstantDictionary = @{ @"something_awesome" : @YES };

@implementation STableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  CollectionViewCell.m
//  动态宽度View
//
//  Created by 温敬亮 on 2017/3/13.
//  Copyright © 2017年 lanyou. All rights reserved.
//

#import "CollectionViewCell.h"



@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btn sizeToFit];
}

- (void)setTitle:(NSString *)title {
    [self.btn setTitle:title forState:UIControlStateNormal];
}

@end

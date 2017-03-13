//
//  CollectionViewCell.h
//  动态宽度View
//
//  Created by 温敬亮 on 2017/3/13.
//  Copyright © 2017年 lanyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

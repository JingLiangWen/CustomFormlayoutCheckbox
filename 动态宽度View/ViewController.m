//
//  ViewController.m
//  动态宽度View
//
//  Created by 温敬亮 on 2017/3/13.
//  Copyright © 2017年 lanyou. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface LYButton : UIButton

@end

@implementation LYButton

//- (CGSize)intrinsicContentSize {
//    return CGSizeMake(self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
//}

@end

@interface ViewController () <UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray <LYButton *> *mySubViews;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [@[] mutableCopy];
    self.titles = @[@"1adfafadsf12312321312312312312321312312312321312312312312312312312312312123123213213123123123123|",
      @"2adfa",
      @"3adfa",
      @"4adfaafadffadsf",
      @"5addsf",
      @"6dsafasdfasfasfadsfasdfdsafasfdsafdasfdasdfadsfdsa12312312312312fd|",
      @"7fafadsf211231231231231231231232",
      @"8adfasfd",
      @"9adfafadsf",
      @"10adfafadsf"
                    ];
    
    self.mySubViews = [NSMutableArray array];
    [self setup];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self relayout];
}

- (void)setup {
    for (int i = 0; i < self.titles.count; i++) {
        NSString *str = self.titles[i];
        UIButton *btn = [[LYButton alloc]init];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"QMUI_previewImage_checkbox_checked"] forState:UIControlStateNormal];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 1;
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn sizeToFit];
        CGRect f = btn.frame;
        f.origin = CGPointMake(-1, -1);
        btn.frame = f;
        
        [self.view addSubview:btn];
        btn.hidden = YES;
    }
}

- (void)relayout {
    CGFloat minW = self.view.frame.size.width / 3.0;
    //
    __block CGFloat maxX = 0;
    __block CGFloat maxY = 0;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LYButton class]]) {
            
            // 计算下一个item的x,y
            [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[LYButton class]]) {
                    
                    // x
                    if (obj.frame.origin.y == maxY) {
                        maxX = MAX(obj.frame.origin.x + MIN(self.view.frame.size.width, MAX(obj.frame.size.width, minW)), maxX);
                        
                        
                        // 特殊处理
                        int r = fmod(maxX, minW);
                        if (r != 0) { // 无法整除
                            int i = maxX/minW; // 1/2 1- 下一个就是
                            maxX = (i + 1)*minW;
                        }
                    }
                    
                    // y
                    maxY = MAX(obj.frame.origin.y, maxY);
                }
            }];
            
            
            if (maxX + MIN(self.view.frame.size.width, MAX(obj.frame.size.width, minW)) > self.view.frame.size.width) { // 换行
                maxX = 0;
                maxY = maxY + obj.frame.size.height;
            }
            
            CGRect f = obj.frame;
            f.origin = CGPointMake(maxX, maxY);
            obj.frame = CGRectMake(maxX, maxY, MIN(self.view.frame.size.width, MAX(obj.frame.size.width, minW)), obj.frame.size.height);
            obj.hidden = NO;
            
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

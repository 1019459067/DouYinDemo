//
//  SliderSwitch.m
//  DouYinDemo
//
//  Created by HN on 2020/10/19.
//  Copyright © 2020 HN. All rights reserved.
//

#import "SliderSwitch.h"
#import "SliderSwitchCell.h"

@interface SliderSwitch ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//集合视图
@property (nonatomic, strong) UICollectionView *collectionView;

//阴影线条
@property (nonatomic, strong) UIView *shadowLine;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSIndexPath *indexPathSelected;

@end

@implementation SliderSwitch

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray {
    if (self = [super initWithFrame:frame]) {
        self.dataArray = titlesArray;
        [self setttingUI];
        [self.collectionView reloadData];
        
        [self updateShadowLineCenterForIndex:0];
    }
    return self;
}

#pragma mark - UI
- (void)setttingUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SliderSwitchCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(SliderSwitchCell.class)];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
    
    self.shadowLine = [[UIView alloc] init];
    self.shadowLine.backgroundColor = UIColor.whiteColor;
    self.shadowLine.frame = CGRectMake(0, 0, 40, 4);
    self.shadowLine.layer.cornerRadius = self.shadowLine.frame.size.height/2.0f;
    self.shadowLine.layer.masksToBounds = true;
    self.shadowLine.hidden = YES;
    [self addSubview:self.shadowLine];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void)updateShadowLineCenterForIndex:(NSInteger)index {
    SliderSwitchCell *cell = (SliderSwitchCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect cellFrame = cell.frame;
    CGFloat centerX = CGRectGetMidX(cellFrame);
    CGPoint shadowCenter = CGPointMake(centerX, 0);
    if (shadowCenter.x > 0) {
        self.shadowLine.hidden = NO;
        self.shadowLine.center = shadowCenter;
    }else {
        self.shadowLine.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [self updateShadowLineCenterForIndex:index];
        });
    }
}
#pragma mark - other
- (void)updatePositonWithIndex:(NSInteger)index {
    [self updateShadowLineCenterForIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SliderSwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SliderSwitchCell.class) forIndexPath:indexPath];
    if (!cell) {
        cell = [[SliderSwitchCell alloc]init];
    }
    NSString *title = self.dataArray[indexPath.item];
    cell.titleLabel.text = title.length?title:@"";

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//cell size
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100 , 44);
}

//item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indexPathSelected == indexPath) {
        return;
    }
    self.indexPathSelected = indexPath;
    
    if ([self.delegate respondsToSelector:@selector(sliderSwitch:didSelectedIndex:)]) {
        [self.delegate sliderSwitch:self didSelectedIndex:indexPath.item];
    } else {
        [self updateShadowLineCenterForIndex:indexPath.item];
    }
}
@end

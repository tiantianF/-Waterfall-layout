//
//  TTCollectionViewLayout.m
//  WaterfallFlow
//
//  Created by tiantianfang on 15/12/30.
//  Copyright © 2015年 fangtiantian. All rights reserved.
//

#import "TTCollectionViewLayout.h"


static const UIEdgeInsets defaultInsets = {10, 10, 10, 10};

@interface TTCollectionViewLayout ()

@property (nonatomic,strong)NSMutableArray *columnMaxYs;//每一列最大的Y值
@property (nonatomic,strong)NSMutableArray *cellAttrsArray;//存放所有cell的布局属性



@end

@implementation TTCollectionViewLayout
#pragma mark- lazy loading
-(NSMutableArray *)columnMaxYs{
    if (!_columnMaxYs) {
        _columnMaxYs = [[NSMutableArray alloc]init];
    }
    return _columnMaxYs;
}

- (NSMutableArray *)cellAttrsArray{
    if(!_cellAttrsArray){
        _cellAttrsArray = [[NSMutableArray alloc]init];
    }
    return _cellAttrsArray;
}

- (CGFloat)rowMargin{
    if(!_rowMargin){
        _rowMargin = 10;
    }
    return _rowMargin;
}

- (CGFloat)columnMargin{
    if(!_columnMargin){
        _columnMargin = 10;
    }
    return _columnMargin;
}

- (CGFloat)columnNum{
    if(!_columnNum){
        _columnNum = 3;
    }
    return _columnNum;
}

- (CGSize)collectionViewContentSize{
    
    //去除最大的Y
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    for (NSInteger i = 1 ; i < self.columnMaxYs.count; i++) {
        CGFloat colummMaxY = [self.columnMaxYs[i] doubleValue];
        
        if(destMaxY < colummMaxY){
            destMaxY = colummMaxY;
        }
    }
    
    return CGSizeMake(0, destMaxY);
    
}

- (void)prepareLayout{
    [super prepareLayout];
    
    //重置每一列的最大Y
    [self.columnMaxYs removeAllObjects];
    
    for (NSInteger i = 0; i < self.columnNum; i++) {
        [self.columnMaxYs addObject:@(defaultInsets.top)];
    }
    
    
    //计算cell的布局属性
    [self.cellAttrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.cellAttrsArray addObject:attrs];
    }
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.cellAttrsArray;
}


//cell 布局属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //计算indexpath位置cell的布局属性
    
    //水平方向上的总间距
    CGFloat xMargin = defaultInsets.left + defaultInsets.right + (self.columnNum - 1) * self.columnMargin;
    //cell的宽度
    CGFloat w = (self.collectionView.frame.size.width - xMargin) / self.columnNum;
    //cell的高度
    CGFloat h = 50 +arc4random_uniform(150);
    
    
    
    //找出最短的列  和  它最大Y值
    CGFloat destMaxY = [self.columnMaxYs[0] doubleValue];
    NSUInteger destColumn = 0;
    for (NSInteger  i = 1; i<self.columnMaxYs.count ; i++ ) {
        CGFloat columnMaxY = [self.columnMaxYs[i] doubleValue];
        
        if(destMaxY > columnMaxY){
            destMaxY = columnMaxY;
            destColumn = i;
        }
    }
    
    
    
    //cell x 值
    CGFloat x = defaultInsets.left + destColumn * (w + self.columnMargin);
    //cell y 值
    CGFloat y = destMaxY + self.rowMargin;
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新数组中的最大Y值
    self.columnMaxYs[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
    
}

@end

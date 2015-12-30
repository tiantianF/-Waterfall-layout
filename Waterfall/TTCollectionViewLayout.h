//
//  TTCollectionViewLayout.h
//  WaterfallFlow
//
//  Created by tiantianfang on 15/12/30.
//  Copyright © 2015年 fangtiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,assign)CGFloat rowMargin;//每一行之间的间距 默认为10
@property (nonatomic,assign)CGFloat columnMargin;//每一列之间的间距 默认为10
@property (nonatomic,assign)CGFloat columnNum;//列数   默认为3


@end

//
//  ViewController.m
//  Waterfall
//
//  Created by tiantianfang on 15/12/30.
//  Copyright © 2015年 fangtiantian. All rights reserved.
//

#import "ViewController.h"
#import "TTCollectionViewLayout.h"
#import "TTCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionview;
@property (nonatomic,strong)TTCollectionViewLayout *ttLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.ttLayout = [[TTCollectionViewLayout alloc]init];
    self.ttLayout.columnNum = 4;
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:self.ttLayout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    [self.collectionview registerClass:[TTCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionview];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
@end

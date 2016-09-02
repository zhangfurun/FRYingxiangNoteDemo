//
//  NoteCollectionViewController.m
//  FRYingxiangNoteDemo
//
//  Created by 张福润 on 16/9/2.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "NoteCollectionViewController.h"
#import "NoteDetailViewController.h"
#import "NoteCollectionViewCell.h"
#import "NoteFlowLayout.h"
#import "NoteTransition.h"

@interface NoteCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) NSMutableArray * dataSource;

@property (nonatomic , strong) NoteTransition * transition;

@property (nonatomic, strong) NSMutableArray * colorArray;



@end

@implementation NoteCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.collectionViewLayout = [[NoteFlowLayout alloc] init];
    
    [self.collectionView registerClass:[NoteCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([NoteCollectionViewCell class])];
    
    
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
        int number = 0;
        while (number > 6) {
            CGFloat red = arc4random()%255;
            CGFloat green = arc4random()%255;
            CGFloat blue = arc4random()%255;
            [_colorArray addObject:[UIColor colorWithRed:red / 255.f green:green / 255.f blue:blue / 255.f alpha:1]];
            number++;
        }
    }
    return _colorArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSource.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NoteCollectionViewCell class]) forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor purpleColor];
    NoteCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NoteCollectionViewCell class]) forIndexPath:indexPath];
    cell.tag = indexPath.section;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NoteCollectionViewCell * selectedCell = (NoteCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray * visibleCells = collectionView.visibleCells;
    UIStoryboard * stb  = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NoteDetailViewController * VC = [stb instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];
    CGRect finalFrame = CGRectMake(10, collectionView.contentOffset.y + 30,  ScreenW - 20, ScreenH - 40);
    [self.transition noteTransitionWithSelectCell:selectedCell visibleCells:visibleCells originFrame:selectedCell.frame finalFrame:finalFrame panViewController:VC listViewController:self];
    VC.transitioningDelegate = self.transition;
    VC.delegate = self.transition;
    [self presentViewController:VC animated:YES completion:^{
        
    }];
    
}

#pragma mark - getter
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        for (int i = 0; i< 20; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"Note%d",i]];
        }
    }
    return _dataSource;
}

- (NoteTransition *)transition {
    if (!_transition) {
        _transition = [[NoteTransition alloc] init];
    }
    return _transition;
}


@end

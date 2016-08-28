//
//  Created by zZT on 15/4/28.
//  Copyright © 2015年 ZZT. All rights reserved.
//
#import "ZTBaseMenuViewController.h"
#import "UIView+Frame.h"

static NSString * const ID = @"cell";
@interface ZTBaseMenuViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UIScrollView *topTitleView;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, strong)NSMutableArray *buttons;
@property (nonatomic, weak) UIView *underLineView;
@property(nonatomic, assign) BOOL isInitial;
@end

#define ZTGlobeColor ZTColor(215, 215, 215)
#define ZTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define ZTRandomColor ZTColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define ZTScreenW [UIScreen mainScreen].bounds.size.width
#define ZTScreenH [UIScreen mainScreen].bounds.size.height

@implementation ZTBaseMenuViewController

#pragma mark - 懒加载按钮数组
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 添加底部内容view
    [self setupBottomView];
    
    // 添加顶部标题view
    [self setupTopView];
        
    // 不需要自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isInitial == NO) {
        // 设置所有标题
        [self setupAllTitleButton];
        _isInitial = YES;
    }
    
}

#pragma mark -  设置所有标题
- (void)setupAllTitleButton
{
    int count = self.childViewControllers.count;
    CGFloat btnW = ZTScreenW / count;
    CGFloat btnH = _topTitleView.ZT_height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (int i = 0; i < count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [titleBtn setTitle:vc.title forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        btnX = i * btnW;
        titleBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [_topTitleView addSubview:titleBtn];
        [self.buttons addObject:titleBtn];
        
        // 监听按钮
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            
            // 添加下划线
            UIView *underLineView = [[UIView alloc] init];
            underLineView.backgroundColor = [UIColor whiteColor];
            [_topTitleView addSubview:underLineView];
            _underLineView = underLineView;
            
            // 中心点x
            underLineView.ZT_height = 3;
            underLineView.ZT_y = _topTitleView.ZT_height - underLineView.ZT_height;
            // 1.根据控件内容计算尺寸,然后给控件设置尺寸
            [titleBtn.titleLabel sizeToFit];
            underLineView.ZT_width = titleBtn.titleLabel.ZT_width;
            // 一定要先设置尺寸 在设置中心点
            underLineView.ZT_centerX = titleBtn.ZT_centerX;
            
            
            [self titleClick:titleBtn];
        }
    }
}

#pragma mark - 点击标题
- (void)titleClick:(UIButton *)button
{
    NSInteger i = button.tag;
    // 1.选中按钮
    [self selButton:button];
    
    // 2.设置collectionView偏离量
    CGFloat offsetX = i * ZTScreenW;
    _collectionView.contentOffset = CGPointMake(offsetX, 0);
    
}

#pragma mark - UICollectionViewDelegate
// 滚动完成的时候就会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获取页码
    NSInteger page = scrollView.contentOffset.x / ZTScreenW;
    
    // 获取标题按钮
    UIButton *titleButton = self.buttons[page];
    
    // 选中标题
    [self selButton:titleButton];
    
}

#pragma mark - 选中按钮
- (void)selButton:(UIButton *)button
{
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    
    // 修改下划线位置
    [UIView animateWithDuration:0.25 animations:^{
        _underLineView.ZT_centerX = button.ZT_centerX;
        
    }];
    
    self.title = button.titleLabel.text;
}



#pragma mark - 添加底部内容view
- (void)setupBottomView
{
    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    // UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.backgroundColor = ZTGlobeColor;
    [self.view addSubview:collectionView];
    // 不显示水平指示器
    collectionView.showsHorizontalScrollIndicator = NO;
    // 开启分页
    collectionView.pagingEnabled = YES;
    _collectionView = collectionView;
    // 设置collectionView数据源,展示cell,需要把子控制器view添加cell
    collectionView.dataSource = self;
    collectionView.delegate = self;
    // 注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 只要有新的cell出现就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 移除其它子控制器view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 添加对应的子控制器view 到 对应cell
    UIViewController *vc = self.childViewControllers[indexPath.row];
    
    // 默认控制器frame有y值,每次添加的时候,必须重新去设置子控制器的frame
    vc.view.frame = [UIScreen mainScreen].bounds;
    
    // 添加到contentView
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma mark - 添加顶部标题view
- (void)setupTopView
{
    CGFloat y = 64;
    CGFloat x = 0;
    CGFloat w = ZTScreenW;
    CGFloat h = 35;
    // UIScrollView
    UIScrollView *topTitleView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    //    topTitleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    topTitleView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:topTitleView];
    _topTitleView = topTitleView;
    
}




@end
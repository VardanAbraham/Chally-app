//
//  MyProfileViewController.m
//  Chally
//
//  Created by Vardan Abrahamyan on 3/1/15.
//
//

#import "UIScrollView+SVInfiniteScrolling.h"
#import "MyProfileViewController.h"
#import "FeedCell.h"

@interface MyProfileViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIRefreshControl *refreshControl;
}
@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, strong) UIView *buttonsView;
@property (nonatomic, strong) UIButton *chalangesBtn;
@property (nonatomic, strong) UIButton *achievmentsBtn;
@property (nonatomic, strong) UIButton *myMapBtn;
@property (nonatomic, strong) UIButton *savedBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *profileCellIdentifier = @"profileCell";


@implementation MyProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self addUIObjects];
    [self addRefreshControl];
    
    __strong typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController setTitle:@"Profile"];
}

#pragma mark - Button Actions

- (void)popCurrentViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showChalanges:(UIButton *)button
{
    [self.achievmentsBtn setSelected:NO];
    [self.myMapBtn setSelected:NO];
    [self.savedBtn setSelected:NO];
    
    self.chalangesBtn.selected = !self.chalangesBtn.selected;
}

- (void)showAchievments:(UIButton *)button
{
    [self.chalangesBtn setSelected:NO];
    [self.myMapBtn setSelected:NO];
    [self.savedBtn setSelected:NO];
    
    self.achievmentsBtn.selected = !self.achievmentsBtn.selected;
}

- (void)showMyMap:(UIButton *)button
{
    [self.chalangesBtn setSelected:NO];
    [self.achievmentsBtn setSelected:NO];
    [self.savedBtn setSelected:NO];
    
    self.myMapBtn.selected = !self.myMapBtn.selected;
}

- (void)showSaved:(UIButton *)button
{
    [self.chalangesBtn setSelected:NO];
    [self.achievmentsBtn setSelected:NO];
    [self.myMapBtn setSelected:NO];
    
    self.savedBtn.selected = !self.savedBtn.selected;
}

#pragma mark - Custom methods

- (void)addRefreshControl
{
    refreshControl = [UIRefreshControl newAutoLayoutView];
    refreshControl.backgroundColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}


- (void)addUIObjects
{
    [self.view addSubview:self.tableView];
    [self setConstraints];
}

- (void)setConstraints
{
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
}

- (void)refresh
{
    [self.tableView setShowsInfiniteScrolling:YES];
    [refreshControl endRefreshing];
}


#pragma mark - UITableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:profileCellIdentifier];
    [cell.challangeDescriptionLabel setText:@"Lorem ispum dolor sit amet, #constectur adipsicing elit, sed do, eiusmid tempor incidudnt ut labor et dolore magna aliqua ut enim ad"];
    [cell.locationButton setTitle:@"Yerevan, Armenia" forState:UIControlStateNormal];
    [cell.challangeImageView setImage:[UIImage imageNamed:@"feedImg"]];
    [cell.avatarButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"https://pbs.twimg.com/profile_images/1817180934/new_Profile_pic_400x400.jpg"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NF_CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return NF_HEADER_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *hedaerView = [UIView new];
    
    [hedaerView addSubview:self.imageView];
    [hedaerView addSubview:self.buttonsView];
    [self.buttonsView addSubview:self.chalangesBtn];
    [self.buttonsView addSubview:self.achievmentsBtn];
    [self.buttonsView addSubview:self.myMapBtn];
    [self.buttonsView addSubview:self.savedBtn];
    
    [self.imageView autoSetDimensionsToSize:CGSizeMake(UserImageSize, UserImageSize)];
    [self.imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    [self.buttonsView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.buttonsView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.buttonsView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.buttonsView autoSetDimension:ALDimensionHeight toSize:PS_BV_HEIGHT];
    
    [self.chalangesBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1.0];
    [self.chalangesBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1.0];
    [self.chalangesBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:1.0];
    [self.chalangesBtn autoSetDimension:ALDimensionWidth toSize:(self.view.frame.size.width - 5)/4];
    
    [self.achievmentsBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1.0];
    [self.achievmentsBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1.0];
    [self.achievmentsBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.chalangesBtn withOffset:1.0];
    [self.achievmentsBtn autoSetDimension:ALDimensionWidth toSize:(self.view.frame.size.width - 5)/4];
    
    [self.myMapBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1.0];
    [self.myMapBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1.0];
    [self.myMapBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.achievmentsBtn withOffset:1.0];
    [self.myMapBtn autoSetDimension:ALDimensionWidth toSize:(self.view.frame.size.width - 5)/4];
    
    [self.savedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:1.0];
    [self.savedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:1.0];
    [self.savedBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.myMapBtn withOffset:1.0];
    [self.savedBtn autoSetDimension:ALDimensionWidth toSize:(self.view.frame.size.width - 5)/4];
    
    return hedaerView;
}

#pragma mark - Intilazitaion


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor whiteColor]];
        [_tableView registerClass:[FeedCell class] forCellReuseIdentifier:profileCellIdentifier];
    }
    return _tableView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView newAutoLayoutView];
        [_imageView setBackgroundColor:[UIColor blackColor]];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = UserImageSize/2;
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imageView;
}

- (UIView *)buttonsView
{
    if (!_buttonsView) {
        _buttonsView = [UIView newAutoLayoutView];
        [_buttonsView setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _buttonsView;
}

- (UIButton *)chalangesBtn
{
    if (!_chalangesBtn) {
        _chalangesBtn = [UIButton newAutoLayoutView];
        [_chalangesBtn setBackgroundColor:[UIColor whiteColor]];
        [_chalangesBtn setTitle:@"Challanges" forState:UIControlStateNormal];
        [_chalangesBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_chalangesBtn setTitleColor:LIGHTBLUE forState:UIControlStateSelected];
        [_chalangesBtn.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_chalangesBtn addTarget:self action:@selector(showChalanges:) forControlEvents:UIControlEventTouchUpInside];
        [_chalangesBtn setImage:[UIImage imageNamed:@"Challange.png"] forState:UIControlStateNormal];
        [_chalangesBtn setImage:[UIImage imageNamed:@"Challange_selected.png"] forState:UIControlStateSelected];
        [_chalangesBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0, 30.0, 20.0, 30.0)];
        [_chalangesBtn setTitleEdgeInsets:UIEdgeInsetsMake(30.0f, -50.0f, 0.0, 0.0f)];
    }
    return _chalangesBtn;
}

- (UIButton *)achievmentsBtn
{
    if (!_achievmentsBtn) {
        _achievmentsBtn = [UIButton newAutoLayoutView];
        [_achievmentsBtn setBackgroundColor:[UIColor whiteColor]];
        [_achievmentsBtn setTitle:@"Achievments" forState:UIControlStateNormal];
        [_achievmentsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_achievmentsBtn setTitleColor:LIGHTBLUE forState:UIControlStateSelected];
        [_achievmentsBtn.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_achievmentsBtn addTarget:self action:@selector(showAchievments:) forControlEvents:UIControlEventTouchUpInside];
        [_achievmentsBtn setImage:[UIImage imageNamed:@"Achivements.png"] forState:UIControlStateNormal];
        [_achievmentsBtn setImage:[UIImage imageNamed:@"Achivements_selected.png"] forState:UIControlStateSelected];
        [_achievmentsBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0, 30.0, 20.0, 30.0)];
        [_achievmentsBtn setTitleEdgeInsets:UIEdgeInsetsMake(30.0f, -50.0f, 0.0, 0.0f)];
    }
    return _achievmentsBtn;
}

- (UIButton *)myMapBtn
{
    if (!_myMapBtn) {
        _myMapBtn = [UIButton newAutoLayoutView];
        [_myMapBtn setBackgroundColor:[UIColor whiteColor]];
        [_myMapBtn setTitle:@"My Map" forState:UIControlStateNormal];
        [_myMapBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_myMapBtn setTitleColor:LIGHTBLUE forState:UIControlStateSelected];
        [_myMapBtn.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_myMapBtn addTarget:self action:@selector(showMyMap:) forControlEvents:UIControlEventTouchUpInside];
        [_myMapBtn setImage:[UIImage imageNamed:@"MyMap.png"] forState:UIControlStateNormal];
        [_myMapBtn setImage:[UIImage imageNamed:@"MyMap_selected.png"] forState:UIControlStateSelected];
        [_myMapBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0, 30.0, 20.0, 30.0)];
        [_myMapBtn setTitleEdgeInsets:UIEdgeInsetsMake(30.0f, -50.0f, 0.0, 0.0f)];
    }
    return _myMapBtn;
}

- (UIButton *)savedBtn
{
    if (!_savedBtn) {
        _savedBtn = [UIButton newAutoLayoutView];
        [_savedBtn setBackgroundColor:[UIColor whiteColor]];
        [_savedBtn setTitle:@"Saved" forState:UIControlStateNormal];
        [_savedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_savedBtn setTitleColor:LIGHTBLUE forState:UIControlStateSelected];
        [_savedBtn.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_savedBtn addTarget:self action:@selector(showSaved:) forControlEvents:UIControlEventTouchUpInside];
        [_savedBtn setImage:[UIImage imageNamed:@"Myprofile"] forState:UIControlStateNormal];
        [_savedBtn setImage:[UIImage imageNamed:@"MyProfile_selected.png"] forState:UIControlStateSelected];
        [_savedBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0, 30.0, 20.0, 30.0)];
        [_savedBtn setTitleEdgeInsets:UIEdgeInsetsMake(30.0f, -50.0f, 0.0, 0.0f)];
    }
    return _savedBtn;
}

@end

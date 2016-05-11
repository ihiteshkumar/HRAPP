//
//  HomeVC.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "HomeVC.h"
#import "UserProfileCell.h"
#import "StoryTableViewCell.h"
#import "UserModel.h"
#import "StoryModel.h"
#import "StoryVC.h"
#import "WebVC.h"

@interface HomeVC () <UITableViewDelegate, UITableViewDataSource, ShowProfileDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *userArray;
@property (nonatomic, strong) NSArray *storyArray;
@property (nonatomic, strong) StoryModel *storyModel;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MY APP";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"UserProfileCell" bundle:nil] forCellReuseIdentifier:@"UserProfileCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoryTableViewCell"];
    
    [self loadJson];
}

-(void)loadJson {
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"my_json" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error: NULL];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self response:responseArray];
}

-(void) response: (NSArray *) jsonData
{
    self.userArray = [UserModel getDataArray:jsonData];
    self.storyArray = [StoryModel getDataArray:jsonData];
}

#pragma mark - UserProfile ShowProfileDelegate

-(void)showProfileOnWebViewWithURL:(NSString *)url andTitle:(NSString *)titleString {
    WebVC *webVC = [[WebVC alloc] init];
    webVC.titleString = titleString;
    webVC.urlString = url;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell * myCell;
     UserModel *userModel = [self.userArray objectAtIndex:indexPath.row];
    UserProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfileCell" forIndexPath:indexPath];
    cell.userModel = userModel;
    [cell setupSubView];
    [cell setHeightForLabel:cell.frame.size.width];
    cell.delegate = self;
    myCell = cell;
    return myCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryVC *storyVC = [[StoryVC alloc] init];
    storyVC.storyArray = self.storyArray;
    UserModel * userModel = [self.userArray objectAtIndex:indexPath.row];
    storyVC.userID = userModel.userId;
    [self.navigationController pushViewController:storyVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UserModel *userModel = [self.userArray objectAtIndex:indexPath.row];
    return [UserProfileCell getCellHeightWith:userModel.about];
}


@end

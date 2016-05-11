//
//  StoryVC.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "StoryVC.h"
#import "StoryTableViewCell.h"
#import "WebVC.h"
#import "FTWCache.h"
#import "NSString+MD5.h"

@interface StoryVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *userStoryArray;

@end

@implementation StoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Stories";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoryTableViewCell"];
    [self getDataForUser];
    
}
-(void)getDataForUser {
    
    self.userStoryArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.storyArray.count; i++) {
        StoryModel *model = [self.storyArray objectAtIndex:i];
        if (self.userID == model.db) {
            [self.userStoryArray addObject:model];
        }
    }
}
#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userStoryArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell * myCell;
    StoryModel *storyModel = [self.userStoryArray objectAtIndex:indexPath.row];
    
    if (self.userID != storyModel.db) {
        return nil;
    }
    StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryTableViewCell" forIndexPath:indexPath];
    cell.storyModel = storyModel;
    cell.imgView.image = nil;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *imgURL = storyModel.imageURL;
////        NSURL *url = [NSURL URLWithString:imgURL];
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            StoryTableViewCell * cell = (StoryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//
//            cell.imgView.image =  [UIImage imageWithData:data];
//        });
//    });
    [self loadImageFromURL:storyModel.imageURL withTableCell:cell];
    
    
    [cell setupSubView];
    [cell setHeightForLabel:cell.frame.size.width];
    myCell = cell;
    return myCell;
}
- (void) loadImageFromURL:(NSString*)URL withTableCell:(StoryTableViewCell *)cell{
    NSURL *imageURL = [NSURL URLWithString:URL];
    NSString *key = [URL MD5Hash];
    NSData *data = [FTWCache objectForKey:key];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        cell.imgView.image = image;
    } else {
//        cell.imgView.image = [UIImage imageNamed:@"img_def"];
        cell.imgView.image = nil;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            [FTWCache setObject:data forKey:key];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imgView.image = image;
            });
        });
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoryModel *storyModel = self.userStoryArray[indexPath.row];
    WebVC *temp = [[WebVC alloc] init];
    temp.titleString = storyModel.title;
    temp.urlString = storyModel.webURL;
    [self.navigationController pushViewController:temp animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    StoryModel *storyModel = [self.userStoryArray objectAtIndex:indexPath.row];
    if (self.userID != storyModel.db) {
        return 0;
    }
    return [StoryTableViewCell getCellHeightWith:storyModel.storyDescription];
}

@end

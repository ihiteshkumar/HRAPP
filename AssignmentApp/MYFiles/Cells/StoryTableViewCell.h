//
//  StoryTableViewCell.h
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"

@interface StoryTableViewCell : UITableViewCell
@property (nonatomic) StoryModel *storyModel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

-(void)setHeightForLabel:(CGFloat)width;
+(CGFloat)getCellHeightWith:(NSString *)text;
-(void)setupSubView;
@end

//
//  StoryTableViewCell.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "StoryTableViewCell.h"
#define imgViewHeight 553
#define sepratorHeight 20

@interface StoryTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionHeightConstraint;

@end
CGFloat cellFixedHeight;
@implementation StoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setupSubView {
//    self.imgView.image = nil;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *imgURL = self.storyModel.imageURL;
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imgView.image =  [UIImage imageWithData:data];
//        });
//    });
    
    self.titleLabel.text = self.storyModel.title;
    self.createDateLabel.text = self.storyModel.dateVerb;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%@", self.storyModel.likesCount];
    self.commentCountLabel.text =  [NSString stringWithFormat:@"%@", self.storyModel.commentCount];
    self.descriptionLabel.text = self.storyModel.storyDescription;
}

-(void)setHeightForLabel:(CGFloat)width{
    self.descriptionHeightConstraint.constant = [StoryTableViewCell getHeightForLabel:width withString:self.storyModel.storyDescription] + 10;
    cellFixedHeight = self.descriptionHeightConstraint.constant + 15;
}

+(CGFloat) getHeightForLabel:(CGFloat )width withString:(NSString *)text {
    
    if (!text) return 0;
    
    CGSize constraintSize = CGSizeMake(width, 9999);
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0], NSFontAttributeName, nil];
    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    CGRect requiredHeight = [myString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return requiredHeight.size.height;
}

+(CGFloat)getCellHeightWith:(NSString *)text {
    CGFloat height = imgViewHeight + [StoryTableViewCell getHeightForLabel:[UIScreen mainScreen].bounds.size.width withString:text];
    return height + sepratorHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

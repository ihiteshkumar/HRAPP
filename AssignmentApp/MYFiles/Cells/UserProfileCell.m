//
//  UserProfileCell.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "UserProfileCell.h"
#define imgViewHeight 111
#define sepratorHeight 20

@interface UserProfileCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *storycountLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutHeightConstraint;

@end

@implementation UserProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setupSubView {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imgURL = self.userModel.imageURL;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userImg.image =  [UIImage imageWithData:data];
        });
    });
    self.nameLabel.text = self.userModel.username;
    self.usernameLabel.text = self.userModel.handle;
    self.followersLabel.text =  [NSString stringWithFormat:@"%@", self.userModel.followers];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%@", self.userModel.following];
    self.aboutLabel.text = self.userModel.about;
//    self.createdOnLabel.text = [self dateString];
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedForProfile)];
    imageTap.numberOfTapsRequired = 1;
    [self.userImg addGestureRecognizer:imageTap];
    UITapGestureRecognizer *usernameLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedForProfile)];
    imageTap.numberOfTapsRequired = 1;
    [self.usernameLabel addGestureRecognizer:usernameLabelTap];
    UITapGestureRecognizer *nameLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedForProfile)];
    imageTap.numberOfTapsRequired = 1;
    [self.nameLabel addGestureRecognizer:nameLabelTap];
    self.userImg.userInteractionEnabled = YES;
    self.usernameLabel.userInteractionEnabled = YES;
    self.nameLabel.userInteractionEnabled = YES;
}

-(NSString*)dateString{
    NSString *aDate = [NSString stringWithFormat:@"%@", self.userModel.createdOn];
    NSDate *orderDate = [NSDate dateWithTimeIntervalSince1970:[aDate floatValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMM-yyyy"];
    return [formatter stringFromDate:orderDate];
}
-(void)didTappedForProfile {
    [self.delegate showProfileOnWebViewWithURL:self.userModel.webURL andTitle:self.userModel.username];
}

-(void)setHeightForLabel:(CGFloat)width{
    self.aboutHeightConstraint.constant = [UserProfileCell getHeightForLabel:width withString:self.userModel.about] + 10;
}

+(CGFloat) getHeightForLabel:(CGFloat )width withString:(NSString *)text {
    
    if (!text) return 0;
    
    CGSize constraintSize = CGSizeMake(width, 9999);
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0], NSFontAttributeName, nil];
    NSMutableAttributedString *myString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    CGRect requiredHeight = [myString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return requiredHeight.size.height;
}

+(CGFloat)getCellHeightWith: (NSString *) text {
    CGFloat height = imgViewHeight + [UserProfileCell getHeightForLabel:[UIScreen mainScreen].bounds.size.width withString:text];
    return height + sepratorHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

//    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

//
//  UserProfileCell.h
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@protocol ShowProfileDelegate<NSObject>

-(void)showProfileOnWebViewWithURL:(NSString *)url andTitle:(NSString *)titleString;

@end

@interface UserProfileCell : UITableViewCell


@property(weak, nonatomic) id<ShowProfileDelegate> delegate;
@property (nonatomic) UserModel *userModel;
@property (nonatomic) NSNumber *storyCount;
-(void)setHeightForLabel:(CGFloat)width;
+(CGFloat)getCellHeightWith: (NSString *) text;
-(void)setupSubView;

@end

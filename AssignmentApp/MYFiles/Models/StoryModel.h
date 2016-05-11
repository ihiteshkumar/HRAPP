//
//  StoryModel.h
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryModel : NSObject

@property (nonatomic, strong) NSString *storyDescription;
@property (nonatomic, strong) NSString *storyId;
@property (nonatomic, strong) NSString *dateVerb;
@property (nonatomic, strong) NSString *db;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL like_flag;
@property (nonatomic, strong) NSString *likesCount;
@property (nonatomic, strong) NSString *commentCount;

-(id)initWithData: (NSDictionary *) dict;
+(NSArray *)getDataArray:(NSArray *) data;
@end

//
//  StoryModel.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

-(id)initWithData:(NSDictionary *)dict {
    
    self.storyDescription = [dict valueForKey:@"description"];
    self.storyId = [dict valueForKey:@"id"];
    self.dateVerb= [dict valueForKey:@"verb"];
    self.db = [dict valueForKey:@"db"];
    self.imageURL = [dict valueForKey:@"si"];
    self.webURL = [dict valueForKey:@"url"];
    self.type = [dict valueForKey:@"type"];
    self.title = [dict valueForKey:@"title"];
    self.like_flag = [dict valueForKey:@"likes_flag"];
    self.likesCount = [dict valueForKey:@"likes_count"];
    self.commentCount = [dict valueForKey:@"comment_count"];
    return self;
}
+(NSArray*)getDataArray:(NSArray *)data {
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in data) {
        if ([dict objectForKey:@"type"]) {
            StoryModel * model = [[StoryModel alloc] initWithData:dict];
            [modelArray addObject:model];
        }
    }
    return modelArray;
}

@end

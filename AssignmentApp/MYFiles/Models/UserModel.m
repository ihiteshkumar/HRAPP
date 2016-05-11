//
//  UserModel.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(id)initWithData:(NSDictionary *)dict {
    
    
    self.about = [dict valueForKey:@"about"];
    self.userId = [dict valueForKey:@"id"];
    self.username= [dict valueForKey:@"username"];
    self.followers = [dict valueForKey:@"followers"];
    self.following = [dict valueForKey:@"following"];
    self.imageURL = [dict valueForKey:@"image"];
    self.webURL = [dict valueForKey:@"url"];
    self.handle = [dict valueForKey:@"handle"];
    self.is_following = [dict valueForKey:@"is_following"];
    self.createdOn = [dict valueForKey:@"createdOn"];
    
    
    return self;
}
+(NSArray*)getDataArray:(NSArray *)data {
    
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in data) {
        if ([dict objectForKey:@"username"]) {
            UserModel * model = [[UserModel alloc] initWithData:dict];
            [modelArray addObject:model];
        }
    }
    return modelArray;
}


@end

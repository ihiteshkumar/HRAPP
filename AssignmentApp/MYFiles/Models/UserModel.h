//
//  UserModel.h
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSNumber *followers;
@property (nonatomic, strong) NSNumber *following;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *webURL;
@property (nonatomic, strong) NSString *handle;
@property (nonatomic) BOOL is_following;
@property (nonatomic, strong) NSNumber *createdOn;

-(id)initWithData: (NSDictionary *) dict;
+(NSArray *)getDataArray:(NSArray *) data;

@end

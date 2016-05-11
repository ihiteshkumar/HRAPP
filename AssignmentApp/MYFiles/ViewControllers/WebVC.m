//
//  WebVC.m
//  AssignmentApp
//
//  Created by Hitesh Kumar on 29/04/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    NSURL *websiteUrl = [NSURL URLWithString:self.urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];}
@end

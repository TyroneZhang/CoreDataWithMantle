//
//  TYHTTPRequestOperationManager.m
//  CoreDataAndMantle
//
//  Created by Demon_Yao on 8/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYHTTPRequestOperationManager.h"

NSString * const kBaseURLString = @"http://api.talos.ec2-test.augcloud.cn/";


@implementation TYHTTPRequestOperationManager

- (instancetype)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
    
    if (self) {
        
        [self.requestSerializer setValue:@"1" forHTTPHeaderField:@"client_id"];
        
        NSString *const EN = @"en";
        [self.requestSerializer setValue:EN forHTTPHeaderField:@"language_code"];
        [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"site_id"];
        
        NSString *const TAUSD = @"USD";
        [self.requestSerializer setValue:TAUSD forHTTPHeaderField:@"currency_code"];
    }
    
    return self;
}

+ (void)requestHTTPType:(HTTPRequestType)httpType URLPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id, id))completionBlock failure:(void (^)(id, NSError *))failed
{
    if (httpType == kGetHTTPRequestType) {
        
        [[[TYHTTPRequestOperationManager alloc] init] GET:path parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject) {
            completionBlock(operation, responseObject);
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            failed(operation, error);
        }];
        
    } else if (httpType == kPostHTTPRequestType) {
        [[[TYHTTPRequestOperationManager alloc] init] POST:path parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject) {
            completionBlock(operation, responseObject);
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            failed(operation, error);
        }];
    }
}

@end

//
//  TYHTTPRequestOperationManager+TYProductCategory.m
//  CoreDataAndMantle
//
//  Created by Demon_Yao on 8/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYHTTPRequestOperationManager.h"

#define URL_PATH_PRODUCT_CATEGORY (@"categories")

@implementation TYHTTPRequestOperationManager (TYProductCategory)

+ (void)fetchCategoryWithCompletionHandler:(void (^)(id, id))completionBlock failure:(void (^)(id, NSError *))failedBlock
{
    [self requestHTTPType:kGetHTTPRequestType URLPath:URL_PATH_PRODUCT_CATEGORY parameters:@{@"siteId":@"2"} success:^(id operation, id responseObject) {
        [self handleResponse:operation response:responseObject completionHandler:completionBlock];
        
    } failure:^(id operation, NSError *error) {
        failedBlock(operation, error);
    }];
}

+ (void)handleResponse:(AFHTTPRequestOperation *)operation response:(id)responseObject completionHandler:(void (^)(id object, NSError *error))completionBlock
{
    if (completionBlock) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            if ([@"SUCCEED" isEqualToString:responseObject[@"status"]]) {
                completionBlock(operation, responseDict[@"body"]);
            }
        }
    }
}

@end

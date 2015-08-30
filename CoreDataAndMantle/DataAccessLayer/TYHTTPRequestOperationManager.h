//
//  TYHTTPRequestOperationManager.h
//  CoreDataAndMantle
//
//  Created by Demon_Yao on 8/30/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

typedef NS_ENUM(NSInteger, HTTPRequestType) {
    kGetHTTPRequestType,
    kPostHTTPRequestType,
    //and other type,such as delete.
};

@interface TYHTTPRequestOperationManager : AFHTTPRequestOperationManager

+ (void)requestHTTPType:(HTTPRequestType)httpType URLPath:(NSString *)path
             parameters:(NSDictionary *)parameters
                success:(void (^)(id, id))completionBlock
                failure:(void (^)(id, NSError *error))failed;

@end


@interface TYHTTPRequestOperationManager (TYProductCategory)

+ (void)fetchCategoryWithCompletionHandler:(void (^)(id operation, id response))completionBlock failure:(void (^)(id operation, NSError *error))failedBlock;

@end

//
//  TYProuct.m
//  CoreDataAndMantle
//
//  Created by Demon_Yao on 9/4/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TYProuct.h"

@implementation TYProuct

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

//在从coredata中取数据时的数据排序方式
+ (NSSortDescriptor *)sortDescriptor
{
    return [[NSSortDescriptor alloc] initWithKey:@"productId" ascending:YES];
}

#pragma mark - MTLManageSerializing

+ (NSString *)managedObjectEntityName
{
    return NSStringFromClass([self class]);
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{@"categoryId": @"categoryId",
             @"productName": @"productName"
             };
}

@end

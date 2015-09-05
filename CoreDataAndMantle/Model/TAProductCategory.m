//
//  CoreDataMnager.h
//  CoreDataAndMantle
//
//  Created by TyroneZhang on 8/28/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "TAProductCategory.h"
#import <MTLValueTransformer.h>
#import "TYProuct.h"
#import <NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation TAProductCategory

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"iconURL": @"icon",
             @"productId": @"id",
             @"productDescription": @"description"
             };
}

+ (NSValueTransformer *)productIdJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return @([number integerValue]);
    } reverseBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return [number stringValue];
    }];
}

+ (NSValueTransformer *)parentIdJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return @([number integerValue]);
    } reverseBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return [number stringValue];
    }];
}

+ (NSValueTransformer *)productsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TYProuct.class];
}

#pragma mark - Managed object serialization

+ (NSString *)managedObjectEntityName
{
    return NSStringFromClass([self class]);
}

+ (NSDictionary *)managedObjectKeysByPropertyKey
{
    return @{@"productDescription": @"productDescription",
             @"iconURL": @"iconURL",
             @"productId": @"productId",
             @"name": @"name",
             @"parentId": @"parentId"
             };
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey
{
    return @{@"products": TYProuct.class};
}

//在从coredata中取数据时的数据排序方式
+ (NSSortDescriptor *)sortDescriptor
{
    return [[NSSortDescriptor alloc] initWithKey:@"productId" ascending:YES];
}


@end

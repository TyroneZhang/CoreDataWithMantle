//
//  CoreDataMnager.h
//  CoreDataAndMantle
//
//  Created by TyroneZhang on 8/28/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import <MTLManagedObjectAdapter/MTLManagedObjectAdapter.h>

@interface TAProductCategory : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, copy) NSString *iconURL;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger parentId;

+ (NSSortDescriptor *)sortDescriptor;

@end

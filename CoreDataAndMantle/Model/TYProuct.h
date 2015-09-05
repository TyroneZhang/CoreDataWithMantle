//
//  TYProuct.h
//  CoreDataAndMantle
//
//  Created by Demon_Yao on 9/4/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import <MTLManagedObjectAdapter.h>

@interface TYProuct : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, copy) NSString *productName;

@end

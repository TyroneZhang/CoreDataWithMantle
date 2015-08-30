//
//  CoreDataOperations.h
//  CoreDataAndMantle
//
//  Created by TyroneZhang on 8/28/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLManagedObjectAdapter.h>

@class MTLManagedObjectAdapter;
@class MTLModel;

@interface CoreDataOperations : NSObject

/*
 * Save operations
 */
+ (void)saveModels:(NSArray *)models;

+ (void)saveModel:(MTLModel<MTLManagedObjectSerializing> *)model;

/*
 * Delete operations
 */
+ (void)deleteAllByModel:(MTLModel<MTLManagedObjectSerializing> *)model;

+ (void)deleteModels:(NSArray *)models; //every object is MTLModel<MTLManagedObjectSerializing>

/*
 * Query operations
 */
+ (NSArray *)queryModelsByModel:(MTLModel<MTLManagedObjectSerializing> *)model;

@end

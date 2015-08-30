//
//  CoreDataOperations.m
//  CoreDataAndMantle
//
//  Created by TyroneZhang on 8/28/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "CoreDataOperations.h"
#import <MTLModel.h>
#import "CoreDataMnager.h"

@implementation CoreDataOperations

#pragma mark -
#pragma mark - Public Methods

+ (instancetype)shareInstance
{
    static CoreDataOperations *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

/*
 * Save operations
 */
+ (void)saveModels:(NSArray *)models
{
    for (MTLModel<MTLManagedObjectSerializing> *model in models) {
        [[CoreDataOperations shareInstance] createEntityInContext:[CoreDataMnager shareInstance].managedObjectContext data:model];
    }
    
    [[CoreDataMnager shareInstance] saveContext];
}

+ (void)saveModel:(MTLModel<MTLManagedObjectSerializing> *)model
{
    [[CoreDataOperations shareInstance] createEntityInContext:[CoreDataMnager shareInstance].managedObjectContext data:model];
    [[CoreDataMnager shareInstance] saveContext];
}

/*
 * Delete operations
 */
+ (void)deleteAllByModel:(MTLModel<MTLManagedObjectSerializing> *)model
{
    NSManagedObjectContext *context = [CoreDataMnager shareInstance].managedObjectContext;
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:[[CoreDataOperations shareInstance] fetchRequest:model] error:&error];
    NSAssert(!error, @"when deleteAllByModel get errror!");
    
    for (id object in array) {
        [context deleteObject:object];
    }
    [context save:nil];
}

+ (void)deleteModels:(NSArray *)models
{
    if (models.count == 0) return;
    
    NSManagedObjectContext *context = [CoreDataMnager shareInstance].managedObjectContext;
    NSError *error = nil;
    NSArray *allManagedObjects = [context executeFetchRequest:[[CoreDataOperations shareInstance] fetchRequest:[models firstObject]] error:&error];
    NSAssert(!error, @"when deleteModels get errror!");
    
    for (id deleteObject in models) {
        BOOL isDelete = NO;
         for (NSManagedObject *object in allManagedObjects) {
             MTLModel *model = [MTLManagedObjectAdapter modelOfClass:[deleteObject class] fromManagedObject:object error:nil];
             if ([model isEqual:deleteObject]) {
                 [context deleteObject:object];
                 isDelete = YES;
             }
         }
         NSAssert(isDelete == YES, @"%@ delete failed",deleteObject);
    }
    
    [context save:nil];
}

/*
 * Query operations
 */
+ (NSArray *)queryModelsByModel:(MTLModel<MTLManagedObjectSerializing> *)model
{
    NSError *error = nil;
    
    NSArray *datas = [[CoreDataMnager shareInstance].managedObjectContext executeFetchRequest:[[CoreDataOperations shareInstance] fetchRequest:model] error:&error];
    
    NSMutableArray * resultsArray = [NSMutableArray array];
    
    for (NSManagedObject *object in datas) {
        MTLModel *resultObject = [MTLManagedObjectAdapter modelOfClass:[model class] fromManagedObject:object error:nil];
        [resultsArray addObject:resultObject];
    }
    
    NSAssert(!error, @"error---->%@",error);
    
    return resultsArray;
}

#pragma mark -
#pragma mark - Private Methods

- (NSManagedObject *)createEntityInContext:(NSManagedObjectContext *)context data:(MTLModel<MTLManagedObjectSerializing> *)data
{
    NSError *error = nil;
    
    NSManagedObject *object = [MTLManagedObjectAdapter managedObjectFromModel:data insertingIntoContext:context error:&error];
    
    NSAssert(error == nil, @"error-->%@",error);
    
    return object;
}

- (NSFetchRequest *)fetchRequest:(MTLModel<MTLManagedObjectSerializing> *)model
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[[model class] managedObjectEntityName]];
    
    [fetchRequest setSortDescriptors:@[[[model class] sortDescriptor]]];
    
    return fetchRequest;
}

@end

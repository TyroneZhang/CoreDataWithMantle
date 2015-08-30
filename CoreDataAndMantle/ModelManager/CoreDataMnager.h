//
//  CoreDataMnager.h
//  CoreDataAndMantle
//
//  Created by TyroneZhang on 8/28/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataMnager : UIResponder

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+ (instancetype)shareInstance;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

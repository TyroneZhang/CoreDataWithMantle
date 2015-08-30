//
//  ViewController.m
//  CoreDataAndMantle
//
//  Created by Demon_Yao on 8/27/15.
//  Copyright (c) 2015 Tyrone Zhang. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TAProductCategory.h"
#import <MTLManagedObjectAdapter.h>
#import "CoreDataMnager.h"
#import "CoreDataOperations.h"
#import "TYHTTPRequestOperationManager.h"

// Product category
#define URL_PATH_PRODUCT_CATEGORY (@"categories")

@interface ViewController ()

@property (nonatomic, copy) NSArray *categories;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TYHTTPRequestOperationManager fetchCategoryWithCompletionHandler:^(id operation, id response) {
        if ([response isKindOfClass:[NSArray class]]) {
            NSMutableArray *categoryArray = [NSMutableArray array];
            for (NSDictionary *item in response) {
                TAProductCategory *productCategory = [MTLJSONAdapter modelOfClass:[TAProductCategory class] fromJSONDictionary:item error:nil];
                [categoryArray addObject:productCategory];
            }
            self.categories = categoryArray;
            
            // save data
            [self saveOperation];
        }
        
    } failure:^(id operation, NSError *error) {
        
    }];
    
    /* delete operation
     *
    NSArray *array = [self getModelOperation];
    NSLog(@"array = %@",array);
    [self deleteOperation];
    array = [self getModelOperation];
    NSLog(@"after delete = %@",array);
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Core data operation
#pragma mark -

#pragma mark - save data

- (void)saveOperation
{
    [CoreDataOperations saveModels:self.categories];
}


#pragma mark - fetch data

- (NSArray *)getModelOperation
{
    TAProductCategory *object = [[TAProductCategory alloc] init];
    return [CoreDataOperations queryModelsByModel:object];
}

#pragma mark - delete data

- (void)deleteOperation
{
    [CoreDataOperations deleteModels:[self getModelOperation]];
}

@end

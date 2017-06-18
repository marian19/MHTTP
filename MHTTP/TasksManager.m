//
//  TasksManager.m
//  MHTTP
//
//  Created by Marian on 6/14/17.
//  Copyright © 2017 Marian. All rights reserved.
//

#import "TasksManager.h"
#import "AFNetworking.h"
#import "UploadTasks.h"
#import "DownloadTasks.h"
#import "DataTasks.h"

@implementation TasksManager
NSOperationQueue *taskQueue;

+ (TasksManager *)sharedTasksManager
{
    static TasksManager *_sharedTasksManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTasksManager = [[TasksManager alloc] init];
        taskQueue = [[NSOperationQueue alloc] init];
        
    });
    
    return _sharedTasksManager;
}



-(void) executingTasksInSerialOrder:(BOOL)isFIFO{
    if (isFIFO) {
        taskQueue.maxConcurrentOperationCount = 1;
    }
    
}



- (void)uploadTaskWithURL:(NSString *)urlString filePath:(NSString *)filePath progress:(void (^)(double  fractionCompleted))progress successCompletionHandler:(void (^)(id  responseObject))success failureCompletionHandler:(void (^)(NSError * error))failure{
    
    NSError *error = [self isValidRequest];
    if (error == nil) {
        [self extendingBackGroundTaskTime];
        
        [taskQueue addOperationWithBlock:^{
            
            [[UploadTasks new] uploadTaskWithURL:urlString filePath:filePath progress:^(double fractionCompleted) {
                progress(fractionCompleted);
            } successCompletionHandler:^(id responseObject) {
                success(responseObject);
            } failureCompletionHandler:^(NSError *error) {
                failure(error);
            }];
        }];
        
    }else{
        failure(error);
    }
    
    
}

- (void)downloadTaskWithURL:(NSString *)urlString progress:(void (^)(double  fractionCompleted))progress successCompletionHandler:(void (^)(id  filePath))success failureCompletionHandler:(void (^)(NSError * error))failure{
    
    NSError *error = [self isValidRequest];
    if (error == nil) {
        [self extendingBackGroundTaskTime];
        
        [taskQueue addOperationWithBlock:^{
            
            [[DownloadTasks new] downloadTaskWithURL:urlString progress:^(double fractionCompleted) {
                progress(fractionCompleted);
                
            } successCompletionHandler:^(id filePath) {
                success(filePath);
                
            } failureCompletionHandler:^(NSError *error) {
                failure(error);
                
            }];
        }];
        
    }else{
        failure(error);
    }
}

- (void)dataTaskWithURL:(NSString *)urlString method:(HTTPRequestMethod)HTTPRequestMethod withParameters:(NSDictionary*)parameters successCompletionHandler:(void (^)(id  responseObject))success failureCompletionHandler:(void (^)(NSError * error))failure{
    
    NSError *error = [self isValidRequest];
    if (error == nil) {
        [self extendingBackGroundTaskTime];
        
        [taskQueue addOperationWithBlock:^{
            
            [[DataTasks new] dataTaskWithURL:urlString method:HTTPRequestMethod withParameters:parameters successCompletionHandler:^(id responseObject) {
                success(responseObject);
            } failureCompletionHandler:^(NSError *error) {
                failure(error);
            }];
        }];
        
    }else{
        failure(error);
    }
}


- (void)jsonDataTaskWithURL:(NSString *)urlString method:(HTTPRequestMethod)HTTPRequestMethod withParameters:(NSDictionary*)parameters successCompletionHandler:(void (^)(id  responseObject))success  failureCompletionHandler:(void (^)(NSError * error))failure{
    
    NSError *error = [self isValidRequest];
    if (error == nil) {
        [self extendingBackGroundTaskTime];

        [taskQueue addOperationWithBlock:^{
            
            [[DataTasks new] jsonDataTaskWithURL:urlString method:HTTPRequestMethod withParameters:parameters successCompletionHandler:^(id responseObject) {
                success(responseObject);
            } failureCompletionHandler:^(NSError *error) {
                failure(error);
            }];
        }];
        
    }else{
        failure(error);
    }
    
}

-(NSError*)isValidRequest{
    
    NSError *error = nil;
    
    NSUInteger numberOfRequest = taskQueue.operationCount;
    
    if ([[AFNetworkReachabilityManager new] isReachable]) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Connection Error", nil)
                                   };
        
        return [NSError errorWithDomain:NSCocoaErrorDomain
                                   code:-57
                               userInfo:userInfo];
    }else if ([[AFNetworkReachabilityManager new] isReachableViaWiFi]) {
        
        if (numberOfRequest == 6) {
            return  error = [self getReachMaxNumberRequestsError];
        }
    }else  if ([[AFNetworkReachabilityManager new] isReachableViaWWAN]){
        if (numberOfRequest == 2) {
            return  error = [self getReachMaxNumberRequestsError];
        }
    }
    
    return error;
}

-(NSError*)getReachMaxNumberRequestsError{
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"You Reach the max number of concurrent requests.", nil)
                               };
    
    return [NSError errorWithDomain:NSCocoaErrorDomain
                               code:-57
                           userInfo:userInfo];
}

-(void) extendingBackGroundTaskTime{
    UIBackgroundTaskIdentifier backgroundTask  = 0;
    
    UIApplication  *app = [UIApplication sharedApplication];
    
    backgroundTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [taskQueue cancelAllOperations];
        [app endBackgroundTask:backgroundTask];
        
    }];
    

}
@end

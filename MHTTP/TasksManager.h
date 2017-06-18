//
//  TasksManager.h
//  MHTTP
//
//  Created by Marian on 6/14/17.
//  Copyright © 2017 Marian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TasksManager : NSObject

+ (TasksManager *)sharedTasksManager;

-(void) executingTasksInSerialOrder:(BOOL)isFIFO;

- (void)uploadTaskWithURL:(NSString *)urlString filePath:(NSString *)filePath progress:(void (^)(double  fractionCompleted))progress successCompletionHandler:(void (^)(id  responseObject))success failureCompletionHandler:(void (^)(NSError * error))failure;

- (void)downloadTaskWithURL:(NSString *)urlString progress:(void (^)(double  fractionCompleted))progress successCompletionHandler:(void (^)(id  filePath))success failureCompletionHandler:(void (^)(NSError * error))failure;

- (void)dataTaskWithURL:(NSString *)urlString method:(HTTPRequestMethod)HTTPRequestMethod withParameters:(NSDictionary*)parameters successCompletionHandler:(void (^)(id  responseObject))success failureCompletionHandler:(void (^)(NSError * error))failure;


- (void)jsonDataTaskWithURL:(NSString *)urlString method:(HTTPRequestMethod)HTTPRequestMethod withParameters:(NSDictionary*)parameters successCompletionHandler:(void (^)(id  responseObject))success  failureCompletionHandler:(void (^)(NSError * error))failure;

@end

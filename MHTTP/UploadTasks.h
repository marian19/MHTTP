//
//  UploadTasks.h
//  MHTTP
//
//  Created by Marian on 6/14/17.
//  Copyright © 2017 Marian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface UploadTasks : Task

- (void)uploadTaskWithURL:(NSString *)urlString filePath:(NSString *)filePath progress:(void (^)(double  fractionCompleted))progress successCompletionHandler:(void (^)(id  responseObject))success failureCompletionHandler:(void (^)(NSError * error))failure;

@end

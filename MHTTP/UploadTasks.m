//
//  UploadTasks.m
//  MHTTP
//
//  Created by Marian on 6/14/17.
//  Copyright © 2017 Marian. All rights reserved.
//

#import "UploadTasks.h"

@implementation UploadTasks

- (void)uploadTaskWithURL:(NSString *)urlString filePath:(NSString *)filePath progress:(void (^)(double  fractionCompleted))progress successCompletionHandler:(void (^)(id  responseObject))success failureCompletionHandler:(void (^)(NSError * error))failure{

    AFURLSessionManager *manager = [self getSessionManager];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePathURL = [NSURL fileURLWithPath:filePath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePathURL progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            failure(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            success(responseObject);
        }
    }];
    [uploadTask resume];
 }
@end

//
//  Task.m
//  MHTTP
//
//  Created by Marian on 6/14/17.
//  Copyright © 2017 Marian. All rights reserved.
//

#import "Task.h"

@implementation Task

-(AFURLSessionManager *)getSessionManager{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
   return [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

}
@end

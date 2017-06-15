//
//  Task.h
//  MHTTP
//
//  Created by Marian on 6/14/17.
//  Copyright © 2017 Marian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    HTTPRequestGET  = 0,
    HTTPRequestPOST = 1,
    HTTPRequestPUT  = 2,
    HTTPRequestDELETE = 3
}HTTPRequestMethod;

#define kImageTypeArray @"POST", @"GET", @"PUT", @"DELETE", nil

@interface Task : NSObject

-(AFURLSessionManager *)getSessionManager;
@end

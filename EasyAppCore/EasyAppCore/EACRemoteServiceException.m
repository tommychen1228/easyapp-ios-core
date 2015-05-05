//
// Created by cdm on 13-6-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EACRemoteServiceException.h"


@implementation EACRemoteServiceException {

}

+ (void)raiseDefaultException {
    [EACRemoteServiceException raise:@"EACRemoteServiceException" format:@"Can not connect to server"];
}


+ (EACRemoteServiceException *)defaultException {
    EACRemoteServiceException *exception = [[EACRemoteServiceException alloc] initWithName:@"EACRemoteServiceException" reason:@"Can not connect to server" userInfo:nil];
    return exception;
}


@end
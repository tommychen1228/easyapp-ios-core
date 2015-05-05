//
// Created by cdm on 13-6-2.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface EACRemoteServiceException : NSException

+ (void)raiseDefaultException;

+ (EACRemoteServiceException *)defaultException;

@end
//
// Created by cdm on 12-6-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "EACService.h"

@interface EACRemoteServiceFile : NSObject

@property(nonatomic, retain) NSString *filePath;
@property(nonatomic, retain) NSString *paramName;

@end

@interface EACRemoteService : EACService {
@protected
    NSString *_targetURL;
    NSMutableDictionary *_sendParams;
    NSMutableArray *_sendFiles;
}

@property(nonatomic, strong) NSString *targetURL;
@property(nonatomic, strong) NSMutableDictionary *sendParams;
@property(nonatomic, strong) NSMutableArray *sendFiles;
@property(nonatomic, strong) NSString *requestMethod;

- (NSString *)getURL;

- (void)addParams;

@end
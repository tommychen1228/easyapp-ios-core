//
// Created by cdm on 12-6-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EACRemoteService.h"

@implementation EACRemoteServiceFile

@end

@implementation EACRemoteService {

}

- (id)init {
    self = [super init];
    if (self) {
        _sendParams = [[NSMutableDictionary alloc] init];

        _sendFiles = [[NSMutableArray alloc] init];

        self.requestMethod = @"POST";
    }

    return self;
}


- (void)willExecute {
    [super willExecute];

    self.targetURL = [[self getURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self addParams];
}


- (NSString *)getURL {
    return nil;
}

- (void)addParams {

}

@end
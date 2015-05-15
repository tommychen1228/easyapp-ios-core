//
//  Service.m
//
//  Created by cdm on 11-10-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "EACService.h"

@interface EACService ()

@property(nonatomic) BOOL isCanceled;
@property(nonatomic, strong) NSOperationQueue *queue;
@property(nonatomic, strong) NSInvocationOperation *operation;

@end

@implementation EACService


- (id)init {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:1];
    }

    return self;
}

- (void)dealloc {
    [_queue cancelAllOperations];
    [_operation cancel];
}

- (id)syncExecute {
    [self doSyncExecute];
    return _executeResult;
}

- (void)asyncExecute {
    self.operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doAsyncExecute) object:nil];
    [_queue addOperation:_operation];
}

- (void)asyncExecuteWithComplete:(void (^)(EACService *))onComplete andSuccess:(void (^)(EACService *, id))onSuccess andFault:(void (^)(EACService *, NSException *))onFault {
    _onCompleteBlock = [onComplete copy];
    _onSuccessBlock = [onSuccess copy];
    _onFaultBlock = [onFault copy];

    _operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doAsyncExecute) object:nil];
    [_queue addOperation:_operation];
}

- (void)willExecute {

}

- (void)doAsyncExecute {
    @try {
        [self doSyncExecute];
        if ([_delegate respondsToSelector:_onCompleteSelector]) {
            [_delegate performSelectorOnMainThread:_onCompleteSelector withObject:nil waitUntilDone:NO];
        }
        if(_onCompleteBlock){
            dispatch_sync(dispatch_get_main_queue(), ^{
                _onCompleteBlock(self);
            });

        }

        if([_delegate respondsToSelector:_onSuccessSelector]){
            [_delegate performSelectorOnMainThread:_onSuccessSelector withObject:_executeResult waitUntilDone:NO];
        }
        if(_onSuccessBlock){
            dispatch_sync(dispatch_get_main_queue(), ^{
                _onSuccessBlock(self, _executeResult);
            });
        }
    }
    @catch (NSException *ex) {
        self.executeException = ex;

        if ([_delegate respondsToSelector:_onCompleteSelector]) {
            [_delegate performSelectorOnMainThread:_onCompleteSelector withObject:nil waitUntilDone:NO];
        }
        if (_onCompleteBlock){
            dispatch_sync(dispatch_get_main_queue(), ^{
                _onCompleteBlock(self);
            });
        }

        if ([_delegate respondsToSelector:_onFaultSelector]) {
            [self performSelectorOnMainThread:_onFaultSelector withObject:_executeException waitUntilDone:NO];
        }
        if(_onFaultBlock){
            dispatch_sync(dispatch_get_main_queue(), ^{
                _onFaultBlock(self, _executeException);
            });
        }

    }
}

- (void)doSyncExecute {

    [self willExecute];
    id result = [self onExecute];
    id newResult = [self didExecute:result];
    self.executeResult = newResult;

}

- (id)didExecute:(id)result {
    return result;
}

- (id)onExecute {
    return nil;
}

- (void)cancel {
    [_operation cancel];
    [_queue cancelAllOperations];
}

@end


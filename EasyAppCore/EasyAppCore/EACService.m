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

- (void)performSuccessBlock;

- (void)performFaultBlock;

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

- (void)asyncExecuteSuccess:(void (^)(EACService *, id))onSuccess andFault:(void (^)(EACService *, NSException *))onFault {
    self.onSuccessBlock = [onSuccess copy];
    self.onFaultBlock = [onFault copy];

    self.operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doAsyncExecute) object:nil];
    [_queue addOperation:_operation];
}

- (void)willExecute {

}

- (void)doAsyncExecute {
    @try {
        [self doSyncExecute];
    }
    @catch (NSException *ex) {
        self.executeException = ex;

        if ([self.delegate respondsToSelector:_onFaultSelector]) {
            [self.delegate performSelectorOnMainThread:_onFaultSelector withObject:ex waitUntilDone:NO];
        }

        if (_onFaultBlock) {
            [self performSelectorOnMainThread:@selector(performFaultBlock) withObject:nil waitUntilDone:NO];
        }


    }
}

- (void)doSyncExecute {

    [self willExecute];
    id result = [self onExecute];
    id newResult = [self didExecute:result];
    self.executeResult = newResult;

    if ([_delegate respondsToSelector:_onSuccessSelector]) {
        [_delegate performSelectorOnMainThread:_onSuccessSelector withObject:newResult waitUntilDone:NO];
    }

    if (_onSuccessBlock) {
        [self performSelectorOnMainThread:@selector(performSuccessBlock) withObject:nil waitUntilDone:NO];
    }

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

- (void)performSuccessBlock {
    _onSuccessBlock(self, _executeResult);
}

- (void)performFaultBlock {
    _onFaultBlock(self, _executeException);
}

@end


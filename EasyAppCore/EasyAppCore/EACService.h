//
//  Service.h
//
//  Created by cdm on 11-10-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>




@class EACService;

@interface EACService : NSObject

@property(nonatomic, strong) id delegate;
@property(nonatomic) SEL onSuccessSelector;
@property(nonatomic) SEL onFaultSelector;
@property(nonatomic, strong) id executeResult;
@property(nonatomic, strong) NSException *executeException;
@property(nonatomic, strong) void (^onSuccessBlock)(EACService *, id);
@property(nonatomic, strong) void (^onFaultBlock)(EACService *, id);

- (id)syncExecute;

- (void)asyncExecute;
- (void)asyncExecuteSuccess:(void (^)(EACService *, id))onSuccess andFault:(void (^)(EACService *, NSException *))onFault;

- (void)willExecute;

- (void)doSyncExecute;

- (void)doAsyncExecute;

- (id)didExecute:(id)result;

- (id)onExecute;

- (void)cancel;

@end

//
// Created by cdm on 12-6-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EACBizService.h"
#import "EACStringRemoteService.h"
#import "EACJSONStringRemoteService.h"

@interface EACBizService ()

@end


@implementation EACBizService {

}

- (NSString *)remoteString:(NSString *)method url:(NSString *)url params:(NSDictionary *)params formFiles:(NSArray *)files {
    EACStringRemoteService *stringRemoteService = [[EACStringRemoteService alloc] init];
    stringRemoteService.requestMethod = [method uppercaseString];
    stringRemoteService.targetURL = url;
    stringRemoteService.sendParams = [NSMutableDictionary dictionaryWithDictionary:params];
    stringRemoteService.sendFiles = [NSMutableArray arrayWithArray:files];
    NSString *result = [stringRemoteService syncExecute];
    return result;
}

- (NSString *)remoteString:(NSString *)method url:(NSString *)url params:(NSDictionary *)params {
    NSString *result = [self remoteString:method url:url params:params formFiles:nil];
    return result;
}

- (NSString *)remoteString:(NSString *)method url:(NSString *)url {
    NSString *result = [self remoteString:method url:url params:nil];
    return result;
}


- (id)remoteJSON:(NSString *)method url:(NSString *)url params:(NSDictionary *)params formFiles:(NSArray *)files {
    EACJSONStringRemoteService *jsonStringRemoteService = [[EACJSONStringRemoteService alloc] init];
    jsonStringRemoteService.requestMethod = method;
    jsonStringRemoteService.targetURL = url;
    jsonStringRemoteService.sendParams = [NSMutableDictionary dictionaryWithDictionary:params];
    jsonStringRemoteService.sendFiles = [NSMutableArray arrayWithArray:files];
    id result = [jsonStringRemoteService syncExecute];
    return result;
}

- (NSString *)remoteJSON:(NSString *)method url:(NSString *)url params:(NSDictionary *)params {
    id result = [self remoteJSON:method url:url params:params formFiles:nil];
    return result;
}

- (NSString *)remoteJSON:(NSString *)method url:(NSString *)url {
    id result = [self remoteJSON:method url:url params:nil];
    return result;
}


@end

@implementation EACBizServiceResult

@end
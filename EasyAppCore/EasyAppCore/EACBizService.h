//
// Created by cdm on 12-6-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "EACService.h"


@interface EACBizService : EACService


- (NSString *)remoteString:(NSString *)method url:(NSString *)url params:(NSDictionary *)params formFiles:(NSArray *)files;

- (NSString *)remoteString:(NSString *)method url:(NSString *)url params:(NSDictionary *)params;

- (NSString *)remoteString:(NSString *)method url:(NSString *)url;

- (id)remoteJSON:(NSString *)method url:(NSString *)url params:(NSDictionary *)params formFiles:(NSArray *)files;

- (id)remoteJSON:(NSString *)method url:(NSString *)url params:(NSDictionary *)params;

- (id)remoteJSON:(NSString *)method url:(NSString *)url;

@end
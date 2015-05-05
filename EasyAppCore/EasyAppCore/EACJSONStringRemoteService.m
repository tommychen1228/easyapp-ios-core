//
// Created by cdm on 12-6-28.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EACJSONStringRemoteService.h"

@implementation EACJSONStringRemoteService {

}

- (id)onExecute {
    NSString *jsonStr = [super onExecute];

    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];

    return jsonObject;
}

@end
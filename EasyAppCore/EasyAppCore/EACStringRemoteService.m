//
// Created by cdm on 12-6-27.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EACStringRemoteService.h"
#import "ASIFormDataRequest.h"
#import "EACLog.h"
#import "EACRemoteServiceException.h"

@implementation EACStringRemoteService {

}

- (id)onExecute {
    NSString *log = [NSString stringWithFormat:@"Request '%@' url %@, send params %@, send files %@", self.requestMethod, self.targetURL, self.sendParams, self.sendFiles];
    EAC_LOG_D(self, log);

    if (!_targetURL) {
        return nil;
    }

    NSTimeInterval timeOutSeconds = 60;
    
    [ASIHTTPRequest setDefaultTimeOutSeconds:timeOutSeconds];
    // param加密

    NSURL *requestUrl = [NSURL URLWithString:_targetURL];

    ASIHTTPRequest *request = nil;

    if ([self.requestMethod isEqualToString:@"POST"]) {
        ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:requestUrl];
        for (NSString *key in _sendParams.allKeys) {
            id value = [_sendParams valueForKey:key];
            [postRequest setPostValue:value forKey:key];
        }

        for (EACRemoteServiceFile *file in _sendFiles) {
            [postRequest addFile:file.filePath forKey:file.paramName];
        }

        [postRequest startSynchronous];

        request = postRequest;

    } else {


        NSMutableString *paramStr = [[NSMutableString alloc] init];
        for (NSString *key in _sendParams.allKeys) {
            id value = _sendParams[key];
            [paramStr appendFormat:@"%@=%@&", key, value];
        }

        requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", requestUrl, paramStr]];
        ASIHTTPRequest *getRequest = [ASIHTTPRequest requestWithURL:requestUrl];

        [getRequest startSynchronous];

        request = getRequest;
    }

    request.timeOutSeconds = timeOutSeconds;
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    // result
    int statusCode = request.responseStatusCode;
    NSString *resultString = request.responseString;

    NSString *log2 = [NSString stringWithFormat:@"Request url %@, send params %@, send files %@, status %d,  result %@", self.targetURL, self.sendParams, self.sendFiles, statusCode, resultString];
    EAC_LOG_D(self, log2);

    if (statusCode != 200) {
        EACRemoteServiceException *remoteServiceException = [EACRemoteServiceException defaultException];
        @throw(remoteServiceException);
    }



    return resultString;
}


@end
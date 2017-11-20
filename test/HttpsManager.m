//
//  HttpsManager.m
//  test
//
//  Created by yanzhen on 2017/11/17.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

#import "HttpsManager.h"

static NSString *const baseUrl = @"https://192.168.0.87:8445";

@interface HttpsManager ()<NSURLSessionDelegate>

@end

@implementation HttpsManager

+(void)post:(NSString *)name parameters:(NSDictionary *)parameters succeed:(void (^)(id))succeedBlcok failed:(void (^)(NSError *))failedBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",baseUrl,name];
    __block NSMutableString *keyValues = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSArray * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyValues appendFormat:@"&%@=%@",key,obj];
    }];
    [keyValues replaceCharactersInRange:NSMakeRange(0, 1) withString:@"?"];
    urlStr = [urlStr stringByAppendingString:keyValues];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    HttpsManager *manamer = [[HttpsManager alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:manamer delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failedBlock) {
                failedBlock(error);
            }
        }else{
            if (succeedBlcok) {
                id rr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                failedBlock(rr);
            }
        }
    }];
    [task resume];
}

+(void)get:(NSString *)name parameters:(NSDictionary *)parameters succeed:(void (^)(id))succeedBlcok failed:(void (^)(NSError *))failedBlock
{
    //https://192.168.0.87:8445/api/app/auth?appID=1&auth=d3893a3d8d6b5974c2dc1a584006ddb7
    //https://192.168.0.87:8445/api/app/auth?appID=1&auth=d3893a3d8d6b5974c2dc1a584006ddb7
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",baseUrl,name];
    __block NSMutableString *keyValues = [NSMutableString string];
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSArray * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyValues appendFormat:@"&%@=%@",key,obj];
    }];
    [keyValues replaceCharactersInRange:NSMakeRange(0, 1) withString:@"?"];
    urlStr = [urlStr stringByAppendingString:keyValues];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    HttpsManager *manamer = [[HttpsManager alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:manamer delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (failedBlock) {
                failedBlock(error);
            }
        }else{
            if (succeedBlcok) {
                id rr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                failedBlock(rr);
            }
        }
    }];
    [task resume];
}


- (BOOL)promiss:(SecTrustRef)serverTrust
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"11" ofType:@"cer"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id certificateData = (__bridge_transfer id)SecCertificateCreateWithData(NULL, (__bridge CFDataRef)data);
    NSArray *datas = @[certificateData];
    OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)datas);
    if (status != noErr) {
        NSLog(@"TTTT:--------Fail----data");
        return NO;
    }
    
    SecTrustResultType trustResult = kSecTrustResultInvalid;
    status = SecTrustEvaluate(serverTrust, &trustResult);
    if (status != noErr) {
        NSLog(@"TTTT:--------Result----data");
        return NO;
    }
    BOOL isValid = (trustResult == kSecTrustResultUnspecified || trustResult == kSecTrustResultProceed);
    if (!isValid) {
#warning mark - 失败
        //kSecTrustResultRecoverableTrustFailure
        NSLog(@"TTTT:--------Result----Fail");
    }else{
        NSLog(@"--- %s ---",__func__);
    }
    return isValid;
}

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([self promiss:challenge.protectionSpace.serverTrust]) {
            //NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            //completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        }else{
            //completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }else{
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}


@end

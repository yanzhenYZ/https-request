//
//  ViewController.m
//  test
//
//  Created by yanzhen on 2017/11/17.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "HttpsManager.h"

//#define main_url @"https://192.168.0.87:8445/api/app/auth"
#define main_url @"https://192.168.0.87:8445"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
    [self https];
    
}


- (void)test1{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:main_url]];
    /*
     static BOOL AFServerTrustIsValid(SecTrustRef serverTrust) {
     BOOL isValid = NO;
     SecTrustResultType result;
     __Require_noErr_Quiet(SecTrustEvaluate(serverTrust, &result), _out);
     isValid = (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);//失败
     _out:
     return isValid;
     */
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    NSString *md5 = [self md5:@"1demoappsecret"];
    NSDictionary *dict = @{
                           @"appID" : @"1",
                           @"auth"  : md5
                           };
    [manager GET:@"/api/app/auth" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"TTTT:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"TTTT -- Error:%@",error);
    }];
}

- (void)https{
    NSString *md5 = [self md5:@"1demoappsecret"];
    NSDictionary *dict = @{
                           @"appID" : @"1",
                           @"auth"  : md5
                           };
    [HttpsManager get:@"/api/app/auth" parameters:dict succeed:^(id response) {
        NSLog(@"TTTT:%@",response);
    } failed:^(NSError *error) {
        NSLog(@"TTTT:%@",error);
    }];
}

- (void)test2{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:main_url]];
    // 2.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    NSString *md5 = [self md5:@"1demoappsecret"];
    NSDictionary *dict = @{
                           @"appID" : @"1",
                           @"auth"  : md5
                           };
    [manager GET:@"/api/app/auth" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"TTTT:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"TTTT -- Error:%@",error);
    }];
}

//https://192.168.0.87:8445/api/app/auth?appID=1&auth=d3893a3d8d6b5974c2dc1a584006ddb7

- (NSString *)md5:(NSString *)str
{
    const char *cStr = str.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}



@end

//
//  NetManager.m
//  test
//
//  Created by yanzhen on 16/6/7.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import "NetManager.h"
#import "AFNetworking.h"

#define K_Server_Main_URL @"https://192.168.0.87"

@implementation NetManager

+(void)getRequest:(NSDictionary *)parameters succeed:(void (^)(id))succeedBlcok failed:(void (^)(NSError *))failedBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 12;
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    [manager GET:K_Server_Main_URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succeedBlcok) {
            succeedBlcok(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

+ (void)get:(NSString *)usrString succeed:(void (^)(id))succeedBlcok failed:(void (^)(NSError *))failedBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    //设置超时时间
    manager.requestSerializer.timeoutInterval = 12;
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    [manager GET:usrString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succeedBlcok) {
            succeedBlcok(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

+(void)postRequest:(NSDictionary *)parameters succeed:(void (^)(id))succeedBlcok failed:(void (^)(NSError *))failedBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    NSString *urlString = [NSString stringWithFormat:@"%@?",K_Server_Main_URL];
//    urlString = [urlString stringByAppendingString:[UZTUtil dictionaryToUrlStr:parameters]];
    NSLog(@"BM + post : %@&debug=1",urlString);
    [manager POST:K_Server_Main_URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (succeedBlcok) {
            succeedBlcok(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

@end

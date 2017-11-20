//
//  NetManager.h
//  Y&Z
//
//  Created by yanzhen on 16/6/7.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define JSON @"application/json"
//#define XMLL @"text/html"
//typedef void(^GetDataFinishedBlock)(id responseObj);
//typedef void(^GetDataFailedBlock)(NSString *error);
@interface NetManager : NSObject

/**
 * @brief Get请求的方法
 *
 * @param parameters          请求参数
 * @param succeedBlcok        请求成功
 * @param failedBlock         请求失败
 *
 */
+ (void)getRequest:(NSDictionary *)parameters succeed:(void (^)(id response))succeedBlcok failed:(void (^)(NSError *error))failedBlock;

+ (void)get:(NSString *)usrString succeed:(void (^)(id response))succeedBlcok failed:(void (^)(NSError *error))failedBlock;

/**
 * @brief POST请求的方法
 *
 * @param parameters          请求参数
 * @param succeedBlcok        请求成功
 * @param failedBlock         请求失败
 *
 */
+ (void)postRequest:(NSDictionary *)parameters succeed:(void (^)(id response))succeedBlcok failed:(void (^)(NSError *error))failedBlock;


@end

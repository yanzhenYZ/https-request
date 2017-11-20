//
//  HttpsManager.h
//  test
//
//  Created by yanzhen on 2017/11/17.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsManager : NSObject
+ (void)get:(NSString *)name parameters:(NSDictionary *)parameters succeed:(void (^)(id response))succeedBlcok failed:(void (^)(NSError *error))failedBlock;

+ (void)post:(NSString *)name parameters:(NSDictionary *)parameters succeed:(void (^)(id response))succeedBlcok failed:(void (^)(NSError *error))failedBlock;
@end

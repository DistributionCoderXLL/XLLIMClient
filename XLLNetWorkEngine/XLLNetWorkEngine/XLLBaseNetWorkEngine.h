//
//  XLLBaseNetWorkEngine.h
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//  主要对请求参数、返回数据进行处理

#import <Foundation/Foundation.h>

@interface XLLBaseNetWorkEngine : NSObject

/**
 POST请求

 @param url 请求路径
 @param params 请求参数
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POSTWithPath:(NSString *)url
              params:(NSDictionary *)params
            progress:(void(^)(NSProgress *uploadProgress))progress
             success:(void(^)(id dataObject))success
             failure:(void(^)(NSError *error))failure;

/**
 GET请求

 @param url 请求路径
 @param params 请求参数
 @param progress 进度回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GETWithPath:(NSString *)url
             params:(NSDictionary *)params
           progress:(void(^)(NSProgress *uploadProgress))progress
            success:(void(^)(id dataObject))success
            failure:(void(^)(NSError *error))failure;

/**
 PUT请求

 @param url 请求路径
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)PUTWithPath:(NSString *)url
             params:(NSDictionary *)params
            success:(void(^)(id dataObject))success
            failure:(void(^)(NSError *error))failure;

/**
 DELETE请求

 @param url 请求路径
 @param params 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)DELETEWithPath:(NSString *)url
                params:(NSDictionary *)params
               success:(void(^)(id dataObject))success
               failure:(void(^)(NSError *error))failure;

/**
 文件上传POST请求

 @param url 请求路径
 @param params 请求参数
 @param fileName 文件名
 @param fileDatas 文件集合
 @param fileDataKey 文件key
 @param progress 上传进度回调
 @param success 成功回调
 @param failure 失败回调
 @return 上传任务
 */
+ (NSURLSessionDataTask *)filePOSTWithPath:(NSString *)url
                                    params:(NSDictionary *)params
                                  fileName:(NSString *)fileName
                                 fileDatas:(NSArray *)fileDatas
                               fileDataKey:(NSString *)fileDataKey
                                  progress:(void(^)(NSProgress *uploadProgress))progress
                                   success:(void(^)(id dataObject))success
                                   failure:(void(^)(NSError *error))failure;


@end

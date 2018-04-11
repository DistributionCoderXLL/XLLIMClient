//
//  XLLHttpManager.h
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLLHttpManager : NSObject

/**
 初始化请求实例
 
 @return 请求实例
 */
+ (instancetype)sharedHttpManager;

/**
 普通的POST请求

 @param url 请求路径
 @param params 请求参数
 @param progress 请求响应进度
 @param success 成功回执
 @param failure 失败回执
 */
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
    progress:(void(^)(NSProgress *uploadProgress))progress
     success:(void(^)(NSURLSessionDataTask *operation, id responseObject))success
     failure:(void(^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 GET请求

 @param url 请求路径
 @param params 请求参数
 @param progress 请求响应进度
 @param success 成功回执
 @param failure 失败回执
 */
- (void)GET:(NSString *)url
     params:(NSDictionary *)params
   progress:(void(^)(NSProgress *uploadProgress))progress
    success:(void(^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 PUT请求

 @param url 请求路径
 @param params 请求参数
 @param success 成功回执
 @param failure 失败回执
 */
- (void)PUT:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(NSURLSessionDataTask *operation, id responseObject))success
    failure:(void(^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 DELETE请求

 @param url 请求路径
 @param params 请求参数
 @param success 成功回执
 @param failure 失败回执
 */
- (void)DELETE:(NSString *)url
        params:(NSDictionary *)params
       success:(void(^)(NSURLSessionDataTask *operation, id responseObject))success
       failure:(void(^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 multipart/form-data类型的文件上传POST

 @param url 请求路径
 @param params 请求参数
 @param fileName 文件名
 @param fileDatas 文件集合
 @param fileDataKey 文件对应key
 @param progress 上传进度
 @param success 成功回执
 @param failure 失败回执
 @return 上传任务
 */
- (NSURLSessionDataTask *)filePost:(NSString *)url
                            params:(NSDictionary *)params
                          fileName:(NSString *)fileName
                         fileDatas:(NSArray *)fileDatas
                       fileDataKey:(NSString *)fileDataKey
                          progress:(void(^)(NSProgress *uploadProgress))progress
                           success:(void(^)(NSURLSessionDataTask *operation, id responseObject))success
                           failure:(void(^)(NSURLSessionDataTask *operation, NSError *error))failure;


@end

//
//  XLLBaseNetWorkEngine.m
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLBaseNetWorkEngine.h"
#import "XLLNetWorkParam.h"
#import "XLLHttpManager.h"

@implementation XLLBaseNetWorkEngine

// POST请求
+ (void)POSTWithPath:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 处理基本参数
    NSMutableDictionary* nParemeters = [XLLNetWorkParam transitParams:params temURL:url];
    // 打印日志
    [self printLogWithParam:nParemeters tmpUrl:url];
    [[XLLHttpManager sharedHttpManager] POST:url params:params progress:^(NSProgress *uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self requestWithURL:url operation:operation dataObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [self backError:false error:error];
    }];
}

// GET请求
+ (void)GETWithPath:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 处理基本参数
    NSMutableDictionary* nParemeters = [XLLNetWorkParam transitParams:params temURL:url];
    // 打印日志
    [self printLogWithParam:nParemeters tmpUrl:url];
    [[XLLHttpManager sharedHttpManager] GET:url params:nParemeters progress:^(NSProgress *uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self requestWithURL:url operation:operation dataObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
       
        [self backError:failure error:error];
    }];
}

// PUT请求
+ (void)PUTWithPath:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 处理基本参数
    NSMutableDictionary* nParemeters = [XLLNetWorkParam transitParams:params temURL:url];
    // 打印日志
    [self printLogWithParam:nParemeters tmpUrl:url];
    [[XLLHttpManager sharedHttpManager] PUT:url params:nParemeters success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self requestWithURL:url operation:operation dataObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
       
        [self backError:failure error:error];
    }];
}

// DELETE请求
+ (void)DELETEWithPath:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 处理基本参数
    NSMutableDictionary* nParemeters = [XLLNetWorkParam transitParams:params temURL:url];
    // 打印日志
    [self printLogWithParam:nParemeters tmpUrl:url];
    [[XLLHttpManager sharedHttpManager] DELETE:url params:nParemeters success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        [self requestWithURL:url operation:operation dataObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [self backError:failure error:error];
    }];
}

// 特殊的POST请求
+ (NSURLSessionDataTask *)filePOSTWithPath:(NSString *)url params:(NSDictionary *)params fileName:(NSString *)fileName fileDatas:(NSArray *)fileDatas fileDataKey:(NSString *)fileDataKey progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSURLSessionDataTask *dataTask = [[XLLHttpManager sharedHttpManager] filePost:url params:params fileName:fileName fileDatas:fileDatas fileDataKey:fileDataKey progress:^(NSProgress *uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
       
        [self requestWithURL:url operation:operation dataObject:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
        [self backError:failure error:error];
    }];
    return dataTask;
}

#pragma mark - 统一处理错误信息
+ (void)backError:(void(^)(NSError *error))failure error:(NSError *)error
{
    NSDictionary *userInfo = error.userInfo;
    NSData* errorData = userInfo[@"com.alamofire.serialization.response.error.data"];
    if (errorData) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableContainers error:nil];
#if DEBUG
        NSLog(@"错误信息 *****\n %@ \n******", dict);
#endif
        if (dict && [dict isKindOfClass:[NSDictionary class]])
        {
            dict = dict[@"error"];
            id code = dict[@"code"];
            NSInteger codeInteger = 1001;
            if ([code isKindOfClass:[NSString class]]) {
                NSString *codeStr = (NSString *)code;
                codeInteger = codeStr.integerValue;
            } else {
                NSNumber *codeNum = (NSNumber *)code;
                codeInteger = codeNum.integerValue;
            }
            NSString *errorKey = dict[@"message"]?dict[@"message"]:@"";
            NSString *domainName = dict[@"name"]?dict[@"name"]:@"com.XLL";
            NSError *error = [NSError errorWithDomain:domainName code:codeInteger userInfo:@{NSLocalizedDescriptionKey:errorKey}];
            failure(error);
        } else {
            
            failure(error);
        }
    } else {
        
        if (error) {
            failure(error);
        } else {
            NSError *error = [NSError errorWithDomain:@"com.XLL" code:1001 userInfo:@{NSLocalizedDescriptionKey:@"网络数据结构错误"}];
            failure(error);
        }
    }
}

// 统一处理成功回调数据
+ (void)requestWithURL:(NSString *)url
             operation:(NSURLSessionDataTask *)operation
                  dataObject:(id)responseObject
               success:(void(^)(id dataObject))success
               failure:(void(^)(NSError *error))failure
{
    // 打印日志
#if DEBUG
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"\n\n urlString : %@ \n%@\n\n", url,string);
#endif
    NSDictionary *dict;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        dict = responseObject;
    } else {
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    }
    if (!dict) {
        NSHTTPURLResponse *operationResponse = (NSHTTPURLResponse *)operation.response;
        if (operationResponse.statusCode == 200) {
            if (success) {
                success(@(YES));
            }
        } else {
            if (failure) {
                
                NSError *error = [NSError errorWithDomain:@"com.XLL" code:1001 userInfo:@{NSLocalizedDescriptionKey:@"网络数据结构错误"}];
                failure(error);
            }
        }
        return;
    }
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSDictionary *errorDict = dict[@"error"];
        if (errorDict == nil) {
            if (success) {
                success(dict);
            }
        } else {
            if (failure) {
                NSError *error = [NSError errorWithDomain:errorDict[@"name"] code:[errorDict[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:errorDict[@"message"]}];
                failure(error);
            }
        }
    } else {
        if (success) {
            success(dict);
        }
    }
}

// 打印日志
+ (void)printLogWithParam:(NSMutableDictionary *)nParemeters tmpUrl:(NSString *)url
{
#if DEBUG
    // 便于调试查看请求信息
    NSMutableString *reqStr = [NSMutableString string];
    [nParemeters enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
        [reqStr appendString:[NSString stringWithFormat:@"%@=%@&", key, obj]];
    }];
    NSLog(@"*************\nURL = %@\n***************", reqStr);
    NSLog(@"\n\n 最终的请求参数列表 : %@ \n", nParemeters);
#endif
}

@end

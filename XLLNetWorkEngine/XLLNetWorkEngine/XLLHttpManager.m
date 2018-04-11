//
//  XLLHttpManager.m
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "XLLHttpManager.h"
#import <AFNetworking/AFNetworking.h>

#if DEVELOPMENT

NSString *const netWorkServiceAddress = @"http://c.3g.163.com";

#else

NSString *const netWorkServiceAddress = @"http://c.3g.163.com";

#endif

@interface XLLHttpManager ()

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation XLLHttpManager
static XLLHttpManager *instance_ = nil;

+ (instancetype)sharedHttpManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[[self class] alloc] init];
    });
    return instance_;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.httpManager = [AFHTTPSessionManager manager];
        // 设置请求相关
        [self setupRequestSerializer];
        // 设置响应相关
        [self setupResponseSerializer];
        // 设置安全策略
        self.httpManager.securityPolicy = [self customSecurityPolicy];
    }
    return self;
}

- (void)setupRequestSerializer
{
    // 公共请求头
    AFHTTPRequestSerializer *requestSerializer = self.httpManager.requestSerializer;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [requestSerializer setValue:version forHTTPHeaderField:@"APP_VERSION"];
    // 设置超时时间
    requestSerializer.timeoutInterval = 180;
}

- (void)setupResponseSerializer
{
    // 响应数据类型
    self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/x-www-form-urlencoded", @"multipart/form-data", @"text/plain", @"image/jpeg", @"image/png", @"application/octet-stream",  nil];
}

- (AFSecurityPolicy *)customSecurityPolicy
{
    // 单向验证，项目中不用添加cer证书
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setValidatesDomainName:NO];
    [securityPolicy setAllowInvalidCertificates:YES];
    return securityPolicy;
     /**
    // 双向验证，需要添加cer证书，AFN内部进行了读取，这里就不需要再做一遍了
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    [securityPolicy setAllowInvalidCertificates:YES];
    return securityPolicy;
     */
}

// POST请求
- (void)POST:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *realUrl = [self domainTransfer:url];
    [self.httpManager POST:realUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            failure(task, error);
        }
    }];
}

// GET请求
- (void)GET:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *realUrl = [self domainTransfer:url];
    [self.httpManager GET:realUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            failure(task, error);
        }
    }];
}

// PUT请求，参数可在请求路径中，也可在params中
- (void)PUT:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *realUrl = [self domainTransfer:url];
    [self.httpManager PUT:realUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
    }];
}

// DELETE请求，一般参数都在请求路径中拼接
- (void)DELETE:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *realUrl = [self domainTransfer:url];
    [self.httpManager DELETE:realUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
    }];
}

// 文件上传POST
- (NSURLSessionDataTask *)filePost:(NSString *)url params:(NSDictionary *)params fileName:(NSString *)fileName fileDatas:(NSArray *)fileDatas fileDataKey:(NSString *)fileDataKey progress:(void (^)(NSProgress *))progress success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *realUrl = [self domainTransfer:url];
    NSURLSessionDataTask *dataTask = [self.httpManager POST:realUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSData *fileData in fileDatas) {
            
            NSString *mimeType = XLLMimeTypeWithExtension([fileName pathExtension]);
            [formData appendPartWithFileData:fileDatas name:fileDataKey fileName:fileName mimeType:mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
    }];
    return dataTask;
}

// 抄写AFN内部实现获取mimeType的方法
static inline NSString * XLLMimeTypeWithExtension(NSString *extension) {
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (mimeType.length == 0)
    {
        return @"application/octet-stream";
    } else {
        return mimeType;
    }
}

// 请求路径拼接域名
- (NSString*)domainTransfer:(NSString*)url
{
    NSString *urlSTRE = [NSString stringWithFormat:@"%@/%@", netWorkServiceAddress, url];
    return urlSTRE;
}

@end

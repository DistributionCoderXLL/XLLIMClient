//
//  NSString+OKASecure.m
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import "NSString+OKASecure.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (OKASecure)

#pragma mark - HMAC 字符串加密

- (NSString *)oka_hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)oka_hmacSHA1StringWithKey:(NSString *)key
{
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)oka_hmacSHA256StringWithKey:(NSString *)key
{
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)oka_hmacSHA512StringWithKey:(NSString *)key
{
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}


#pragma mark - 文件加密

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)fileMD5Hash
{
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fileSHA1Hash
{
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fileSHA256Hash
{
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fileSHA512Hash
{
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark -
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length
{
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}


- (NSString*)base64Encoded {
    // Create NSData object
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}

- (NSString*)base64Decode {
    // 解码之后的二进制字符串
    NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
}
@end

@implementation NSString(OKATripleDES)

// 3DES（又叫Triple DES）是三重数据加密算法（TDEA，Triple Data Encryption Algorithm）块密码的通称。

#define gIv  @"01234567"
#define kSecrectKeyLength 24

+ (NSString *)oka_3DesEncrypt:(NSString *)plainText withKey:(NSString *)key {
    if (!plainText) {
        return nil;
    }
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(keyData.bytes, (int)keyData.length, digest);
    
    uint8_t keyByte[kSecrectKeyLength];
    for (int i = 0; i < 16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i = 0; i < 8; i++) {
        keyByte[16+i] = digest[i];
    }
    
    NSData *data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = data.length;
    const void *vplainText = (const void *)data.bytes;
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)keyByte;
    const void *vinitVec = (const void *)(gIv).UTF8String;
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr
                                    length:(NSUInteger)movedBytes];
    NSString *result = [myData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return result;
}

+ (NSString *)oka_3DesDecrypt:(NSString *)encryptText withKey:(NSString *)key {
    if (!encryptText) {
        return nil;
    }
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    uint8_t keyByte[kSecrectKeyLength];
    for (int i = 0; i < 16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i = 0; i < 8; i++) {
        keyByte[16+i] = digest[i];
    }
    
    NSData *encryptData = [[NSData alloc] initWithBase64EncodedString:encryptText
                                                              options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    size_t plainTextBufferSize = encryptData.length;
    const void *vplainText = encryptData.bytes;
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)keyByte;
    //    DLog(@"kkk %s",vkey);
    const void *vinitVec = (const void *)(gIv).UTF8String;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc]
                        initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                    length:(NSUInteger)movedBytes]
                        encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}

/**
 * 3DES 加密
 * 对key做了sha1加密处理.
 */
- (NSString*)oka_stringEncryptIn3DesWithKey:(NSString*)key {
    if (!key) {
        return nil;
    }
    
    // 先对key做sha1处理
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(keyData.bytes, (int)keyData.length, digest);
    
    uint8_t keyByte[kSecrectKeyLength];
    for (int i = 0; i < 16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i = 0; i < 8; i++) {
        keyByte[16+i] = digest[i];
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = data.length;
    const void *vplainText = (const void *)data.bytes;
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)keyByte;
#ifdef DEBUG
    NSLog(@"kkk %s", vkey);
#endif
    const void *vinitVec = (const void *)(gIv).UTF8String;
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr
                                    length:(NSUInteger)movedBytes];
    NSString *result = [myData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return result;
}

/**
 * 3DES 解密
 * 对key做了sha1加密处理.
 */
- (NSString*)oka_stringDecryptIn3DesWithKey:(NSString*)key {
    if (!key) {
        return nil;
    }
    
    // 先对key做sha1处理
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    uint8_t keyByte[kSecrectKeyLength];
    for (int i = 0; i < 16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i = 0; i < 8; i++) {
        keyByte[16+i] = digest[i];
    }
    
    NSData *encryptData = [[NSData alloc] initWithBase64EncodedString:self
                                                              options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    size_t plainTextBufferSize = encryptData.length;
    const void *vplainText = encryptData.bytes;
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)keyByte;
    //    DLog(@"kkk %s",vkey);
    const void *vinitVec = (const void *)(gIv).UTF8String;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc]
                        initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                    length:(NSUInteger)movedBytes]
                        encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}

- (NSString *)hmacsha1
{
    NSString *secret = @"456";
    const char *cKey = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    // Base64
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    {
        //        NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        //        hash = [self base64Encoded:hash];
        //
        //        return hash;
        
    }
    NSString *HMACStr = [[HMAC description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    HMACStr = [HMACStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    HMACStr = [HMACStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return HMACStr;
}

@end

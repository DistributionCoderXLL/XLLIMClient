//
//  NSString+OKASecure.h
//  XLLNetWorkEngine
//
//  Created by 肖乐 on 2018/4/11.
//  Copyright © 2018年 iOSCoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (OKASecure)

#pragma mark - HMAC 散列函数

/**     ------------------------------------------------------------------------
 ------------------------------------------------------------------------
 *  散列函数--HMAC md5加密
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (NSString *)oka_hmacMD5StringWithKey:(NSString *)key;

/**     ------------------------------------------------------------------------
 ------------------------------------------------------------------------
 *  散列函数--HMAC sha1加密
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (NSString *)oka_hmacSHA1StringWithKey:(NSString *)key;

/**     ------------------------------------------------------------------------
 *  散列函数--HMAC sha256加密
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)oka_hmacSHA256StringWithKey:(NSString *)key;

/**     ------------------------------------------------------------------------
 *  散列函数--HMAC sha512加密
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (NSString *)oka_hmacSHA512StringWithKey:(NSString *)key;



#pragma mark - 文件加密

/**     ------------------------------------------------------------------------
 *  散列函数--md5对文件加密
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)fileMD5Hash;

/**     ------------------------------------------------------------------------
 *  散列函数--sha1对文件加密
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)fileSHA1Hash;

/**     ------------------------------------------------------------------------
 *  散列函数--sha256对文件加密
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)fileSHA256Hash;

/**     ------------------------------------------------------------------------
 *  散列函数--sha512对文件加密
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)fileSHA512Hash;


/**     ------------------------------------------------------------------------ base64编码 */
- (NSString*)base64Encoded;

/**     ------------------------------------------------------------------------ base64编码之后的字符串进行base64解码*/
- (NSString*)base64Decode;

@end

@interface NSString (OKATripleDES)
/**     ------------------------------------------------------------------------
 * 3DES 加密
 * 对key做了sha1加密处理.
 */
+ (NSString *)oka_3DesEncrypt:(NSString *)plainText withKey:(NSString *)key;

/**     ------------------------------------------------------------------------
 * 3DES 解密
 * 对key做了sha1加密处理.
 */
+ (NSString *)oka_3DesDecrypt:(NSString *)encryptText withKey:(NSString *)key;

/**     ------------------------------------------------------------------------
 * 3DES 加密
 * 对key做了sha1加密处理.
 */
- (NSString*)oka_stringEncryptIn3DesWithKey:(NSString*)key;

/**     ------------------------------------------------------------------------
 * 3DES 解密
 * 对key做了sha1加密处理.
 */
- (NSString*)oka_stringDecryptIn3DesWithKey:(NSString*)key;

/**
 HMAC-SHA1
 */
- (NSString*)hmacsha1;

@end

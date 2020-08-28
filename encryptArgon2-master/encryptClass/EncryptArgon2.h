//
//  EncryptArgon2.h
//  encryptDemo
//
//  Created by kevin guo on 2020/8/27.
//  Copyright © 2020 kevin guo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncryptArgon2 : NSObject
/**< 加密方法 */
+(NSData *)argon2iEncode:(int)t_cost mCost:(int )m_cost parallelism:(int)parallelism pwdData:(NSData *)pwdData abufLenth:(int)lenth;

@end

NS_ASSUME_NONNULL_END

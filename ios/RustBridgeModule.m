//
//  RustBridgeModule.m
//  rustyphoneapp
//
//  Created by jack on 4/5/24

#import <Foundation/Foundation.h>

#import <React/RCTBridgeModule.h>
#include "rustyphoneapp.h"
#import <React/RCTLog.h>

//func asPtr() -> StringPtr {
//    let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
//   return StringPtr(ptr: (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), len: data.count)
//  }
//}

struct StringPtr asPtr(NSString *name) {
  NSData *data = [name dataUsingEncoding:NSUTF8StringEncoding];
  struct StringPtr result;
  result.ptr = data.bytes;
  result.len = data.length;
  return result;
}

@interface RustBridgeModule : NSObject <RCTBridgeModule>
@end
@implementation RustBridgeModule

RCT_EXPORT_METHOD(invoke:(NSString *)name
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)
{
  struct StringPtr strptr = asPtr(name);
  struct StringPtr *result = rust_string_ptr(rustInvoke(&strptr));
  NSData *data = [NSData dataWithBytes:result->ptr length:result->len];
  NSString* resultstr = [NSString stringWithUTF8String:[data bytes]];
  resolve(resultstr);
}

RCT_EXPORT_METHOD(logevent:(NSString *)name
                  location:(NSString *)location
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
  resolve(@"HELLO WORLD");
}

RCT_EXPORT_MODULE(RustBridge);

@end

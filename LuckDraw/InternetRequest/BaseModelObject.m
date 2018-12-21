//
//  BaseModelObject.m
//  iOSInstaReport
//
//  Created by TCH on 15/10/29.
//  Copyright © 2015年 TCH. All rights reserved.
//

#import "BaseModelObject.h"
#include <objc/runtime.h>

@implementation BaseModelObject

//- (instancetype)initWithDictionary: (NSDictionary *) data{
//    self = [super init];
//    if (self) {
//        [self assginToPropertyWithDictionary:data];
//    }
//    return self;
//}
//
//+ (instancetype)modelWithDictionary: (NSDictionary *) data{
//    
//    return [[self alloc] initWithDictionary:data];
//}

#pragma mark - 通过字符串来创建该字符串的Setter方法，并返回

- (SEL)creatSetterWithPropertyName:(NSString *)propertyName{
//    //1.首字母大写
//    propertyName = propertyName.capitalizedString;
//    //2.拼接上set关键字
//    propertyName = [NSString stringWithFormat:@"set%@:",propertyName];
    NSString *firstCharater = [propertyName substringToIndex:1].uppercaseString;
    // 2.替换掉属性名的第一个字符为大写字符，并拼接出set方法的方法名
    NSString *setPropertyName = [NSString stringWithFormat:@"set%@%@:",firstCharater,[propertyName substringFromIndex:1]];
    //3.返回set方法
    return NSSelectorFromString(setPropertyName);
}

/************************************************************************
 *把字典赋值给当前实体类的属性
 *参数：字典
 *适用情况：当网络请求的数据的key与实体类的属性相同时可以通过此方法吧字典的Value
 *        赋值给实体类的属性
 ************************************************************************/

-(void) assginToPropertyWithDictionary: (NSDictionary *) data{
    
    if (data == nil) {
        return;
    }
    
    ///1.获取字典的key
    NSArray *dicKey = [data allKeys];
    
    ///2.循环遍历字典key, 并且动态生成实体类的setter方法，把字典的Value通过setter方法
    ///赋值给实体类的属性
    for (int i = 0; i < dicKey.count; i ++) {
        
        ///2.1 通过getSetterSelWithAttibuteName 方法来获取实体类的set方法
        SEL setSel = [self creatSetterWithPropertyName:dicKey[i]];
        
        if ([self respondsToSelector:setSel]) {
            ///2.2 获取字典中key对应的value
            id value = data[dicKey[i]];
            
            ///2.3 把值通过setter方法赋值给实体类的属性
            [self performSelectorOnMainThread:setSel
                                   withObject:value
                                waitUntilDone:[NSThread isMainThread]];
        }
        
    }
}

//// 返回self的所有对象名称
//+ (NSArray *)propertyOfSelf{
//    unsigned int count;
//    
//    // 1. 获得类中的所有成员变量
//    Ivar *ivarList = class_copyIvarList(self, &count);
//    
//    NSMutableArray *properNames =[NSMutableArray array];
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = ivarList[i];
//        
//        // 2.获得成员属性名
//        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        
//        // 3.除去下划线，从第一个角标开始截取
//        NSString *key = [name substringFromIndex:1];
//        
//        [properNames addObject:key];
//    }
//    
//    return [properNames copy];
//}
//
//// 归档
//- (void)encodeWithCoder:(NSCoder *)enCoder{
//    // 取得所有成员变量名
//    NSArray *properNames = [[self class] propertyOfSelf];
//    
//    for (NSString *propertyName in properNames) {
//        // 创建指向get方法
//        SEL getSel = NSSelectorFromString(propertyName);
//        // 对每一个属性实现归档
//        [enCoder encodeObject:[self performSelector:getSel] forKey:propertyName];
//    }
//}
//
//// 解档
//- (id)initWithCoder:(NSCoder *)aDecoder{
//    // 取得所有成员变量名
//    NSArray *properNames = [[self class] propertyOfSelf];
//    
//    for (NSString *propertyName in properNames) {
//        // 创建指向属性的set方法
//        SEL setSel = [self creatSetterWithPropertyName:propertyName];
//        [self performSelector:setSel withObject:[aDecoder decodeObjectForKey:propertyName]];
//    }
//    return  self;
//}

@end

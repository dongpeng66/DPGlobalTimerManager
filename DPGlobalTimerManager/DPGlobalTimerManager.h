//
//  DPGlobalTimerManager.h
//  DPGlobalTimerManager
//
//  Created by 人众 on 2018/6/15.
//

#import <Foundation/Foundation.h>

@interface DPGlobalTimerManager : NSObject
+(instancetype)standardManger;
/**添加倒计时的事件*/
-(void)addTarget:(id)target withBlock:(void (^)(void))block;
/**移除倒计时的事件*/
-(void)removeTarget:(id)target;
@end

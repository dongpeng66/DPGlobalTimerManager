//
//  DPGlobalTimerManager.m
//  DPGlobalTimerManager
//
//  Created by 人众 on 2018/6/15.
//

#import "DPGlobalTimerManager.h"
@interface DPGlobalTimerManager ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMapTable *targets;
@property (nonatomic,strong) NSMapTable *willAddTargets;
@property (nonatomic,strong) NSHashTable *willRemoveTargets;
@end
@implementation DPGlobalTimerManager
+(instancetype)standardManger{
    static DPGlobalTimerManager *manger=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger=[[DPGlobalTimerManager alloc]init];
    });
    return manger;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        self.targets=[[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsCopyIn capacity:0];
        self.willAddTargets=[[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsCopyIn capacity:0];
        self.willRemoveTargets=[[NSHashTable alloc]initWithOptions:NSPointerFunctionsWeakMemory capacity:0];
        self.timer=[[NSTimer alloc]initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(timerClock) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
-(void)timerClock{
    for (id target in [self.willAddTargets keyEnumerator]) {
        [self.targets setObject:[self.willAddTargets objectForKey:target] forKey:target];
        
    }
    [self.willAddTargets removeAllObjects];
    for (id target in [self.targets keyEnumerator]) {
        if (target) {
            void (^block)(void)=[self.targets objectForKey:target];
            block();
        }
        
    }
    for (id target in self.willRemoveTargets) {
        [self.targets removeObjectForKey:target];
        
    }
    [self.willRemoveTargets removeAllObjects];
}
/**添加倒计时的事件*/
-(void)addTarget:(id)target withBlock:(void (^)(void))block{
    [self.willAddTargets setObject:block forKey:target];
}
/**移除倒计时的事件*/
-(void)removeTarget:(id)target{
    [self.willRemoveTargets addObject:target];
}
@end

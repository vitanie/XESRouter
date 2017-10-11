### 一、安装

##### 1.1、Installation with CocoaPods
    1、在 `Podfile` 中添加 `pod 'XESRouterPublic'`。
    2、执行 `pod install` 或 `pod update`。    
    3、导入 `"XESRouterHader.h"`。

##### 1.2、手动安装（不推荐）
    1、下载XESRouter文件夹内的所有内容。
    2、将XESRouter内的源文件添加（拖放）到你的工程。
    3、导入XESRouterHader.h。 

---


### 二、XESRouter介绍
##### 2.1、简介
XESRouter是学而思基础架构组为组件化开发提供的路由模块,提供了通过Url跳转到具体页面的接口。


### 三、XESRouter 提供了哪些服务

##### 3.1、提供 RouterModel 模型,根据数据模型来映射出相对的模块

&emsp;&emsp; 3.1.1 模型相关属性
    
 ```
/**
 路径描述
 */
@property (nonatomic, strong) NSString * describe;

/**
 类的数据源，xib、storyboard、code
 */
@property (nonatomic, strong) NSString * source;
/**
 URL
 */
@property (nonatomic, strong) NSString * url;

/**
 类名
 */
@property (nonatomic, strong) NSString *className;

/**
 storyboard名称
 */
@property (nonatomic, strong) NSString *storyboardName;                                            
 ```
    
&emsp;&emsp; 3.1.2 示例代码


```
XESRouterModel *model = [[XESRouterModel alloc]init];
model.url = dic[@"url"];
model.describe = dic[@"describe"];
model.className = dic[@"className"];
model.source = dic[@"source"];
model.storyboardName = dic[@"storyboardName"];
```    
##### 3.2 、根据URL来手动生成RouterModel

&emsp;&emsp; 3.2.1 提供的接口

```
 + (XESRouterModel *)urlRouterKey:(NSString *)url;
```

&emsp;&emsp; 3.2.2 示例代码

```
- (XESRouterModel *)pathRouterModel:(NSString *)key{
    NSDictionary *pathDictionary = [self settingPath];
    NSDictionary *dic = pathDictionary[key];
    if (dic) {
        XESRouterModel *model = [[XESRouterModel alloc]init];
        model.describe = dic[@"describe"];
        model.source = dic[@"describe"];;
        model.url = dic[@"url"];;
        model.className = dic[@"className"];;
        model.storyboardName = dic[@"storyboardName"];;
        return model;
    }
    return nil;
    
}

```
##### 3.3 、提供视图与视图切换之间的冷却时间
&emsp;&emsp;默认为0.5秒

&emsp;&emsp; 3.3.1 提供的接口

```
+ (void)filterRouterTime:(float)time;   
                                           
```

&emsp;&emsp; 3.3.2 示例代码

```
[XESRouter filterRouterTime:0.2];
```

##### 3.4、提供Router，注册、取消注册、跳转、跳转回调、判断push类型

&emsp;&emsp; 3.4.1 注册接口，无对象回调

```
    + (void)registerURLModel:(XESRouterModel *)model 
               toHandler:(XESRouterHandler)handler
```

&emsp;&emsp; 3.4.2 示例代码

```
[XESRouter registerURLModel:model
                          toHandler:^(NSDictionary *routerParameters) {
                              
                     }];    
```
##### 3.5、注册接口，有对象回调
&emsp;&emsp; 3.5.1 提供的接口

```
+ (void)registerURLModel:(XESRouterModel *)model 
         toObjectHandler:(XESRouterObjectHandler)handler;
```

&emsp;&emsp; 3.5.2 示例代码

```
[XESRouter registerURLModel:model
                          toObjectHandler:^(NSDictionary *routerParameters) {
                              
                     }]; 
```
##### 3.6、取消注册某个 URL

&emsp;&emsp; 3.6.1 提供的接口

```
+ (void)deregisterURLPattern:(NSString *)URLPattern;
```

&emsp;&emsp; 3.6.2 示例代码

```
[XESRouter deregisterURLPattern:@"url"];
```

##### 3.7、三种打开 URL 方式 ，isPresented 判断退出视图类型，，userInfo字典参数 completion参数回调

&emsp;&emsp; 3.7.1 提供的接口

```
+ (void)openURL:(NSString *)URL 
     isPresented:(NSNumber *)ispresented

+ (void)openURL:(NSString *)URL 
     isPresented:(NSNumber *)ispresented 
      completion:(XESRouterCompletion )completion;

+ (void)openURL:(NSString *)URL
     isPresented:(NSNumber *)ispresented
    withUserInfo:(NSDictionary *)userInfo
      completion:(XESRouterCompletion)completion
```

&emsp;&emsp; 3.7.2 示例代码

```
 [XESRouter openURL:url
           isPresented:ispresented
          withUserInfo:userInfo
            completion:completion];
```

##### 3.8、查找谁对某个 URL 和 （3.5、注册接口，有对象回调）想对应
&emsp;&emsp; 3.8.1 提供的接口

```
+ (id)objectForURL:(NSString *)URL
```

&emsp;&emsp; 3.8.2 示例代码

```
  [XESRouter objectForURL：@"url"];                                                                    
```
##### 3.9、是否可以打开URL

&emsp;&emsp; 3.9.1 提供的接口

```
+ (BOOL)canOpenURL:(NSString *)URL;
```

&emsp;&emsp; 3.9.2 示例代码

```
id data = [XESRouter canOpenURL：@"url"];                                                                    
```

### 四、XESRouter API分为以下几个分类

* `XESRouter`
* `XESRouterModel`
* `UIViewController+URLRouter`

##### 4.1、XESRouter

 &emsp;&emsp;4.1.1、介绍
 &emsp;&emsp;&emsp;&emsp;  `XESRouter`类是一个单例，基本请求的操作代理，相当于command设计模式中的接收器，所有的网络请求都是从这个类开始的。
  
&emsp;&emsp;4.1.2、接口
&emsp;&emsp;&emsp;&emsp;此类为单例，不允许使用init、new方法创建实例对象

```
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 设置界面与界面之间跳转的间隔时间
 
 @param time 默认0.5毫秒
 */
+ (void)filterRouterTime:(float)time;

/**
 *  注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  @param model      带上 scheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 */
+ (void)registerURLModel:(XESRouterModel *)model toHandler:(XESRouterHandler)handler;

/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param model cheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLModel:(XESRouterModel *)model toObjectHandler:(XESRouterHandler)handler;

/**
 *  取消注册某个 URL Pattern
 *
 *  @param URLPattern KEY
 */
+ (void)deregisterURLPattern:(NSString *)URLPattern;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带 Scheme，如 mgj://beauty/3
 *  @param ispresented 是否需要模态弹出界面  默认为NO
 */
+ (BOOL)openURL:(NSString *)URL isPresented:(NSNumber *)ispresented;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 *  @param ispresented 是否需要模态弹出界面  默认为NO
 */
+ (BOOL)openURL:(NSString *)URL isPresented:(NSNumber *)ispresented completion:(XESRouterCompletion )completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param userInfo 附加参数
 *  @param ispresented 是否需要模态弹出界面  默认为NO
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (BOOL)openURL:(NSString *)URL isPresented:(NSNumber *)ispresented  withUserInfo:(NSDictionary *)userInfo completion:(XESRouterCompletion)completion;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL KEY
 */
+ (id)objectForURL:(NSString *)URL;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL  KEY
 *  @param userInfo 参数
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  是否可以打开URL
 *
 *  @param URL KEY
 *
 *  @return 是否可以打开
 */
+ (BOOL)canOpenURL:(NSString *)URL;

```


---

##### 4.2、XESRouterModel

 &emsp;&emsp; 4.2.1、介绍
   &emsp;&emsp; &emsp;&emsp; `XESRouterModel`注册模型和router.Plist文件对应。

 &emsp;&emsp;4.2.2、属性
 
```
/**
 路径描述
 */
@property (nonatomic, strong) NSString * describe;

/**
 类的数据源，xib、storyboard、code
 */
@property (nonatomic, strong) NSString * source;
/**
 URL
 */
@property (nonatomic, strong) NSString * url;

/**
 类名
 */
@property (nonatomic, strong) NSString *className;

/**
 storyboard名称
 */
@property (nonatomic, strong) NSString *storyboardName;
/**
 存放额外数据
 */
@property (nonatomic, strong) id other;

/**
 回调一个带URL模型
 
 @param url 需要注册的URL
 @return 模型
 */
+ (XESRouterModel *)urlRouterKey:(NSString *)url;
```

---

##### 4.3、UIViewController+URLRouter

 &emsp;&emsp;4.3.1、介绍
   &emsp;&emsp; &emsp;&emsp; `UIViewController+URLRouter`扩展方法主要是获取UIViewController 和 UINavigationController。
   
 &emsp;&emsp;4.3.2、接口

 &emsp;&emsp; &emsp;&emsp;获取UIViewController 和 UINavigationController类方法.

```
+ (UIViewController *)currentViewController;

+ (UINavigationController *)currentNavigationViewController;
                           
```
---

### 历史版本
* 0.0.1
  * 初始化提交
  * 制作pod源

---
### 系统要求
该项目最低支持 iOS 7.0 和 Xcode 7.0。



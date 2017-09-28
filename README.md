# ZGNavigationBarItemFixSpace
适配系统导航栏UINavigationBar上UIBarButtonItem布局间距，0代码，只需将次文件拖入项目中

<a href = "https://ioslittlewhite.github.io/2017/09/21/iOS11适配之：0代码实现导航栏UIBarButtonItem间距调整/" target="_blank"> 点击查看讲解文档

##### 版本1.2（2017-09-28） <br>
- 替换UIBarButtonItem原生实例化方法initWithBarButtonSystemItem:target:action:
- 替换UIBarButtonItem原生的setTarget: 和 setAction: 方法；
- 解决popBack后，约束失效的问题，添加约束的位置发生变化，新增UIStackView的类扩展，在其layoutSoubviews方法中实现约束条件的设置；
 

##### 版本1.1（2017-09-26）
- 增加UIBarButtonItem被添加到UIToolbar上的处理；
- 增加对UIBarButtonItem的UIBarButtonItemStyleDone类型的解析；
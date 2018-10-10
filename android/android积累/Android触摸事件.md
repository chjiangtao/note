### Android触摸事件
- 触摸事件传递过程涉及的三个方法dispatchTouchEvent()、onInterceptTouchEvent()和onTouchEvent().
## 基础
- Android中的Touch事件都是从ACTION_DOWN开始的:
  
  单指:ACTION_DOWN--->ACTION_MOVE--->ACTION_UP;
  
  多指:ACTION_DOWN--->ACTION_POINTER_DOWN--->ACTION_MOVE--->ACTION_POINTER_UP--->ACTION_UP

- 一次完整的触摸事件中，Down和Up都只有一个,Move有若干个，也可以没有。当触摸事件被拦截时，Up可能为0;
- View在ViewGroup内,ViewGroup也可以在其他VIewGroup内,这时候把内部的ViewGroup当成View来分析。
## Activity、ViewGroup、View里的回调方法
  ```java
   //Activity里的回调方法
   public boolean dispatchTouchEvent(MotionEvent ev);
   public boolean onTouchEvent(MotionEvent ev);
   //ViewGroup里的回调方法
   public boolean dispatchTouchEvent(MotionEvent ev);
   public boolean onTouchEvent(MotionEvent ev);
   public boolean onInterceptTouchEvent(MotionEvent ev);
   //View里的回调方法
   public boolean dispatchTouchEvent(MotionEvent ev);
   public boolean onTouchEvent(MotionEvent ev);
  ```
## 三个方法的区别

|dispatchTouchEvent|onInterceptTouchEvent|onTouchEvent|
|:-:|:-:|:-:|
|分发TouchEvent|拦截TouchEvent|处理TouchEvent|

## onInterceptTouchEvent事件拦截
- onInterceptTouchEvent()的返回值表示是否拦截事件。如果为true,表示事件在当前的ViewGroup中会被处理,事件不会再向下传递,同时把事件传递给当前的控件的onTouchEvent()继续进行传递或处理。
- 如果返回值是false,则事件会接着往下传递。

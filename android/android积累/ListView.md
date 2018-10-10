### ListView的用法
## 继承关系
```java
  java.lang.Object
  --->android.view.View
    --->android.view.ViewGroup
      --->android.widget.AdapterView<android.widget.ListAdapter>
        --->android.widget.AbsListView
          --->android.widget.ListView
            --->(子类)ExpandableListView
```
## 常用API
```java 

/**
 * 返回(x,y)所在点在List中的位置
 * 如果点没在所有的Item上，则返回  
 * AdapterView.INVALID_POSITION--->-1
 * 该方法在AbsListView里
 */ 
public int pointToPosition(x,y);

/**
 * 返回屏幕上第一个可见的Item在List里的位置
 * 该方法在AdapterView里
 */
public int getFirstVisiblePosition()

/**
 * 返回当前View集合中index的View
 * 如果View集合里在这个位置没有View，则返回null
 * 该方法在ViewGroup里
 * 对于ListView 就是当前可见的ItemView
 */
public View getChildAt(int index)
```
- 确定点击或要滑动的Item方法
```java
//在自定义的ListView内部
int position=this.pointToPosition(x,y);//(x,y)通过dispatchTouchEvent获得
if(position!=INVALID_POSITION){
    int visibleIndex=position-getFirstVisiblePosition();
    itemView=getChildAt(visibleIndex);
}
```
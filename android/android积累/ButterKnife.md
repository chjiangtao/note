# ButterKnife用法
## 1. 使用的注意事项
1. 在Activity类中绑定，BK.bind(this)必须在setContentView之后绑定，且父类bind绑定后，子类不需要再绑定。
2. 在非活动类（Fragment、ViewHold等）中绑定，ButterKnife.bind(this,view),this不能替换为getActivity();
3. 在Activity中不需要解绑操作，在Fragment中必须在onDestroyView()中解除绑定。
4. 使用BK修饰的方法和控件，不能用私有或静态修饰，否则会报错。

## 2. ButterKnife注册和绑定
### 1. 在Activity中绑定ButterKnife
```
 public class Activity extends AppCompatActivity{
     protected void onCreate(Bundle save){
         super.onCreate(save);
         setContentView(R.layout.activity_main);
         //绑定初始化ButterKnife,必须在setContentView()之后
         ButterKnife.bind(this);
     }
 }
```

### 2. 在Fragment中绑定ButterKnife
```
public class ButterKnifeFragment extends Fragment{
    private Unbinder unbinder;

    public View onCreateView(LayoutInflater inflater,ViewGroup container,Bundle save){
        View view=inflater.inflate(R.layout.fragment,container,false);
        /*返回一个Unbinder值(进行解绑),注意这里的this不  *能使用getActivity()
         */
        unbinder=ButterKnife.bind(this,view);
        return view;
    }

    //在onDestroyView中进行解绑操作
    public void onDestroyView(){
        super.onDestroyView();
        unbinder.unbind();
    }
}
```

### 3. 在Adapter中绑定ButterKnife
```
public class MyAdapter extends BaseAdapter{

    public View getView(int position,View view,ViewGroup parent){
        ViewHolder holder;
        LayoutInflater inflater=LayoutInflater.from(mContext);
        if(view!=null){
            holder=(ViewHolder)view.getTag();
        }else{
            view=inflater.inflate(R.layout.testlayout,parent,false);
            holder=new ViewHolder(view);
            view.setTag(holder);
        }
        holder.name.setText("");
        return view;
    }
    static class ViewHolder{
        @BindView(R.id.title) TextView name;
        public ViewHolder(View view){
            ButterKnife.bind(this,view);
        }
    }
}
```
## 3. BK的基本使用
 ### 1. 绑定View
 - 控件id  @BindView()
 ```
   @BindView(R.id.button)
   public Button button;
 ```

 - 布局内多个控件 @BindViews()
 ```
    @BindViews({R.id.button,R.id.button2})
    public List<Button> buttonList;

    protected void onCreate(Bundle save){
        super.onCreate(save);
        setContentView(R.layout.main);

        ButterKnife.bind(this);

        buttonList.get(0).setText("");
        buttonList.get(2).setText("");
    }
 ```
### 2. 绑定资源

- 绑定String字符串 @BindString()

- 绑定String里面的array数组 @BindArray()

```
//资源文件
<resources>  
    <string name="app_name">城市</string>  

    <string-array name="city">  
        <item>北京市</item>  
        <item>天津市</item>  
        <item>哈尔滨市</item>  
        <item>大连市</item>  
        <item>香港市</item>  
    </string-array>  
</resources>  


@BindString(R.string.app_name) //绑定资源文件中的String字符串
String name;

@BindArray(R.array.city)
String[] citys;
```

- 绑定Bitmap资源 @BindBitmap()
```
@BindBitmap(R.mipmap.bm)
public Bitmap bitmap;
```

- 绑定一个颜色值 @BindColor()
```
@BindColor(R.color.color)
int black;//绑定一个颜色值

//在方法里
  button.setTextColor(black);
```

### 3. 事件绑定
- 绑定点击事件
   - 绑定控件点击事件 @OnClick()
   - 绑定控件长按事件 @OnLongClick()
```
@OnClick(R.id.button) //设置一个点击事件
public void showToast(){

}
```
- 多个id绑定事件
```
@OnClick({R.id.name,R.id.password,R.id.button})
public void onViewClicked(View view){
    switch(view.getId()){
        case R.id.name:
             break;
        case R.id.password:
             break;
        case R.id.button:
             break;
    }
}

//也可以分开写
@OnClick(R2.id.name)
public void onViewClick(View view){

}
.......
```
- 自定义View绑定事件(不用指定id)
```
@OnClick
public void onClick(){

}
```

###绑定监听
- Listener可以自动配置到方法中
```
@OnClick(R.id.sunmit)
public void sunmit(View view){

}
```
- 对监听器方法的所有参数都是可选的
```
@OnClick(R.id.sunmit)
public void submit(){

}
```

- 自定义一个特定类型，将自动被转换
```
@OnClick(R.id.submit)
public void sayHi(Button button){

}
```

- 在单个绑定中指定多个id，用于公共事件处理，
```
@OnClick(R.id.name,R.id.password)
public void sayHi(Button button){//多个控件对应公共事件

}
```

- Listener中多方法注解
```
Spinner s=new Spinner(this);
s.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener(){
    public void onItemSelected(AdapterView<?> parent,View view,int position,long id){
      
    }
    public void onNothingSelected(AdapterView<?> parent){

    }
});

//BK注解方式
@OnItemSelected(R.id.spinner) //默认callback为ITEM_SELECTED
void onItemSelected(int position){

}

//注解onNothingSelected,需要在注解参数添加一个callback
@OnItemSelected(value=R.id.spinner,callback=OnItemSelected.Callback.NOTHING_SELECTED)
void onNothingSelected(){

}


//例子2   <RadioGroup>
@OnCheckedChanged({R.id.name,R.id.password,R.id.title})
public void OnCheckedChangeListener(CompoundButton view,boolean isChanged){
    switch(view.getId()){
       case R.id.name:
            if(isChanged){//一定要有这个判断
            //相关逻辑
            }
            break;
       case R.id.password:
            break;
    }
}
```
- 使用findById
```
View view=LayoutInflater.from(mContext).inflate(R.layout.thing,null);
TextView name=ButterKnife=findById(view,R.id.name);
```

- 设置多个View的属性
   - apply() 允许立即对列表中所有视图进行操作
   - Action和Setter接口
```
@BindViews({R2.id.name,R2.id.password})
List<EditText> nameViews;

//设置多个View的属性
ButterKnife.apply(nameViews,DISABLE);//方式一 传递值
ButterKnife.apply(nameViews,ENABLED,false);//方式二 指定值
ButterKnife.apply(nameViews,View.ALPHA,0.0f);//

//Action接口设置属性
static final ButterKnife.Action<View> DISABLE=new ButterKnife.Action<View>(){
    @Override
    public void apply(View view,int index){

    }
};

//Setter接口设置
static final ButterKnife.Setter<View,Boolean> ENABLED=new ButterKnife.Setter<View,Boolean>(){
    public void set(View view,Boolean value,int index){

    }
}
```   
### 注意事项
- 8.0.0之前的Bind标签在之后变成BindView，而8.7.0之后在绑定view时，要用R2.id.XXX而不再是R.id.XXX;
- @bind和listener的绑定是必须的，如果找不到目标视图，将抛出一个异常。可以用@Nullable和@Optional来抑制并创建可选绑定。
>建议用Android的“support-annotations”库中的@Nullable注解。
### 更多绑定注解
- @BindView 绑定一个View，id为一个View变量
- @BindViews 绑定多个View，id为一个view的list变量
- @BindArray 绑定String里面array数组；@BindArray(R.array.XXX) String[] citys;
- @BindBitmap 绑定Bitmap @BindBitmap(R.mipmap.XXX) Bitmap bmp;
- @BindBool 绑定Boolean值
- @BindColor 绑定color @BindColor(R.color.XXX) int black;
- @BindDimen 绑定Dimen @BindDimen(R.dimen.width) int width;
- @BindDrawable 绑定Drawable @BindDrawable(R.drawable.pic) Drawable pic;
- @BindFloat 绑定float
- @BindInt 绑定int
- @BindString 绑定一个String id为一个String变量  @BindString(R.string.name) String meg;

### 更多事件注解
- @OnClick 点击事件
- @OnCheckedChanged 选中，取消选中
- @OnEditorAction 软键盘的功能键
- @OnFocusChange 焦点改变
- @OnItemClick 被点击 ***如果item里面有Button等这些有点击事件的控件，需要设置focusable为false***
- OnItemLongClick 长按事件***返回真可以拦截onItemClick***
- OnItemSelected item被选择事件
- OnLongClick 长按事件
- OnPageChange 页面改变事件
- OnTextChanged EditText里面的文本变化事件
- OnTouch 触摸事件
- @Optional 选择性注入  如果View存在，则注入，不存在，什么事情都不做。
### 代码混淆
```
//在混淆文件中添加
-keep class butterknife.** { *; }  
-dontwarn butterknife.internal.**  
-keep class **$$ViewBinder { *; }  

-keepclasseswithmembernames class * {  
    @butterknife.* <fields>;  
}  

-keepclasseswithmembernames class * {  
    @butterknife.* <methods>;  
}
```
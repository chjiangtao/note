1. java API  Math类
   (1)Math函数
      int round(float a)  四舍五入
      double sqrt(double a)  平方根
      double ceil(double a)  向上取整
      double floor(double a)  向下取整
      double pow(double a,double b)  a的b次方
      int abs(int a)  绝对值
      int max(int a,int b) 最大值
      double log(double a) 自然对数
      double random()   随机数 0<= <1

2. static 类方法或静态方法    

3. java API  Arrays类
   (1)Arrays函数
      void sort(int[] a) 按升序排列
      void sort(double[] a)
      int binarySearch(long[] a,long key) 二分查找，数组按升序排列
      void fill(int[] a,int val)  给所有元素赋相同的值
      int[] copyOf(int[] original,int newLength) 数组拷贝
      boolean equals(char[] a,char[] a2)  判断两个数组是否相同

4. final在修饰变量的时候表示常量，变量赋值后不能在修改。

5. 表示类变量时，static修饰符是必需的，但public和final都不是必需的。

6. 实例方法和类方法都可以有参数、操作、返回值。但类方法只能操作参数和方法内
  定义的变量，而实例方法可以直接操作实例变量，可以读也可以改。

7. 在实例方法中，有一个隐藏的参数，这个参数就是当前操作的实例自己。

8. Point p；声明类(p)本身只会分配存放位置的内存空间，这块空间还没有指向任何实际的内容。
  这种变量和数组本身不存数据，只是存储实际内容的位置，也称为引用类型的变量

9. 创建对象时，所有的实例变量都会有一个默认值。方法内部定义的不会。

10. this 表示当前实例

11. java  API     String  Date

12. 用类间的继承关系来表示类间的分类关系。

13. 使用继承一方面可以复用代码。公共的属性和行为可以放到父类，子类只需要关注子类
特有的就可以，另一方面，不同子类的对象可以更为方便的被统一处理。

14. 在new的过程中，父类的构方会先于子方执行。

15. 在调用父构方时，super()必须放在第一行，如果没有调用super(),则调用父类的默认构方。

16. super和this是不同的，this引用一个对象，是实实在在存在的，可以作为函数参数，
可以作为返回值，但super只是一个关键字，不能作为参数和返回值，只是用于高速编译器
访问父类的变量和方法。

17. 一个父类可以引用任何子类的对象(多态，一种类型的变量，可引用多种实际类型对象)，
这样对于父类来说就用两种类型，一种是其本身的类型(静态类型)，一种是其子类的类型(动态类型)。
调用动态类型的方法就叫做动态绑定。

18. 如果一个类只有一个带参数的构方，没有默认构方，***它的任何子类都必须在构方中通过super()调用父类的构方***

19. 在父类构方调用可被子类重写的方法，是一种不好的实践，***应该只调用private的方法***

20. 子类和父类的变量和方法可以重名，
  - ***对于private变量和方法，它们只能在类内被访问，访问的也永远是当前类***，即在子类中，访问的是子类，在父类中，访问的是父类，它们之间没有关系。
  - 对于public变量和方法，在类内部访问的是当前类的，但子类可以通过super()明确指定访问父类的。***在类外，则要看访问变量的静态类型，静态类型是父类，则访问的是父类的变量和方法，静态类型是子类，则访问的是子类的变量和方法。***
  ```
   //父类
   public class Base{
       public static String s="static_base";
       public String m="base";
       public static void staticTest(){

       }
   }

   //子类
   public class Child extends Base{
       public static String s="child_base";
       public String m="child";
       public  static void staticTest(){

       }
   }
  ```
  - 子类定义了和父类重名的变量和方法，对于一个子类对象，它就有了两个变量和方法，***在子类内部访问的时，访问的是子类***。
  ```
  //外部访问
  public static void main(String[] args){
    Child c=new Child();
    Base b=c;

    //输出
    b.s;
    b.m;
    b.staticTest();

    c.s;
    c.m;
    c.staticTest();

  }
  //输出结果
  /**
  * static_base   
  * base
  * base static: static_base
  * child_base
  * child
  * child static: child_base
  */
  ```
  - **当通过b(静态类型Base)访问时，访问的是Base的变量和方法，当通过c(静态类型Child)访问时，访问的是Child的变量和方法，这就是静态绑定**。即访问绑定到变量的静态变量。
  >实例变量、静态变量、静态方法、private方法都是静态绑定的。

  21. 重载是指方法名称相同但参数签名不同(***参数个数或类型或顺序不同***)。

  22. 重写是指子类重写父类相同参数签名的方法。
  
   ```
   //父类
   public class Base{
      public int sum(int a,int b){

      }
   }

   //子类
   public class Child extends Base{
     public long sum(long a,long b){

     }
   }

   //调用代码
   public static void main(String[] args){
     Child c=new Child();
     int a=2;
     int b=3;
     c.sum(a,b);
   }
   //会调用父类的sum方法，因为父类的更匹配。
   ```
   > int类型可以自动转型为long
  - 在有多个重名函数时，在决定要调用那个函数的过程中，首先要按照 ***参数类型*** 进行匹配，***寻找所有重载版本中最匹配的，然后才看变量的动态类型，进行动态绑定*** 。

  23. 子类型的对象可以赋值给父类型的引用变量，***向上转型***。

  24. 向下转型不一定成功。
  ```
  //可以转换
  Base b=new Child();
  Child c=(Child)b;

  //不能转换 提示类型转换错误
  Base b=new Base();
  Child c=(Child)b;

  ```
  >一个父类的变量，能不能转换为一个子类的变量，取决于这个父类变量的动态类型(即引用的对象类型)是不是这个子类或这个子类的子类。instanceof前面是变量，后面是类，表示变量引用的对象是不是该类或其子类的对象。

  25. protected 可以被子类访问，被同一个包中的其他类访问，不管其他类是不是该类的子类。

  26. 子类方法不能降低父类方法的可见性。
      父  public   子   public
      父 protected  子  public/protected
  
  27. final 防止继承
  ```
  public final class Base{

  }
  ```
  >一个Java类，默认都是可以被继承的，但加了final后就不能被继承了。

  - 对于非final类，其中public/protected实例方法默认都是可以重写的，但加了final就不能被重写了。
  ```
  public class Base{
    public final void test(){

    }
  }
  ```
28. 继承的细节
```
//父类
public class Base{
   public static int s;
   private int a;

   static{
     //父类静态代码块
     s=1;
   }
   {
      //父类实例代码块
      a=1;
   }
   public Base(){
     //父类构方
     a=2;
   }
   protected void step(){
     print("s "+s+" a "+a);
   }
   public void action(){
     System.out.println("start");
     step();
     System.out.println("end");
   }
}

//子类
public class Child extends Base{
  public static int s;
  private int a;

  static{
    //子类静态代码块
    s=10;
  }
  {
    //子类实例代码块
    a=10;
  }
  public Child(){
    a=20;
  }
  protected void step(){
    //输出s和a
  }
}

public static void main(String[] args){
  Child c=new Child();
  c.action();
  Base b=c;
  b.action();
  //输出
  b.s;
  c.s;
}
```
29. 类的加载
- 类的加载:将类的相关信息加载到内存。
- 在Java中，类是动态加载的，第一次使用这个类时才会加载，加载一个类时，如果其父类没有加载，则会加载其父类。
- 一个类的信息主要包括
   - 类变量(静态变量)
   - 类初始化代码
   - 类方法(静态方法)
   - 实例变量
   - 实例初始化代码
   - 实例方法
   - 父类信息引用
- 类初始化代码包括
   - 定义静态变量时的赋值语句
   - 静态初始化代码块
- 实例初始化代码
   - 定义实例变量时的赋值语句
   - 实例初始化代码块
   - 构造方法
- 类加载过程
   - 分配内存保存类的信息
   - 给类变量赋默认值
   - 加载父类
   - 设置父子关系
   - 执行类初始化代码
>在类初始化时，先执行父类，在执行子类，不过，父类执行时，子类静态变量的值也是有的，是默认值。
   
>内存分为栈和堆，栈存放函数的局部变量，堆存放动态分配的对象，还有一个内存区，存放类的信息，被称为方法区。
- 创建对象
   - 分配内存(包括本类和所有父类的实例变量，但不包括任何静态变量)
   - 对所有实例变量赋默认值
   - 执行实例初始化代码(先父后子，在任何类执行初始化代码前，所有的实例变量都已经设置完默认值)
>寻找要执行的实例方法的时候，是从对象的实际类型信息开始查找的，找不到的时候，再查找父类类型信息。

>动态绑定:根据对象的实际类型查找要执行的方法，子类型中找不到的时候再查找父类。

- 虚方法表:在类加载的时候，为每个类创建一个表，这个表包括该类的对象所有动态绑定的方法及其地址，包括父类的方法，但一个方法只有一个记录，子类重写了父类方法就只会保留子类的。

# 接口、抽象类、内部类、包、枚举的本质
## 1. 接口
### 接口的概念
 - 接口声明一组能力，但自己不会去实现这些能力。涉及交互双方对象，一方需要实现这个接口，一方使用这个接口，但双方对象并不直接相互依赖，只是通过接口间接交互。
 ### 定义接口
 ```java
 public interface MyComparable{
     int compareTo(Object other);
 }

 ```
 ### 实现接口
 ```java
 public class Point implements MyComparable{
     private int x;
     private int y;

     public Point(int x,int y){
         this.x=x;
         this.y=y;
     }

     public double distance(){
         return Math.sqrt(x*x+y*y);
     }

     public int compareTo(Object other){
         if(!(other instanceof Point)){
             throw new IllegalArgumentException();
         }
         Point otherPoint=(Point)other;
         double delta=distance()-otherPoint.distance();
         if(delta<0){
            return -1;
         }else if(delta>0){
            return 1;
         }else{
            return 0;
         }
     }

     public String toString(){

     }
 }
 ```
 ### 使用接口
 - 接口不能创建，但可以声明接口类型的变量，引用实现了接口的类对象
 ```
 MyComparable p1=new Point(2,3);
 MyComparable p2=new Point(1,2);
 p1.compareTo(p2);
 ```
 >如果一个类型实现了多个接口，这个类型的对象就可以被赋值给任一接口类型的变量。
 ### 接口的细节
 - 接口中的变量
 - 接口的继承
 - 类的继承与接口
 - instanceof
 #### 接口中的变量
 ```
 public interface MyInterface{
     //public static final是可选的 不写，也是这个
     //可以通过接口名.变量名来使用
     public static final int a=0;
 }
 ```
 #### 接口的继承
 - 接口可以多个父接口
 ```
 public interface IBase1{

 }
 public interface IBase2{

 }
 public interface IChild extends IBase1,IBase2{

 }
 ```
 #### instanceof
 - 判断一个对象是否实现了某个接口
 ```
 Point p=new Point(2,3);
 if(p instanceof MyCompareable){

 }
 ```
 #### 使用接口代替继承
 ```
 public interface IAdd{

 }
 public class Base implements IAdd{

 }
 public class Child implements IAdd{

 }
 ```

 ## 2.抽象类
 ### 基本概念
 - 狗是具体对象 而动物则是抽象概念
 ### 抽象方法和抽象类
 - 抽象方法:只有子类才知道如何实现的方法.
 >接口中的方法都是抽象方法
 ```
 public abstract class Shape{
     public abstract void draw();
 }
 ```
 - ***定义了抽象方法的类必须被声明为抽象类***
 - 抽象类可以没有抽象方法
 - 抽象类不能创建对象(比如，不能使用new Shape()),而具体类可以。
 - 抽象类不能创建对象，只能通过具体子类来创建，一个类在继承了抽象类后，必须实现抽象类中定义的所有抽象方法，除非它自己也声明为抽象类。
 ```
 //可以声明抽象类的变量，引用抽象类具体子类的对象
 Shape shape=new Circle();
 shape.draw();
 ```
 >接口声明能力，抽象类提供默认实现，实现全部或部分方法。

 - 实现接口，要实现全部方法。继承抽象类，根据需要重写方法。
 ## 3. 内部类
 ### 基本概念
 - 一个类定义在另一个类的内部
 - 分类
    - 静态内部类
    - 成员内部类
    - 方法内部类 (一个方法内定义和使用)
    - 匿名内部类 
#### 静态内部类
- 静态内部类与静态变量和静态方法定义的位置一样，也带有static。
```
public class Outer{
    private static int shared=100;
    //静态内部类
    public static class StaticInner{

    }
    //在类内部，可以直接使用内部静态类
    public void test(){
        StaticInner inner=new StaticInner();
        inner.方法();
    }
}
```
- 静态内部类除了位置放在别的类内部外，它与一个独立的类差别不大，可以有静态变量、静态方法、成员方法、成员变量、构造方法等。可以访问外部类的静态变量和方法，但不可以访问实例变量和方法。
- 其他类调用内部类
```
Outer.StaticInner si=new Outer.StaticInner();
si.方法();
```
#### 成员内部类
- 没有static修饰符
```
public class Outer{
    private int a=100;

    public class Inner{
        public void innerMethod(){
            //直接访问外部类的实例
            print(a);
            Outer.this.action();//在重名情况下通过Outer.this.XXX引用
        }
    }
    private void action(){

    }
    public void test(){
        Inner inner=new Inner();
        inner.innerMethod();
    }
}
```
-成员内部类可以访问静态变量和方法，还可以访问实例变量和方法。
#### 在其他地方使用
```
//创建内部类对象
Outer outer=new Outer();
Outer.Inner inner=outer.new Inner();
inner.innerMethod();
```
- ***成员、方法和匿名内部类都不能定义静态变量和方法(final 变量除外，它等同于常量)***
#### 方法内部类
```
public class Outer{
    private int a=100;

    public void test(final int param){
        final String str="hello";
        //方法内部类只能在定义的方法内部使用
        class Inner{
            public void innerMethod(){
                print(a,param,str);
            }
        }
        Inner inner=new Inner();
        inner.innerMethod();
    }
}
```
- 如果方法是实例方法，则除了静态变量和方法，内部类还可以直接访问外部类的实例变量和方法，如果是方法是静态的，则方法内部类只能访问外部类的静态变量和方法。
- 还可以直接访问方法中声明为final的参数和局部变量，对于这些变量的赋值，并不能改变外部的值。
- 如果需要修改外部的变量，可以将变量改为只含该变量的数组。

#### 匿名内部类
```
new 父类(参数列表){
//匿名内部类实现部分
}
new 父接口(){
    //实现部分
}
//具体实例
public class Outer{
    public void test(final int x,final int y){
      Point p=new Ponit(2,3){
          public double distance(){
              return distance(new Point(x,y));
          }
      }
      print(p.distance());
    }
}
```
- 匿名内部类只能被使用一次，用来创建对象，没有名字，没有构造方法。但可以根据参数列表，调用对应的父类构造方法。可以定义实例变量和方法，可以有初始化代码块。
>初始化代码块只能有一个。
- ***可以访问外部类的所有变量和方法，可以访问方法中的final参数和局部变量***
## 包
- Java API中所有的类和接口都位于包java或javax下，java是标准包，javax是扩展包。
- 如果不写可见性修饰符，就是在同一个包(指直接包，子包里不可见)里可见。
- private < 默认 < protected < public
## 枚举的本质
### 基本用法
- enum来定义枚举
- 枚举变量的toString和name()都返回变量的名字
```java
   public enum Size{
       SMALL,MEDIUM,LARGE
   }
   Size size=Size.SMALL;
   print(size.toString()/size.name());//输出的都是SMALL
```
- 可以用equals和==来比较
- 枚举可以用于switch
```java 
  public static void onChosen(Size size){
      switch(size){
          case SMALL:
              break;
          case MEDIUM:
              break;
      }
  }
```
- 枚举类型都有一个静态的valueOf(),返回字符串对应的枚举值。
```java
   Size.SMALL==Size.valueOf("SMALL");  //=true
```
- 静态的values(),返回一个包括所有枚举值的数组，声明时的顺序。
```java
  for(Size size:Size.values){
      print(size);
  }
```
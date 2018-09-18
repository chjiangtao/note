# 接口、抽象类、内部类、包、枚举的本质
## 1. 接口
### 接口的概念
 - 接口声明一组能力，但自己不会去实现这些能力。涉及交互双方对象，一方需要实现这个接口，一方使用这个接口，但双方对象并不直接相互依赖，只是通过接口间接交互。
 ### 定义接口
 ```
 public interface MyComparable{
     int compareTo(Object other);
 }

 ```
 ### 实现接口
 ```
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
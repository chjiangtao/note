1. java 两个字节表示一个字符
2. 数组的赋值方式
   - int[] arr={1,2,3};
   - int[] arr=new int[]{1,2,3};
   - int[] arr=new int[3];
        arr[0]=1;
        arr[1]=2;
        arr[2]=3;
  *在没有给变量赋值时，每个变量都有一个默认值
   int 0
   boolean false
   char  null
   
   - 数组长度可以动态确定
       int length=5;
       int[] arr=new int[length];
    *数组有一个Length属性，但只能读不能改

3. ++/--
   - a++ 先操作在修改自己的值
   - ++a 先修改在操作自己的值
4. 编码
   - java 中处理字符串的类String
   - public byte[] getBytes(String charsetName) 获取一个字符串给定编码格式下的二进制形式
   - public String(byte byte[],String charsetName) 将二进制数组bytes按照charsetName编码格式解析
   
   - 将A看成BG18030 将B看成Window-1252
   - String str="  ";
   - String newStr=new String(str.getBytes("windows-1252"),"GB18030");
5. char的本质
   - char本质上是一个固定占用两个字节的无符号正整数，这个正整数对应Unicode编码，由于固定占
    两个字节，char只能表示Unicode编号在65536以内的字符。
6. 条件执行
    - if/if else/else 判断有顺序，只有在前面的为false后才去判断后面的。
7. switch的值只能是byte short int char 枚举和String
8. 死循环
    - for(;;)
    - while(true){}
9. break 跳出循环，执行后面的语句
10. continue 结束本次循环，进行下一次的循环
11. 在嵌套循环中，break和continue只对本层循环有用
12. 整数的二进制表示 Integer.toBinaryString(value)
13. 可变长度的参数  int...  a   
    ```
    //获取值
    for(int i=0;i<a.length;i++){
        a[i]
    }
    ```
     
    方法 public static int max(int... a){

         }
    调用  max(0,1,2,3,4,5)
    *可变长度参数必须是参数列表的最后一个参数，一个函数只有一个可变参数

14.函数中的参数和函数内定义的变量，都分配在栈里，这些变量只有在函数被调用的时候
   才分配，而且调用调用结束就被释放了。主要针对基本类型

15.对于数组和对象类型，它有两块内存，一块存放实际的内容，一块存放实际内容的地址，
   实际的内容空间一般分配在堆上，存放地址的空间在栈上。

16.对于数组，在栈中存放的是实际内容的地址，存放地址的栈空间会随着入栈分配，
   出栈释放，但存放实际内容的堆空间不受影响。当程序运行结束，没有在指向堆空间的变量时，
   java垃圾回收机制会释放这块空间。

17.对于递归函数，函数代码虽然只有一份，但在执行过程中，每调用一次，就会有一次入栈，
   生成一份不同的参数、局部变量和返回地址。
- 变量名区分大小写

- 对于一个声明没有赋值的变量，则该变量的值为undefined(表示“无定义”)。

- 变量可以随时改变类型
```js
var a =1;
```
### 变量提升
- JS的工作方式，先解析代码，获取所有被声明的变量，然后在一行一行的运行。所有变量的声明语句，都会被提升到代码的头部
```js
console.log(a);
var a=1;
//不会报错，因为变量提升，a被声明，但是没有赋值
var a;
console.log(a);//输出的值为 undefined
a=1;
```
### 命名规则
### 注释
```js
//单行注释

/*
  多行注释
*/
```
###条件语句
```js
a==b //相等运算符
a===b //严格相等运算符
//if结构
if(){
    //语句
}

if(){

}else{

}

if(){

}else if(){

}else if(){

}

//switch结构
switch(){
    case value1:
      break;
    case value2:
       break;
}
```
### 三元运算符
(条件)？表达式1::表达式2
### 循环
```js
//while循环
while(条件){

}
//for循环
for(var i=0;i<100;i++){

}
//无限循环
for(;;){

}
//do while循环
do{
   //语句
}while(条件);
```
- break跳出代码块或循环，continue终止本次循环，开始下一次循环，若有多层循环，都只对最内层循环起作用。


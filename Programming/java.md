封裝 Encapsulation
=====
* public：public表明該資料成員、成員函式是對所有使用者開放，所有使用者都可以直接進行呼叫
* private：private表示私有，私有的意思就是除了class自己之外，任何人都不可以直接使用，私有財產神聖不可侵犯嘛，即便是子女，朋友，都不可以使用。
* protected：protected對於子女、朋友來說，就是public的，可以自由使用，沒有任何限制，而對於其他的外部class，protected就變成private。


            | Class | Package | Subclass | Subclass | World
            |       |         |(same pkg)|(diff pkg)|
————————————+———————+—————————+——————————+——————————+————————
public      |   √   |    √    |    √     |     √    |   √
————————————+———————+—————————+——————————+——————————+————————
protected   |   √   |    √    |    √     |     √    |
————————————+———————+—————————+——————————+——————————+————————
no modifier |   √   |    √    |    √     |          |
————————————+———————+—————————+——————————+——————————+————————
private     |   √   |         |          |          |


Overloading 重載/多載
=====
```java
static int binarySearch(byte[] a, byte key);
static int binarySearch(byte[] a, int fromIndex, int toIndex, byte key);
```

Overriding 子類別覆寫
=====
```java
class Animal{
    protected int legs = 1;
    public int getLegs(){
      return legs*4;
    }
}
class Bird extends Animal{
   public int getLegs(){
       return legs*2;
   }
}
```

final 常數
=====
* 跟 C 的 const 是一樣的

Abstract class
=====
* 僅宣告方法名稱而不實作當中的邏輯，這樣的方法稱之為「抽象方法」（Abstract method），
* 如果一個類別中包括了抽象方法，則該類別稱之為「抽象類別」（Abstract class）
```java
public abstract class Listener {
    double PI = 3.14149; // 同public static final
    protected abstract void showMessage(String message); // 同public abstract
}
public class A implements Listener {
    protected void showMessage(String message) {
        System.out.println(message + "!");
    }
}
```

Interface 界面
=====
```java
public interface Listener {
    double PI = 3.14149; // 同public static final
    void listen(); // 同public abstract
}
public class A implements Listener {
    public void listen() {
    }
}
```

generic 泛型
=====
```java
List<Integer> intList = new LinkedList<Integer>();
List<Double> intList = new LinkedList<Double>();
```

Polymorphism 多型
=====
```java
Animal puppy1, puppy2, puppy3; // Animal 宣告
puppy1 = new Elephant("大象", 6, 70); // new Elephant
```

Binding
=====
* Early (or static) binding = compile time binding
* Late (or dynamic) binding = runtime binding
```java
//early binding:
public create_a_foo(*args) {
    return new Foo(args)
}
my_foo = create_a_foo();

//late binding:
public create_something(Class klass, *args) {
    klass.new_instance(args)
}
my_foo = create_something(Foo);
```

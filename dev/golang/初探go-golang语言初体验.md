# 初探go-golang语言初体验
2018/11/6


### 初体验
**安装**

如果网络访问 golang.org 异常，，请想办法绕过，例如从国外服务器上访问。
mac:
```bash
# wget https://dl.google.com/go/go1.11.1.darwin-amd64.pkg
```

linux:
```bash
# wget https://dl.google.com/go/go1.11.1.linux-amd64.tar.gz
# tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
```

环境变量：
```bash
# cat <<'_EOF' >/etc/profile
###golang
export GOPATH=/opt/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
_EOF

# source /etc/profile
```

**教程**
```bash
# go tool tour &
```
访问：http://127.0.0.1:3999/

**查看当前 go 的环境变量**
```bash
# go env
```


**第一个程序**
```bash
# mkdir -p $GOPATH/src/github.com/opera443399/cmd
# cd $GOPATH/src/github.com/opera443399/cmd

# mkdir hello
# vim hello/app1.go
package main

import "fmt"

func main() {
  fmt.Printf("Hello, world.\n")
}


# go run hello/app1.go
Hello, world.
```

**第一个包**
```bash
# mkdir stringutil
# vim stringutil/reverse.go
// Package stringutil contains utility functions for working with strings.
package stringutil

// Reverse returns its argument string reversed rune-wise left to right.
func Reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}

# go build github.com/opera443399/cmd/stringutil
# vim /hello/app.go
package main

import (
  "fmt"

	"github.com/opera443399/cmd/stringutil"
)

func main() {
	fmt.Printf(stringutil.Reverse("!oG ,olleH"))
}

# go install github.com/opera443399/cmd/hello
# /opt/go/bin/hello
Hello, Go!
```

**引入测试**
```bash
# vim stringutil/reverse_test.go
package stringutil

import "testing"

func TestReverse(t *testing.T) {
	cases := []struct {
		in, want string
	}{
		{"Hello, world", "dlrow ,olleH"},
		{"Hello, 世界", "界世 ,olleH"},
		{"", ""},
	}
	for _, c := range cases {
		got := Reverse(c.in)
		if got != c.want {
			t.Errorf("Reverse(%q) == %q, want %q", c.in, got, c.want)
		}
	}
}

# go test github.com/opera443399/cmd/stringutil
ok      github.com/opera443399/cmd/stringutil 0.007s
```


**使用远程的包**
示例，从git上指定的url获取包，go get 将完成 fetch, build 和 install的操作：
```bash
# go get github.com/golang/example/hello
# /opt/go/bin/hello
Hello, Go examples!
```



### 试着写一个小的程序
**设定目标**
- 尽量多的用到go语言的语法基础内容：packages, variables ,functions Flow control, method, interface, concurrency
- 请求 url，获取状态等；


**代码示例**
github.com/opera443399/cmd/httpHead/app.go



**运行**
```
# go install github.com/opera443399/cmd/httpHead
# /opt/go/bin/httpHead -h
Usage of /Users/pengchao/go/bin/httpHead:
  -c int
    	[] repeat N times to request the URL. (default 10)
  -f string
    	[] load URLs from file.


# /opt/go/bin/httpHead -c 2 -f /tmp/urls.list
[0]https://www.baidu.com : 200 OK
[1]https://www.baidu.com : 200 OK
[0]https://www.qq.com : 200 OK
[1]https://www.qq.com : 200 OK
2018/11/06 15:45:24 timer expired (1s)
2018/11/06 15:45:24 success: 4, failure: 0, Time Cost: 1.366854494s
```


**交叉编译**
当前为 mac 环境
```bash
# go install github.com/opera443399/cmd/httpHead
```

编译其他环境：
```bash
# GOARCH="amd64" GOOS="windows" go install github.com/opera443399/cmd/httpHead
# GOARCH="amd64" GOOS="linux" go install github.com/opera443399/cmd/httpHead
```

验证：
```bash
# find /opt/go/bin -name 'httpHead*'
/opt/go/bin/windows_amd64/httpHead.exe
/opt/go/bin/httpHead
/opt/go/bin/linux_amd64/httpHead
```





### FAQ
```
1、当我的本地网络访问 golang.org 异常时，应该如何处理？
答：
例如，遇到这样的错误：
cannot find package "golang.org/x/crypto/bcrypt"
cannot find package "golang.org/x/net/websocket"

那是因为网络可达性问题，国内访问 golang.org 异常。
[root@dev_08 portainer]# host golang.org
golang.org is an alias for golang-consa.l.google.com.
golang-consa.l.google.com has address 216.239.37.1

导致这2个依赖下载失败：
golang.org/x/crypto/bcrypt
golang.org/x/net/websocket


**如何解决**
方法1：
go get github.com/golang/crypto/tree/master/bcrypt
go get github.com/golang/net/tree/master/websocket

# cd $GOPATH/src
# mkdir golang.org/x -p
# mv github.com/golang/* golang.org/x/

方法2：
引入 dep 之类的依赖包管理工具
```

### 在学习的过程中，体验到哪些印象深刻的基础语法？
```
答：温故而知新。

【--】 package
package main

包名main则告诉我们它是一个可独立运行的包，它在编译后会产生可执行文件。
通常 package 名称和目录同名
注意vender机制的使用

Go程序会自动调用init()和main()，所以你不需要在任何地方调用这两个函数。每个package中的init函数都是可选的，但package main就必须包含一个main函数。

几个特殊的写法：
*** 点 操作

我们有时候会看到如下的方式导入包

    import(
        . "fmt"
    )
这个点操作的含义就是这个包导入之后在你调用这个包的函数时，你可以省略前缀的包名，也就是前面你调用的fmt.Println("hello world")可以省略的写成Println("hello world")

*** 别名 操作

别名操作顾名思义我们可以把包命名成另一个我们用起来容易记忆的名字

    import(
        f "fmt"
    )
别名操作的话调用包函数时前缀变成了我们的前缀，即f.Println("hello world")

*** _ 操作

这个操作经常是让很多人费解的一个操作符，请看下面这个import

	import (
	    "database/sql"
	    _ "github.com/ziutek/mymysql/godrv"
	)
_操作其实是引入该包，而不直接使用包里面的函数，而是调用了该包里面的init函数。



【--】 声明 var 和 func 时，我应该用大写，还是小写？
采用驼峰命名

大写字母开头的变量是可导出的，也就是其它包可以读取的，是公有变量；小写字母开头的就是不可导出的，是私有变量。
大写字母开头的函数也是一样，相当于class中的带public关键词的公有函数；小写字母开头的就是有private关键词的私有函数。

Go里面的面向对象是如此的简单，没有任何的私有、公有关键字，通过大小写来实现(大写开头的为公有，小写开头的为私有)，方法也同样适用这个原则。


【--】 申明 var
一般用var方式来定义全局变量
var variableName type
var vname1, vname2, vname3 type
var variableName type = value
var vname1, vname2, vname3 type= v1, v2, v3
var vname1, vname2, vname3 = v1, v2, v3

推荐写法：
import(
	"fmt"
	"os"
)

const(
	i = 100
	pi = 3.1415
	prefix = "Go_"
)

var(
	i int
	pi float32
	prefix string
)

简短声明（仅用于函数内部）
vname1, vname2, vname3 := v1, v2, v3

对于已声明但未使用的变量会在编译阶段报错



【--】 申明 func
注意一下函数返回值的写法
func funcName(input1 type1, input2 type2) (output1 type1, output2 type2) {
	//这里是处理逻辑代码
	return value1, value2
}
func SumAndProduct(A, B int) (int, int) {
    //这里是处理逻辑代码
	return A+B, A*B
}
func max(a, b int) int {
    //这里是处理逻辑代码
	return b
}



【--】 iota
Go里面有一个关键字iota，这个关键字用来声明枚举 enum 的时候采用，它默认开始值是0，const中每增加一行加1
例如：
const(
	WHITE = iota
	BLACK
	BLUE
	RED
	YELLOW
)
分别对应
0
1
2
3
4


【--】 slice
slice并不是真正意义上的动态数组，而是一个引用类型。slice总是指向一个底层array，slice的声明也可以像array一样，只是不需要长度。
// 和声明array一样，只是少了长度
var fslice []int

注意在 range 中使用 array 和 slice 的差异


【--】 map
map和其他基本型别不同，它不是thread-safe，在多个go-routine存取时，必须使用mutex lock机制



【--】 make
make用于内建类型（map、slice 和channel）的内存分配
make返回初始化后的（非零）值。
a := make(map[string]int)
b := make(map[string]int){"x":12, "y":25}



【--】 method
"A method is a function with an implicit first argument, called a receiver."

func (r ReceiverType) funcName(parameters) (results)


注意：
如果一个method的receiver是*T,你可以在一个T类型的实例变量V上面调用这个method，而不需要&V去调用这个method
类似的

如果一个method的receiver是T，你可以在一个*T类型的变量P上面调用这个method，而不需要 *P去调用这个method
所以，你不用担心你是调用的指针的method还是不是指针的method，Go知道你要做的一切，这对于有多年C/C++编程经验的同学来说，真是解决了一个很大的痛苦。



【--】 struct
要理解匿名字段在 override 的时候的用法

package main

import "fmt"

type Human struct {
    name string
    age int
    phone string
}

type Student struct {
    Human //匿名字段
    school string
}

type Employee struct {
    Human //匿名字段
    company string
    phone string  // 雇员的phone字段
}

//Human定义method
func (h *Human) SayHi() {
    fmt.Printf("Hi, I am %s you can call me on %s\n", h.name, h.phone)
}

//Employee的method重写Human的method
func (e *Employee) SayHi() {
    fmt.Printf("Hi, I am %s, I work at %s. Call me on %s\n", e.name,
		e.company, e.phone) //Yes you can split into 2 lines here.
}

func main() {
    Bob := Employee{Human{"Bob", 34, "1111111"}, "Designer", "6666666"}
    fmt.Println("Bob's work phone is:", Bob.phone)
    // 如果我们要访问Human的phone字段
    fmt.Println("Bob's personal phone is:", Bob.Human.phone)

    Mark := Student{Human{"Mark", 25, "44444444"}, "MIT"}
    Sam := Employee{Human{"Sam", 45, "5555555"}, "Golang Inc", "999999"}

    Mark.SayHi()
    Sam.SayHi()
}



【--】 interface
通过 interface 来组合一组 method 对外提供服务

空interface(interface{})不包含任何的method，正因为如此，所有的类型都实现了空interface。空interface对于描述起不到任何的作用(因为它不包含任何的method），但是空interface在我们需要存储任意类型的数值的时候相当有用，因为它可以存储任意类型的数值。

interface的变量可以持有任意实现该interface类型的对象，这给我们编写函数(包括method)提供了一些额外的思考，我们是不是可以通过定义interface参数，让函数接受各种类型的参数。


注意这种用法：
value, ok = element.(T)
这里value就是变量的值，ok是一个bool类型，element是interface变量，T是断言的类型。
如果element里面确实存储了T类型的数值，那么ok返回true，否则返回false。

注意类似 struct 包含匿名字段的方式在 interface 也是类似的行为。
例如：io包下面的 io.ReadWriter ，它包含了io包下面的Reader和Writer两个interface：

// io.ReadWriter
type ReadWriter interface {
	Reader
	Writer
}



【--】 goroutine
注意 Select 的用法
如果存在多个channel的时候，我们该如何操作呢，Go里面提供了一个关键字select，通过select可以监听channel上的数据流动。
select默认是阻塞的，只有当监听的channel中有发送或接收可以进行时才会运行，当多个channel都准备好的时候，select是随机的选择一个执行的。
有时候会出现goroutine阻塞的情况，那么我们如何避免整个程序进入阻塞的情况呢？我们可以利用select来设置超时


特别重视：关闭的Channel永远不会阻塞
```







### XYXW、参考
1. [golang-doc](https://golang.org/doc)
2. [the-way-to-go_ZH_CN](https://github.com/Unknwon/the-way-to-go_ZH_CN/blob/master/eBook/directory.md)
3. [解决升级go版本遇到的Set $GOROOT_BOOTSTRAP to a working Go tree >= Go 1.4.问题](http://blog.csdn.net/qq_15437667/article/details/59776840)
4. [国内下载golang.org的包有什么好办法么？](https://gocn.io/question/362)
5. [a-channel-compendium-for-golang](http://tonybai.com/2014/09/29/a-channel-compendium-for-golang/)
6. [a-channel-compendium-for-golang](http://tonybai.com/2014/09/29/a-channel-compendium-for-golang/)
7. [understanding-import-packages](http://tonybai.com/2015/03/09/understanding-import-packages/)
8. [understand-go15-vendor](http://tonybai.com/2015/07/31/understand-go15-vendor/)
9. [7-things-you-may-not-pay-attation-to-in-go](http://tonybai.com/2015/09/17/7-things-you-may-not-pay-attation-to-in-go/)
10. [how-to-use-timer-reset-in-golang-correctly](http://tonybai.com/2016/12/21/how-to-use-timer-reset-in-golang-correctly/)

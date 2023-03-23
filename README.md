教程: [The complete guide to OpenTelemetry in Golang](https://www.komu.engineer/blogs/11/opentelemetry-and-go.html)        

按顺序执行以下脚本
```sh
cd confs/ # 生成证书
./gen.sh

docker compose up --build # 启动collector jaeger prometheus

cd .. # 启动测试服务器
go run ./...

curl -vkL http://127.0.0.1:8081/serviceA # 发出测试请求
```


# 基于Docker的多节点操作（一）

## 实验目标
通过使用Docker和`docker-compose`创建多个节点，在不同节点之间使用`netcat (nc)`工具实现以下功能：
1. 消息传送
2. 文件传输
3. 远程Shell控制

---

## 实验环境
- 操作系统：支持Docker的Linux/Windows/MacOS
- 软件要求：
  - Docker
  - Docker Compose
  - Visual Studio Code（VSCode）

---

## 实验准备
在本仓库中，您已经拥有必要的 `Dockerfile` 和 `docker-compose.yml` 文件。

---

## 实验步骤

### 步骤 1：构建和启动容器
1. 打开终端，进入本项目的根目录。
2. 执行以下命令构建镜像并启动服务：
   ```bash
   docker-compose up --build -d
   ```
3. 验证容器是否已启动：
   ```bash
   docker ps
   ```
   确认三个容器（`node01`、`node02`、`node03`）均已运行。

---

### 步骤 2：使用 VSCode Attach 到容器
1. 打开 Visual Studio Code。
2. 安装扩展 `Remote - Containers`。
3. 使用快捷键 `F1` 或点击左下角绿色图标，选择 **Attach to Running Container**。
4. 分别连接到 `node01`、`node02` 和 `node03`，确保能够访问每个节点的终端。

---

### 步骤 3：节点间消息传送
#### 1. 在 `node01` 上启动监听
在 `node01` 的终端输入以下命令：
```bash
nc -l -p 12345
```

#### 2. 在 `node02` 上发送消息
在 `node02` 的终端输入以下命令：
```bash
echo "Hello from node02" | nc node01 12345
```

#### 3. 验证消息传送
回到 `node01` 的终端，确认接收到来自 `node02` 的消息 `Hello from node02`。

---

### 步骤 4：节点间文件传输
#### 1. 在 `node01` 上准备接收文件
在 `node01` 的终端输入以下命令：
```bash
nc -l -p 12345 > received_file.txt
```

#### 2. 在 `node02` 上发送文件
创建一个文件（`sample.txt`）并写入一些内容：
```bash
echo "This is a test file." > sample.txt
```

使用 `nc` 传输文件到 `node01`：
```bash
cat sample.txt | nc node01 12345
```

#### 3. 验证文件传输
在 `node01` 的终端查看接收到的文件：
```bash
cat received_file.txt
```

---

### 步骤 5：远程Shell控制
#### 1. 在 `node01` 上启动 Shell 监听
在 `node01` 的终端输入以下命令：
```bash
nc -l -p 12345 -e /bin/bash
```

#### 2. 在 `node02` 上连接到远程Shell
在 `node02` 的终端输入以下命令：
```bash
nc node01 12345
```

#### 3. 测试远程Shell
连接后，你将进入 `node01` 的终端环境，执行以下命令验证：
```bash
whoami
ls
```

---

## 注意事项
- 所有 `nc` 命令使用的端口号必须一致。
- 文件传输和远程Shell可能涉及安全问题，仅在实验环境中使用。
- 若节点间无法通信，检查网络设置或确保容器处于同一网络中。

---

## 实验结果
通过以上步骤，您将学会：
1. 使用 `nc` 实现节点间的消息传递。
2. 使用 `nc` 在节点间传输文件。
3. 使用 `nc` 实现节点间远程Shell控制。

---

### 下一步探索
1. 通过 `ssh` 替代 `nc` 提高安全性。
2. 使用 `docker network` 配置更复杂的网络拓扑结构。

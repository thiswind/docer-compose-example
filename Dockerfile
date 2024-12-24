FROM debian:bookworm

# 更新包列表并安装必要的软件
RUN apt-get update && apt-get install -y locales netcat-traditional net-tools vim tldr curl wget iputils-ping dnsutils && rm -rf /var/lib/apt/lists/*

# 设置环境变量
ENV LANG=en_US.utf8

RUN mkdir -p /root/.local/share/tldr
RUN tldr -u

# 创建并设置工作目录
RUN mkdir -p /app
WORKDIR /app

# 保持容器运行的命令
CMD ["tail", "-f", "/dev/null"]
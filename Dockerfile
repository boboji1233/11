# 儿童手腕隐匿性骨折检测系统 - Docker 镜像
# 适用于 Render 等容器平台

FROM python:3.11-slim-bookworm

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0

# 安装 Python 依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件（代码更新时保留依赖构建缓存）
COPY . .

# 创建必要的目录
RUN mkdir -p exit/uploads

# 暴露默认端口（Render 可通过 PORT 环境变量覆盖）
EXPOSE 10000

# 设置环境变量
ENV PYTHONUNBUFFERED=1
ENV PORT=10000
ENV OMP_NUM_THREADS=1
ENV MKL_NUM_THREADS=1

# 启动应用
CMD ["python", "backend.py"]

FROM clickhouse/clickhouse-server:25.12.2.54
RUN mkdir -p /opt/clickhouse/user_scripts && apt update && apt-get install -y build-essential python3
COPY scripts/test_function.py /opt/clickhouse/user_scripts
COPY scripts/test_function.cpp /tmp
RUN g++ -O3 /tmp/test_function.cpp -o /opt/clickhouse/user_scripts/test_function && \
    chmod a+x /opt/clickhouse/user_scripts/test_function

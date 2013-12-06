spark:
  spark-env:
    JAVA_HOME: /usr/lib/jvm/java-7-openjdk-amd64
    SPARK_HOME: /var/spark
    SPARK_MASTER_IP: 10.211.55.100
    SPARK_MASTER_PORT: 7070
    SPARK_WORKER_CORES: 2
    SPARK_WORKER_MEMORY: 500m
    SPARK_WORKER_PORT: 9090
    SPARK_WORKER_INSTANCE: 1
  slaves:
    - vm-cluster-master
    - vm-cluster-node1
    - vm-cluster-node2

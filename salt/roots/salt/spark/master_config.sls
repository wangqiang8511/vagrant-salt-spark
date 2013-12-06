{% set spark_home =  pillar.get('spark:spark_env:SPARK_HOME', '/var/spark')-%}

config_spark_env:
    file.managed:
    - name: {{ spark_home }}/conf/spark-env.sh
    - template: jinja
    - source: salt://spark/files/spark-env.sh.template
    - mode: 644

config_spark_slave:
    file.managed:
    - name: {{ spark_home }}/conf/slaves
    - template: jinja
    - source: salt://spark/files/slaves
    - mode: 644

{% set spark_home =  pillar.get('spark:spark_env:SPARK_HOME', '/var/spark')-%}

start_env:
    cmd.run:
    - name: "{{ spark_home }}/bin/start-all.sh"

{% set spark_home =  pillar.get('spark:spark_env:SPARK_HOME', '/var/spark')-%}

stop_env:
    cmd.run:
    - name: "{{ spark_home }}/bin/stop-all.sh"

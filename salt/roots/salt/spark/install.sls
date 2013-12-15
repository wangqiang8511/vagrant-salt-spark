{% set scala_checksum = 'sha1=01bf9e2c854e2385b2bcef319840415867a00388' -%}
{% set sbt_checksum = 'sha1=85bc755b6a46fa02b9fc0670499c4261a8f063aa' -%}
{% set spark_home =  pillar.get('spark:spark_env:SPARK_HOME', '/var/spark')-%}

spark_git:
  git.latest:
    - name: https://github.com/apache/incubator-spark.git
    - rev: master
    - target: {{ spark_home }}
    - unless: "[ -d {{ spark_home }} ]" 

install_scala:
  file.managed:
    - name: /var/scala/scala_source.tgz
    - source: http://www.scala-lang.org/files/archive/scala-2.9.3.tgz
    - makedirs: True
    - source_hash: {{ scala_checksum }}
    - unless: "[ -d /usr/share/scala-2.9.3 ]" 
  cmd.run:
    - name: "tar -zxf /var/scala/scala_source.tgz -C /usr/share" 
    - require: 
      - file: install_scala
    - unless: "[ -d /usr/share/scala-2.9.3 ]" 

install_sbt:
  file.managed:
    - name: /var/sbt/sbt.tgz
    - source: http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.13.0/sbt.tgz 
    - makedirs: True
    - source_hash: {{ sbt_checksum }}
    - unless: "[ -d /usr/share/sbt ]" 
  cmd.run:
    - name: "tar -zxf /var/sbt/sbt.tgz -C /usr/share" 
    - require: 
      - file: install_sbt
    - unless: "[ -d /usr/share/sbt ]" 

link_scala:
  file.managed:
    - name: /var/scala/link_scala.sh
    - mode: 755
    - makedirs: True
    - source: salt://spark/files/link_scala.sh
    - require:
      - cmd: install_scala
  cmd.run:
    - name: "/var/scala/link_scala.sh" 
    - require: 
      - file: link_scala
    - unless: "[ -e /usr/bin/scala ]"

link_sbt:
  cmd.run:
    - name: "ln -s /usr/share/sbt/bin/sbt /usr/bin/sbt" 
    - require: 
      - cmd: install_sbt
    - unless: "[ -e /usr/bin/sbt ]"

build_spark:
  cmd.run:
    - name: "cd {{ spark_home }} && ./sbt/sbt assembly"
    - require:
      - cmd: link_scala
      - git: spark_git

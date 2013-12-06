{% set checksum = 'sha1=01bf9e2c854e2385b2bcef319840415867a00388' -%}
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
    - source_hash: {{ checksum }}
    - unless: "[ -d /usr/share/scala-2.9.3 ]" 
  cmd.run:
    - name: "tar -zxf /var/scala/scala_source.tgz -C /usr/share" 
    - require: 
      - file.managed: install_scala
    - unless: "[ -d /usr/share/scala-2.9.3 ]" 

link_scala:
  file.managed:
    - name: /var/scala/link_scala.sh
    - mode: 755
    - makedirs: True
    - source: salt://spark/files/link_scala.sh
    - require:
      - cmd.run: install_scala
  cmd.run:
    - name: "/var/scala/link_scala.sh" 
    - require: 
      - file.managed: link_scala
    - unless: "[ -e /usr/bin/scala ]"

build_spark:
  cmd.run:
    - name: "cd {{ spark_home }} && ./sbt/sbt assembly"
    - require:
      - cmd.run: link_scala
      - git.latest: spark_git

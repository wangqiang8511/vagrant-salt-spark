base:
  '*':
    - system.pre_requisite_pkgs
    - system.ssh_key
    - spark.install
    {% if grains['id'] == 'vm-cluster-master' %}
    - spark.master_config
    {% endif %}

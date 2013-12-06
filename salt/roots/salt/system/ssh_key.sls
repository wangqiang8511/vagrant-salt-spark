{% set ssh_user = "vagrant" %}

ssh_id_root_rsa_key:
  file.managed:
    - name: '/root/.ssh/id_rsa'
    - source: salt://system/files/id_rsa
    - user: root
    - group: root
    - mode: 600

ssh_id_root_rsa_pub:
  file.append:
    - name: '/root/.ssh/authorized_keys'
    - makedirs: True
    - sources: 
      - salt://system/files/id_rsa.pub

ssh_id_user_rsa_key:
  file.managed:
    - name: '/home/{{ssh_user}}/.ssh/id_rsa'
    - source: salt://system/files/id_rsa
    - user: {{ssh_user}}
    - group: {{ssh_user}}
    - mode: 600

ssh_id_user_rsa_pub:
  file.append:
    - name: '/home/{{ssh_user}}/.ssh/authorized_keys'
    - makedirs: True
    - sources: 
      - salt://system/files/id_rsa.pub

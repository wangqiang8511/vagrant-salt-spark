# Create Vagrant VMs running spark in standalone cluster mode

## Pre-requsites

* Install VirtualBox.

* Install Vagrant.

* Install Salty Vagrant Plugin

    ```bash
    $ vagrant plugin install vagrant-salt
    ```

## Usage

* Checkout this recipe.

    ```bash
    $ git clone https://github.com/wangqiang8511/vagrant-salt-spark.git
    ```

* Add ubuntu precise64 box

    ```bash
    $ cd vagrant-salt-spark 
    $ vagrant box add precise64 http://files.vagrantup.com/precise64.box   
    ```

* Bring up the VMs

    ```bash
    $ vagrant up
    ```

* SSH to master
    
    ```bash
    $ vagrant ssh master
    ```

* Execute salt highstate

    ```bash
    $ sudo salt "*" state.highstate
    ```

* Start Spark.

    ```bash
    $ sudo salt "*master*" state.sls spark.start
    ```

* Stop Spark.

    ```bash
    $ sudo salt "*master*" state.sls spark.stop
    ``` 

## Reference
* [Spark](http://spark.incubator.apache.org/docs/latest/)
* [vagrant](http://docs.vagrantup.com/v2/)
* [salt](http://docs.saltstack.com/)
* [salty-vagrant](https://github.com/saltstack/salty-vagrant)

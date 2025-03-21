# Build K8s manually
## Description
This Repo contains Ansible playbooks to provision Kuberentes cluster.
### Topology 
```mermaid
graph TD;
    LB[Client/Admin] --> HAProxy[HA Proxy]

    subgraph Master-1
        CA[CA]
        etcd1[etcd 2739]
        api1[kube-api 6443]
        scheduler1[kube-scheduler 10259]
        controller1[kube-controller 10257]
    end

    subgraph Master-2
        etcd2[etcd 2739]
        api2[kube-api 6443]
        scheduler2[kube-scheduler 10259]
        controller2[kube-controller 10257]
    end

    subgraph Worker-1
        kubelet1[kubelet]
        containerd1[containerd]
        proxy1[kube-proxy]
    end

    subgraph Worker-2
        kubelet2[kubelet]
        containerd2[containerd]
        proxy2[kube-proxy]
    end

    HAProxy --> Master-1
    HAProxy --> Master-2

    Master-1 --> Worker-1
    Master-1 --> Worker-2
    Master-2 --> Worker-1
    Master-2 --> Worker-2

    style Worker-1 fill:#ADD8E6,stroke:#000
    style Worker-2 fill:#ADD8E6,stroke:#000

```
### Workflow
```mermaid
flowchart LR
PKI --> ETCD --> Kube-* --> WorkerNodes --> CNI/CRI --> TestApp
```
## Usage
### Ansible hosts file

* Add the ansible hosts file:
```
sudo vim /etc/ansible/hosts
```
Content:
```
[k8s]
master-1
master-2
worker-1
worker-2

[masters]
master-1
master-2

[workers]
worker-1
worker-2
```
* Make sure your system's hosts file is correct:
Example:
```
10.171.176.131 master-1
10.171.176.132 master-2
10.171.176.133 worker-1
10.171.176.134 worker-2
10.171.176.130 loadbalancer
```

### Clean-up existing environment

This script stops all k8s daemons, removes directories and all configs and certs:
```
sudo ./clean-up.sh stop
```

### Execute Ansible playbooks

Run each playbook manually:
```
ansible-playbook --ask-become-pass 01-pki.yml
```

# Credits
Build Kubernetes Hardway
https://github.com/kelseyhightower/kubernetes-the-hard-way

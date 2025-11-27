## Check ETCD health
```
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/ca.crt \
  --cert=/etc/kubernetes/pki/etcd-server.crt \
  --key=/etc/kubernetes/pki/etcd-server.key \
  endpoint health
```

## List All keys

```
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/ca.crt \
  --cert=/etc/kubernetes/pki/etcd-server.crt \
  --key=/etc/kubernetes/pki/etcd-server.key \
  get / --prefix --keys-only
```

 
## Check kube-apiserver kube-controller-manager kube-scheduler
```
systemctl status kube-apiserver
systemctl status kube-controller-manager
systemctl status kube-scheduler
```
```
curl -k https://10.171.176.131:6443/healthz
```
```
curl -k https://10.171.176.131:6443/api
```

## Check containerd
```
sudo ctr images pull docker.io/library/nginx:latest
```
```
sudo ctr images ls
```
## Check flannel
On worker,
```
cat /run/flannel/subnet.env
```
```
ip a
```
```
kubectl --kubeconfig ../admin.kubeconfig describe pod frontend
```


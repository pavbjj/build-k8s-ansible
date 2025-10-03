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

## Write to ETCD

```
ETCDCTL_API=3 etcdctl put /demo/message "Hello from etcd"
```
 

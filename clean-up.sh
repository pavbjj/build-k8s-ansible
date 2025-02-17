#!/bin/bash
# Check if an action (start, stop, restart, etc.) is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <action>"
    echo "Example: $0 start"
    exit 1
fi

# Action to be performed
ACTION=$1

# List of services to manage
SERVICES=("etcd" "kube-apiserver" "kube-controller-manager" "kube-scheduler")
WORKER_SERVICES=("kubelet" "kube-proxy" "containerd")
DIRS=("/var/lib/kubelet" "/var/lib/kube-proxy" "/var/lib/kubernetes/pki" "/var/run/kubernetes")

# List of master nodes
MASTER_NODES=("master-1" "master-2")
WORKER_NODES=("worker-1" "worker-2")

# Loop through each master node
for MASTER in "${MASTER_NODES[@]}"; do
    echo "Connecting to $MASTER..."
    ssh "$MASTER" bash -s <<EOF
#!/bin/bash
    echo "----------------------------------------"
    echo "Running on $MASTER"
    rm -rf /var/lib/kubernetes
    rm -rf /var/lib/etcd
    rm -rf /etc/kubernetes
    rm -f /home/pawel/*.kubeconfig
    rm -rf /etc/etcd
    rm -f /home/pawel/*.crt
    rm -f /home/pawel/*.csr
    rm -f /home/pawel/*.key
    rm -rf /tmp/*
    for SERVICE in "${SERVICES[@]}"; do
        echo "Attempting to $ACTION \$SERVICE..."
        if systemctl $ACTION \$SERVICE; then
            echo "\$SERVICE: Successfully performed action '$ACTION'."
        else
            echo "\$SERVICE: Failed to perform action '$ACTION'. Check system logs for more details."
        fi
        echo "----------------------------------------"
    done
EOF
    echo "Finished processing $MASTER."
done

for WORKER in "${WORKER_NODES[@]}"; do
    echo "Connecting to $WORKER..."
    ssh "$WORKER" bash -s <<EOF
#!/bin/bash
    echo "----------------------------------------"
    echo "Running on $WORKER"
    rm -rf /var/lib/kube*
    rm -rf /etc/kube*
    for SERVICE in "${WORKER_SERVICES[@]}"; do
        echo "Attempting to $ACTION \$SERVICE..."
        if systemctl $ACTION \$SERVICE; then
            echo "\$SERVICE: Successfully performed action '$ACTION'."
        else
            echo "\$SERVICE: Failed to perform action '$ACTION'. Check system logs for more details."
        fi
        echo "----------------------------------------"
    done
    echo "Removing DIRs"
    for kube_dir in "${DIRS[@]}"; do
        echo "Removing $kube_dir..."
        sudo rm -rf "\$kube_dir"
        echo "\$kube_dir removed"
        echo "----------------------------------------"
    done
EOF
    echo "Finished processing $WORKER."
done


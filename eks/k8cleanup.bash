aws eks --region us-east-1 update-kubeconfig --name prod-states-cluster
kubectl config get-contexts --kubeconfig=/root/.kube/config

#kubectl get jobs -n ta-ta -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' --kubeconfig=/root/.kube/config &> outputgetjobs-ta-ta.txt
export OUTPUTX=$(kubectl get jobs -n ta-ta -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' --kubeconfig=/root/.kube/config 2>&1 | grep-v "constructing many client instances" | awk '$2 <= "'$(date -d'now-6 hours' -Ins --utc | sed 's/+0000/Z/')'" { print $1 }' | xargs --no-run-if-empty kubectl delete job -n ta-ta --kubeconfig=/root/.kube/config)
echo $OUTPUTX > outputcleanup-ta-ta.txt

#kubectl get jobs -n us-ct -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' --kubeconfig=/root/.kube/config &> outputgetjobs-us-ct.txt
export OUTPUTX=$(kubectl get jobs -n us-ct -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' --kubeconfig=/root/.kube/config 2>&1 | grep-v "constructing many client instances" | awk '$2 <= "'$(date -d'now-6 hours' -Ins --utc | sed 's/+0000/Z/')'" { print $1 }' | xargs --no-run-if-empty kubectl delete job -n us-ct --kubeconfig=/root/.kube/config)
echo $OUTPUTX > outputcleanup-us-ct.txt

#kubectl get jobs -n us-md -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' --kubeconfig=/root/.kube/config &> outputgetjobs-us-md.txt
export OUTPUTX=$(kubectl get jobs -n us-md -o go-template --template '{{range .items}}{{.metadata.name}} {{.metadata.creationTimestamp}}{{"\n"}}{{end}}' --kubeconfig=/root/.kube/config 2>&1 | grep-v "constructing many client instances" | awk '$2 <= "'$(date -d'now-6 hours' -Ins --utc | sed 's/+0000/Z/')'" { print $1 }' | xargs --no-run-if-empty kubectl delete job -n us-md --kubeconfig=/root/.kube/config)
echo $OUTPUTX > outputcleanup-us-md.txt

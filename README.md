https://hub.docker.com/r/realism1/webserver/tags

Показать, каким образом можно проверить работоспособность запущенного приложения (можно описать несколько способов).

kubectl get pods # посмотреть что поды работают
kubectl describe pod name # посмотреть что работают пробы
kubectl logs name # убедиться что сервер запустился и слушает порт

kubectl port-forward deployment/webserver-deployment 8000:8000
curl http://localhost:8000/test.html

Показать, как можно обновить (рестартануть) одновременно все деплойменты, содержащие в наименовании слово «test». 

kubectl get deployments --all-namespaces | grep -i test | awk '{print $2}' | xargs -n 1 kubectl rollout restart deployment # скрипт выбирает деплойменты, содержащие «test» в названии, и выполняет для каждого команду rollout restart, инициируя обновление подов.

Удалить все поды из namespace kube-system - объяснить почему все pod восстанавливаются после удаления. (core-dns и, например, kube-apiserver, имеют различия в механизме запуска и восстанавливаются по разным причинам)

Coredns управляется deploymentом и следит за количеством реплик
kube-apiserver - поды запускаются непосредственно kubeletом посредством конфигов  /etc/kubernetes/manifests. Если  под удалён, kubelet обнаруживает отсутствие файла в состоянии и автоматически пересоздаёт его.

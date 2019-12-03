Install
=====
```sh
brew cask install docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
```
* Launch the Docker app. Click next. It will ask for privileged access
* A whale icon should appear in the top bar. Click it and wait for "Docker is running" to appear.
* Docker Prefrences -> Kubernetes -> Enable Kubernetes -> wait for "Kubernetess is running" to appear.
```sh
kubectl config use-context docker-desktop

kubectl cluster-info # Make sure no error
kubectl get nodes    # Make sure no error
```


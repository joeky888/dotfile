Install cli
=====
* $ go get -u -v github.com/drone/drone-cli/drone

Usage
=====
* $ drone exec .drone.yml
* If yaml file contains docker volume
* $ drone exec --trusted

docker env
=====
```sh
DRONE_RUNNER_CAPACITY=4 # Allow only 4 jobs at one time
```

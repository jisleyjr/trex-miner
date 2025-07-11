# Trex Miner

The idea here to create an image for mining with T-rex https://github.com/trexminer/T-Rex.

Execute `build.sh` to build the image.

Start up the container with:

``` bash
docker run --name trex-test \
  -it --rm \
  --runtime=nvidia --gpus all \
  -p 127.0.0.1:34067:4067/tcp \
  -e ALGO=kawpow \
  -e URL=stratum+tcp://stratum.ravenminer.com:3838 \
  -e USER=<replace-with-address> \
  jisleyjr/trex-miner:latest
```
The password for the WebUI is `Password1`.
# pi-livestream
Docker template to do live streaming on the RPi using mjpg-streamer

## Usage

```sh
cd pi-livestream/
docker build . -t xezpeleta/pilivestream
docker run --name pizerolive --rm --privileged --cap-add=ALL -it -v /dev:/dev -v /lib/modules:/lib/modules -p 80:80 xezpeleta/pilivestream
```

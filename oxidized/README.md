
git clone https://github.com/ytti/oxidized.git

docker build -t oxidized/oxidized:latest oxidized/

mkdir etc/oxidized

# add a router entry to the router.db file 
echo "34.217.43.27:cisco:interop:interop19" >> /docker/oxidized/etc/oxidized/router.db
#vi /docker/oxidized/etc/oxidized/config
# make mods to config file
sed -i -e 's/^interval: [0-9]*/interval: 60/' etc/oxidized/config
sed -i -e 's/^rest: 127.0.0.1:8888/rest: 0.0.0.0:8888/' etc/oxidized/config

docker run --rm --name="oxidized" -v /docker/oxidized/etc/oxidized:/root/.config/oxidized -p 144.92.67.155:8888:8888/tcp -t oxidized/oxidized:latest oxidized

APP=zeronet
VERSION='0.0.0'
RELEASE='1'
ARCH_TYPE='all'
PREFIX?=/opt

all:
debug:
sync:
	./upstream-to-debian.sh
source:
	tar -cvf ../${APP}_${VERSION}.orig.tar ../${APP}-${VERSION} --exclude-vcs --exclude=ZeroNet
	gzip -f9n ../${APP}_${VERSION}.orig.tar
install:
	mkdir -m 755 -p ${DESTDIR}${PREFIX}/${APP}
	cp -r src/* ${DESTDIR}${PREFIX}/${APP}
	cp daemons/*.service /etc/systemd/system
uninstall:
	rm -rf ${PREFIX}/${APP}
    rm /etc/systemd/system/tracker.service
clean:
	rm -f \#* \.#* debian/*.substvars debian/*.log
	rm -rf deb.* debian/${APP}
	rm -f ../${APP}*.deb ../${APP}*.changes ../${APP}*.asc ../${APP}*.dsc

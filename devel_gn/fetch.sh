files="Makefile
pkg-descr
distinfo"

for f in $files
do
	fetch -o $f "https://svnweb.freebsd.org/ports/head/devel/gn/$f?revision=526938&view=co&pathrev=526938"
done


mkdir files
fetch -o files/patch-build_gen.py 'https://svnweb.freebsd.org/ports/head/devel/gn/files/patch-build_gen.py?revision=526938&view=co&pathrev=526938'

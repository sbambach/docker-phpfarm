#
# Post-build and install script for PHP 5.1.6.
#

# PHP 5.1.6 sources.
srcDir='/phpfarm/src/php-5.1.6'

# PHP 5.1.6 binary executables.
binDir='/phpfarm/inst/php-5.1.6/bin'

# Move the executables to the correct places.
cp $srcDir/sapi/cgi/php /phpfarm/inst/php-5.1.6/bin/php-cgi
cp $srcDir/sapi/cli/php /phpfarm/inst/php-5.1.6/bin/php

# Create links in shared bin dir.
ln -fs $binDir/php-cgi /phpfarm/inst/bin/php-cgi-5.1.6
ln -fs $binDir/php-config /phpfarm/inst/bin/php-config-5.1.6
ln -fs $binDir/phpize /phpfarm/inst/bin/phpize-5.1.6

# Compile MySQLi extension using workaround, as compiling PHP using
# --with-mysqli breaks.
cd $srcDir/ext/mysqli
$binDir/phpize
./configure --with-php-config=$binDir/php-config --with-mysqli=/usr/bin/mysql_config
make

# Move compiled extension to extension dir.
cp modules/mysqli.so /phpfarm/inst/php-5.1.6/lib/

# Load extension in php.ini.
echo 'zend_extension = /phpfarm/inst/php-5.1.6/lib/mysqli.so' >> /phpfarm/inst/php-5.1.6/lib/php.ini


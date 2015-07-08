class zend_server () {


# Adding repos to the source:

exec {'sources.list':
	command => 'echo deb http://repos.zend.com/zend-server/8.0/deb_ssl1.0 server non-free\ >> /etc/apt/sources.list',
	path => '/bin',
	logoutput => true,
	before => Exec ['key'],
	}
	
# Adding key to repo for package verification:

exec {'key':
	command => 'wget http://repos.zend.com/zend.key -O- | apt-key add -',
	path => ['/bin', '/usr/bin'],
	}	

# Updating apt-get:

exec {'apt-get update':
	command => 'sudo apt-get update',
	path => ['/bin', '/usr/bin'],
	require => Exec['key']
	}

# Installing zend-server-php-5.6:

package {'zend-server-php-5.6':
	ensure => 'installed',
	require => Exec['sources.list'],
	}	
	
	
}

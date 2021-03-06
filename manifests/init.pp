#######################################
# dhcpd module
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
#######################################

class dhcpd {
    case $operatingsystem {
        centos: { include dhcpd::centos }
        default: { include dhcpd::base }
    }
}

class dhcpd::base {
    package{'dhcp':
        ensure => present,
    }

    service{'dhcpd':
        ensure => running,
        enable => true,
        hasstatus => true,
        require => [ Package[dhcp], File['/etc/dhcpd.conf'] ],
    }

    file{'/etc/dhcpd.conf':
        source =>  [ "puppet://$server/files/dhcpd/${fqdn}/dhcpd.conf",
                    "puppet://$server/dhcpd/dhcpd.conf" ],
        require => Package[dhcp],
        notify => Service['dhcpd'],
        owner => root, group => 0, mode => '0644';
    }
}

class dhcpd::centos inherits dhcpd::base {
    file{'/etc/sysconfig/dhcpd':
        source => [ "puppet://$server/files/dhcpd/sysconfig/${fqdn}/dhcpd",
                    "puppet://$server/dhcpd/sysconfig/dhcpd" ],
        require => Package[dhcp],
        notify => Service['dhcpd'],
        owner => root, group => 0, mode => '0644';
    }

    Service[dhcpd]{
        require +> File['/etc/sysconfig/dhcpd'],
    } 
}

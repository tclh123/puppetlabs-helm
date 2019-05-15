class helm::charts {
}

class helm::charts::basedir {
    file { '/etc/helm':
        ensure => directory,
        owner  => sysadmin,
        group  => sysadmin,
    }
}

define helm::charts::douban {
    include helm::charts::basedir

    file { "/etc/helm/$name.values.yaml":
        mode   => '0640',
        owner  => sysadmin,
        group  => sysadmin,
        source => "puppet:///modules/helm/charts/douban/$name.values.yaml",
    } ~>

    helm::chart_update { "$name":
        ensure       => 'present',
        chart        => "douban/$name",
        release_name => "$name",
        namespace    => "$name",
        values       => ["/etc/helm/$name.values.yaml"],
        refreshonly  => true,
    }

}

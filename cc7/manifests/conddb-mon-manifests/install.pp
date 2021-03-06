# This puppet manifest collection is installing OMD and make
# necessarry changes to fix known issues running it on CentOS 7.
# Required puppet modules are marked in dependencies.pp.
#
# install.pp: It installs the OMD package and the Check_MK agent.
#             After these packages are installed, it restores the previous 
#             state of prod, based on the fetched backup tarballs.
#             Finally it starts the restored site.

package { "${omdPackage}":
  ensure  => installed,
}

package { "check-mk-agent":
  ensure  => installed,
  require => Package["${omdPackage}"]
}

# hotfix for hashlib version clash:
file { '/opt/omd/versions/1.30/lib/python/hashlib.py':
  source  => '/usr/lib64/python2.7/hashlib.py',
  owner   => 'root',
  group   => 'root',
  require => Package["${omdPackage}"]
}

#########################################
#  Restore Check_MK local from tarball. #
#########################################
exec {
  "chmk_backup_extract":
    cwd     => "/root",
    command => "/usr/bin/tar -xvzf /root/${chmkBackupName}",
    #creates => "/tmp/local", #"/usr/share/check-mk-agent/",
    require => [ Package["check-mk-agent"], Package["${omdPackage}"] ];

  "chmk_backup_copy":
    cwd     => "/root",
    command => "/usr/bin/cp /root/local/* /usr/share/check-mk-agent/local/",
    require => Exec["chmk_backup_extract"];
}

#########################################
#  Restore prod from backup tarball.    #
#########################################
exec {
  "prod_check":
    cwd     => "/root",
    command => "/usr/bin/echo Prod is up and running.",
    onlyif  => "/usr/bin/omd status prod",
    require => Exec["chmk_backup_copy"];

  "prod_restore":
    cwd     => "/root",
    command => "/usr/bin/omd start prod",
    onlyif  => "/usr/bin/omd restore prod /root/${prodBackupName}",
    require => Exec["prod_check"];
}


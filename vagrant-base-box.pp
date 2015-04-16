package {
	['sudo', 'tmux', 'git', 'puppet', 'chef', 'apt-transport-https']:
		ensure => present;
	'nano':
		ensure => absent;
}
case $lsbdistcodename {
	/^(wheezy)$/: {
		package {
			['ruby-hiera-puppet']:
				ensure => present;
		}
	}
}

group {
	'admin':
		ensure => present;
}

user {
	'vagrant':
		ensure     => present,
		managehome => false,
		groups     => ['cdrom', 'floppy', 'audio', 'dip', 'video', 'plugdev', 'admin'],
		require    => Group['admin'];
}

file {
	'/etc/sudoers.d/vagrant':
		ensure  => present,
		content => "%admin ALL=(ALL:ALL) NOPASSWD: ALL\nDefaults:vagrant !requiretty\nDefaults env_keep += \"SSH_AUTH_SOCK\"\n",
		owner   => 'root',
		group   => 'root',
		mode    => 0440,
		require => Package['sudo'];
}

ssh_authorized_key {
	'vagrant':
		ensure => present,
		key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ==',
		type   => 'ssh-rsa',
		user   => 'vagrant',
		name   => 'vagrant insecure public key';
}

augeas {
	"no-dns-in-ssh":
		context => "/files/etc/ssh/sshd_config",
		changes => [
			"set UseDNS no",
		],
}

service {
	'chef-client':
		ensure  => stopped,
		enable  => false,
		require => Package['chef'];
}

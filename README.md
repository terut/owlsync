# Owlsync: The Mirroring Daemon for Auto Scaling
## Description
Owlsync is an easy configure, easy to rsync source written in Ruby.

Auto scaling means the cloud's function that servers increase or decrease automatic. (ec2 etc.)
The ways that keep latest source are git pull(clone), rsync.

This daemon observe servers, and mirroring latest source if server increase.

Now, EC2 only..

## Getting Started

Owlsync is very very easy cofigure. Almost everything you need already finish when you installed Owlsync.

First, make directory for owlsync and edit Gemfile.

    $ mkdir rsync
    $ cd rsync
    $ bundle init
    $ vim Gemfile

Second, add `owlsync`.

```ruby
gem 'owlsync', git: 'git://github.com/terut/owlsync.git'
```

Third, install owlsync by bundler and prepare config file.

    $ bundle install --vendor/bundle
    $ mkdir config
    $ vim config/owlsync.rb

About `config/owlsync.rb`, you should read configuration.

    $ bundle exec owlsync start
    $ bundle exec owlsync stop

There are log and pid file at `pids` directory.

## Configuration

Owlsync support AWS EC2, so you must setting EC2's access_key_id, secret_access_key etc.

For example, `config/owlsync.rb` is following:

```ruby
Owlsync.configure do |config|
  config.ssh_key = '/Users/terut/.ssh/id_rsa'
  config.rsync_options = '-avz --delete'
  config.source_path = "/Users/terut/source/app/"
  config.release_path = "/data/www/htdocs/test"
  config.worker_type = :ec2
  config.worker_options= { access_key_id: 'ACCESS_KEY_ID',
                           secret_access_key: 'SECRET_ACCESS_KEY',
                           ec2_endpoint: 'ec2.us-east-1.amazonaws.com',
                           tag: { key: 'Name', value: 'foobar' } }
end
```

EC2:

- `ssh_key` - identityfile.
- `ssh_user` - ssh user name.
- `rsync_options` - rsync options.
- `source_path` - source directory for mirroring.
- `release_path` - distribution directory for mirroring.
- `worker_type` - *:ec2*
- `worker_options` - *:access_key_id*, *:secret_access_key*, *:ec2_endpoint*, *:tag*

`:tag` - autoscaling tag key and value. For example, ec2 stratery search *aws:autoscaling:groupName* key.

FIXED:

- `worker_type` - *:fixed*
- `worker_options` - *:servers*

`:servers` - { app1: 'fixed-server-www1' }

## License
See LICENSE file.

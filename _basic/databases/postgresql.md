---
title: Using PostgreSQL In CI/CD with CodeShip Basic
shortTitle: PostgreSQL
tags:
  - services
  - databases
  - postgresql
  - postgres
  - psql
  - pg
  - db
menus:
  basic/db:
    title: PostgreSQL
    weight: 2
redirect_from:
  - /databases/postgresql/
  - /classic/getting-started/postgresql/
categories:
  - Databases
---

* include a table of contents
{:toc}

PostgreSQL `10` runs on the default port and the credentials are stored in the `PGUSER` and `PGPASSWORD` environment variables. The default databases created for you are **development** and **test**.

We install the Ubuntu `postgresql-contrib` package. It includes the [extension modules](https://www.postgresql.org/docs/10/static/contrib.html) listed in the PostgreSQL documentation.

You need to activate them with `CREATE EXTENSION` as explained in the [Extension Guide](https://www.postgresql.org/docs/10/static/sql-createextension.html).

## Versions

### 12

PostgreSQL version **12** is running on port `5434` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

{% csnote info %}
PostgreSQL 12 includes PostGIS version 3.0.
{% endcsnote %}

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5434|" "config/database.yml"
```

### 11

PostgreSQL version **11** is running on port `5433` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

{% csnote info %}
PostgreSQL 11 includes PostGIS version 2.5.
{% endcsnote %}

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5433|" "config/database.yml"
```

### 10

The **default version** of PostgreSQL on CodeShip is **10**, which runs on the default port of `5432`. No additional configuration is required to use version 10.

{% csnote info %}
PostgreSQL 10 includes PostGIS version 2.5.
{% endcsnote %}

### 9.6

PostgreSQL version **9.6** is running on port `5436` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

{% csnote info %}
PostgreSQL 9.6 includes PostGIS version 2.5.
{% endcsnote %}

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5436|" "config/database.yml"
```

### 9.5

PostgreSQL version **9.5** is running on port `5435` and configured (almost) identical to the others. Make sure to specify the correct port in your project configuration if you want to test against this version.

{% csnote info %}
PostgreSQL 9.5 includes PostGIS version 2.5.
{% endcsnote %}

For Rails based projects, please add the following command to your _Setup Commands_ to work around the auto-configuration in place.

```shell
sed -i "s|5432|5435|" "config/database.yml"
```

### pg_dump
You may experience a `pg_dump` version mismatch with the PostgreSQL version you have configured.

```
pg_dump: server version: $YOUR_VERSION; pg_dump version: 9.2.19
pg_dump: aborting because of server version mismatch
```

This can be resolved by adding the following command in your _Setup Commands_ before running your migrations:

```shell
export PATH=/usr/lib/postgresql/<PG_VERSION>/bin/:$PATH
```

## Run psql commands
You can run any SQL query against the PostgreSQL database. For example to create a new database:

```shell
psql -p DATABASE_PORT -c 'create database new_db;'
```

## Enable Extensions
You can enable extensions either through your application framework (if supported) or by running commands directly against the database. For example, you would add the following command to your _Setup Commands_ to enable the `hstore` extension.

```shell
psql -d DATABASE_NAME -p DATABASE_PORT -c 'create extension if not exists hstore;'
```

### PostGIS
All PostgreSQL versions include [PostGIS](http://postgis.net) 2.5, except 12 which includes 3.0.

To use PostGIS, enable the extension and optionally verify the version.

```shell
psql -p DATABASE_PORT -c 'create extension postgis;'
psql -p DATABASE_PORT -c 'select PostGIS_Version();'
```

## Framework-specific configuration

### Ruby on Rails
We replace the values in your `config/database.yml` file automatically to a configuration matching the PostgreSQL 10 instance.

If your Rails application is stored in a subdirectory or you want to change the database configuration from our default values, you can add the following data to a `codeship.database.yml` file (or any other filename) and commit that file to your repository.

```yaml
development:
  adapter: postgresql
  host: localhost
  encoding: unicode
  pool: 10
  username: <%= ENV['PGUSER'] %>
  template: template1
  password: <%= ENV['PGPASSWORD'] %>
  database: development<%= ENV['TEST_ENV_NUMBER'] %>
  port: 5432
  sslmode: disable
test:
  adapter: postgresql
  host: localhost
  encoding: unicode
  pool: 10
  username: <%= ENV['PG_USER'] %>
  template: template1
  password: <%= ENV['PG_PASSWORD'] %>
  database: test<%= ENV['TEST_ENV_NUMBER'] %>
  port: 5432
  sslmode: disable
```

In your _Setup Commands_, run the following command to copy the file to its target location.

```shell
cp codeship.database.yml YOUR_DATABASE_YAML_PATH
```

If you don't use Rails and load `database.yml` yourself you might see an error like the following instead of the value of the environment variable:

```
PSQL::Error: Access denied for user '<%= ENV['PGUSER'] %>'@'localhost'
```

This is because the `database.yml` example includes ERB syntax. You need to load `database.yml` and run it through ERB before you can use it:

```ruby
require "erb"
require "yaml"

DATABASE_CONFIG = YAML.load(ERB.new(File.read("config/database.yml")).result)
```

### Django
You can use the following database configuration for Django based projects.

```python
DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': 'test',
    'USER': os.environ.get('PGUSER'),
    'PASSWORD': os.environ.get('PGPASSWORD'),
    'HOST': '127.0.0.1',
  }
}
```

## Notes And Known Issues

### Python and earlier Psycopg versions
Earlier versions of [Python PostgreSQL client Psycopg](http://initd.org/psycopg) may not work with version 10. These older versions used a string-comparison to try and work out the PostgreSQL version number and didn't account for version 10. To resolve this issue, upgrade `psycopg2` to version 2.7 or higher.

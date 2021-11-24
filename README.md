## dbt-docker-m1

Running [`dbt`](https://github.com/dbt-labs/dbt-core) in a docker container on an M1 chip.

> Note: since this is basically building an amd64 image (on an arm machine) that we run on
> said arm machine via [QEMU emulation](https://www.docker.com/blog/multi-platform-docker-builds/)
> there may be performance penalties. Thus, it is only for those who are TRULLY desperate in running
> dbt cli on their local M1 Apple Macs and are running into issues installing dbt normally.

1. Build our container.

```sh
git clone https://github.com/jeremyyeo/dbt-docker-m1.git
cd dbt-docker-m1
docker build -t dbt-app . --platform linux/amd64
```

2. Check installed dbt adapters.

```sh
docker run --rm -it dbt-app dbt --version
```

```
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
installed version: 0.21.0
   latest version: 0.21.0
Up to date!
Plugins:
  - redshift: 0.21.0
  - postgres: 0.21.0
  - snowflake: 0.21.0
  - bigquery: 0.21.0
```

3. Run dbt commands.

   > Initialize our test project, copy packages.yml file, test downloading dbt packages.

```sh
docker run --rm -it -v $PWD:/dbt dbt-app dbt init .my_new_project &&
    cp packages.yml .my_new_project/ &&
    docker run --rm -it -v $PWD/.my_new_project:/dbt dbt-app dbt deps
```

```sh
...
Running with dbt=0.21.0
No profile "default" found, continuing with no target
Installing dbt-labs/dbt_utils@0.7.4
  Installed from version 0.7.4
  Up to date!
```

### Tested on

```sh
$ sw_vers
ProductName: macOS
ProductVersion: 12.0.1
BuildVersion: 21A559

$ system_profiler SPHardwareDataType
Hardware:

    Hardware Overview:

      Model Name: MacBook Pro
      Model Identifier: MacBookPro17,1
      Chip: Apple M1
      Total Number of Cores: 8 (4 performance and 4 efficiency)
      Memory: 16 GB

$ docker --version
Docker version 20.10.10, build b485636
```

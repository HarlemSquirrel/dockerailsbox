# DockeRailsBox

A sample [Rails](http://rubyonrails.org/) 4 application running on [TorqueBox](http://torquebox.org) 3.2.0 in an [Ubuntu Xenial Docker](https://hub.docker.com/_/ubuntu/) container

## Building and running

```sh
$ docker build -t dockerailsbox .
$ docker run -it --rm -p 8080:8080 -p 9990:9990 --name drb dockerailsbox
```

### Stop the docker containers by name

```sh
docker stop drb
```

### Stop all docker containers with

```sh
docker stop $(docker ps -a -q)
```

## Resources

- https://hub.docker.com/r/jboss/torquebox/
- http://torquebox.org/getting-started/3.2.0/first-steps.html
- https://hub.docker.com/_/ubuntu/

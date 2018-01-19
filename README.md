# Rancher - pemdump
Very crude container to create a pem file out of certificates stored in rancher.
The container does no error checking.

Since there is no easy way to get a pem out of the certificate store in rancher, this container can accomplish it.

The idea is to use for example ranchers letsencrypt container to create the certificate and then use the resulting certificate in your mail server or jabber server, which not always support being behind a loadbalancer.

## Build container

Build this container and push it to a repository of your liking.

## Volumes + Environment Variables

You need to specify the name of the certificate in the Certificate store via the ``CERT_NAME`` Env variable
The container automatically writes the resulting pem file to: ``/opt/certs/CERT_NAME.pem``, so you can use host mapping of the ``/opt/certs`` directory to use the resulting pem in another container.

## Important notes

As you can see in the docker-compose.yml example, it is required to set the following labels:

      io.rancher.container.agent.role: environmentAdmin
      io.rancher.container.create_agent: 'true'

Also at least till rancher 1.6.14 you ALSO NEED the container to be in a system stack.
You can set a stack to be a system stack via "View in API" and then edit and check the "system" flag.

## Install in rancher

Sample docker-compose.yml

    version: '2'
    services:
      jabber-pemdump:
        image: MYREPOSITORY/pemdump
        environment:
          CERT_NAME: jabber-mydomain
        stdin_open: true
        volumes:
        - /opt/jabber/ejabberd/ssl:/opt/certs
        tty: true
        labels:
          io.rancher.container.agent.role: environmentAdmin
          io.rancher.container.create_agent: 'true'
          io.rancher.container.pull_image: always




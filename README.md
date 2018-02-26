## Usage

To create the image `your-login/your-new-image`, execute the following command on the root folder where the Dockerfile lies:

```shell
docker build -t your-login/your-new-image .
```

You can then push your new image to the Docker servers (A.K.A. registry):

```shell
docker push your-login/your-new-image
```

## Running your tomcat-mysql docker image

Start your image binding the external ports 8080:

```shell
docker run --name TomcatServerOrWhatever -d -p 8080:8080 your-login/your-new-image
```

If you want to expose also the mysql, do:

```shell
docker run --name TomcatServerOrWhatever -d -p 8080:8080 -p 3306:3306 your-login/your-new-image
```

Copy the WAR file representing your application to `/opt/apache-tomcat-8.0.50/webapps/` folder:

```shell
docker exec TomcatServerOrWhatever cp yourapp.war /opt/apache-tomcat-8.0.50/webapps/yourapp.war
```
or set in the root:

```shell
docker exec TomcatServerOrWhatever cp ROOT.war /opt/apache-tomcat-8.0.50/webapps/ROOT.war
```

(this will overwrite the tomcat manager, so use it wisely)

That's all folks!

## Characteristics of this image

 - Ubuntu - latest
 - Oracle Java 8
 - MySQL 5.7
 - Tomcat 8.0.50
 - Run with jdpa for debug

## Connecting to the bundled MySQL server from outside the container

The first time that you run the container, a new user `admin` with all privileges
will be created in MySQL with a random password. To get the password, check the logs
of the container by running:

```shell
docker logs $CONTAINER_ID
```

You will see an output like the following:

```shell
========================================================================
You can now connect to this MySQL Server using:

    mysql -uadmin -p47nnf4FweaKu -h<host> -P<port>

Please remember to change the above password as soon as possible!
MySQL user 'root' has no password but only allows local connections
========================================================================
```

In this case, `47nnf4FweaKu` is the password allocated to the `admin` user.

You can then connect to MySQL:

```shell
mysql -uadmin -p47nnf4FweaKu
```

Remember that the `root` user does not allow connections from outside the container -
you should use this `admin` user instead!


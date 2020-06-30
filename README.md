# TiddlyWiki Docker

This is a docker image for [TiddlyWiki](https://tiddlywiki.com/).

## Tags

Starting with TiddlyWiki version `5.1.22` there will be a new tag for each TiddlyWiki release.

## Usage

The recommended way would be to use the `docker-compose.yml` file located in this [repository](https://github.com/kuzi-moto/tiddlywiki-docker). Clone the repository, enter it, then run `docker compose up -d`. If you want to test it out quickly, use the following:

```BASH
docker run -p 8080:8080 kuzimoto/tiddlywiki
```

**Warning**: The default configuration of this image is insecure. It is accessible to the world, and readable/writeable by anyone. If this isn't what you want, set ``TW_HOST`` to **127.0.0.1**, using instructions below.

## Additional Information

### Building Image

To build this image, clone the repository, enter it, and build:

```BASH
git clone https://github.com/kuzi-moto/tiddlywiki-docker.git
cd tiddlywiki-docker/
docker build -t kuzimoto/tiddlywiki .
```

You can modify the version of TiddlyWiki installed by supplying `TW_VERSION` as an argument:

```BASH
docker build --build-arg TW_VERSION=5.1.21 -t kuzimoto/tiddlywiki .
```

### Environment Variables

This image supports using environment variables to modify some of the TiddlyWiki server behavior. Here are the variables with their default values:

* TW_HOST=0.0.0.0
* TW_PATH_PREFIX=
* TW_USERNAME=
* TW_PASSWORD=
* TW_AUTHENTICATED_USER_HEADER=
* TW_READERS=
* TW_WRITERS=
* TW_DEBUG_LEVEL=none

An explanation of how these work can be found on the [TiddlyWiki Website](https://tiddlywiki.com/#ListenCommand). Not all of the parameters have been added yet, just those listed above.

To modify a value using Docker Compose, add an environment section:

```YML
services:
  tiddlywiki:
    image: kuzimoto/tiddlywiki
    ports:
      - "8080:8080"
    environment:
      TW_USERNAME: "admin"
      TW_PASSWORD: "password"
```

Or with docker run:

```BASH
docker run -p 8080:8080 -e "TW_USERNAME=admin" -e "TW_PASSWORD=password" kuzimoto/tiddlywiki
```

Doing this will add authentication to your wiki, with **admin** as the username, and **password** as your password.

### Adding Plugins

Unfortunately at this time there doesn't appear to be a convenient way to add additional plugins when using TiddlyWiki as a server. To add plugins you need to stop the TiddlyWiki container, then edit the `tiddlywiki.info` file.

To find the .info file, run the following command to view information about the container to see where data is stored (make sure to replace **tiddlywiki** with the name of your container):

```BASH
docker container inspect tiddlywiki
```

The **Source** key under **Mounts** will tell you the path of the volume:

```JSON
"Mounts": [
            {
                "Type": "volume",
                "Name": "wiki_data",
                "Source": "/var/lib/docker/volumes/wiki_data/_data",
                "Destination": "/wiki",
                "Driver": "local",
                "Mode": "rw",
                "RW": true,
                "Propagation": ""
            }
        ],
```

From here you can use **vim** or **nano** to edit the `tiddlywiki.info` file.

```BASH
vim /var/lib/docker/volumes/wiki_data/_data/tiddlywiki.info
```

A list of official plugins can be found [here](https://tiddlywiki.com/#OfficialPlugins). To add a plugin, simply add an entry under the **plugins** section making sure to add a '`,`' at the end of the previous entry:

```JSON
"plugins": [
        "tiddlywiki/filesystem",
        "tiddlywiki/tiddlyweb",
        "tiddlywiki/markdown"
    ],
```

Save the file, then re-start the container.

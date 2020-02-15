# Short Links

This is a small simple app to share shorter urls

## Installation

This app can be installed through Dockerfile. Just generate a container and run it at your host.
For example:
```
$ docker build -t short-links .
...
$ docker run -p $YOUR_PORT_HERE:5000 short-links
```

## API Documentation

Documentation for this API placed at `/swagger/docs` path.
It returns JSON, so if you prefer inspect it at a pretty UI interface, visit http://petstore.swagger.io/ and enter your url documentation root in the url field.

This repo contains util script to manage Docker containers and images

# Cleaning Containers

The valid arguments to invoke this shell script are:

  - [-d|--debug]: Prints commands in the output instead of executing it.
  - [-h|--help]: Prints this usage message
  - [-w|--when PATTERN]: Define the time range to delete the containers. If no value is set '2 weeks' will be used
  - [-x|--excluded CONTAINER NAME]: Define which container name should be excluded from deletion. By default, registry will be never deleted

An example of its usage:
```
  ./cleanup-containers.sh -w "2 weeks"
```
which will remove all containers that are in status `Exited` since `2 weeks`, excluding `registry`, which is the default value for exclusions.

# Cleaning Images

The valid arguments to invoke this shell script are:

  - [-d|--debug]: Prints commands in the output instead of executing it.
  - [-h|--help]: Prints this usage message
  - [-i|--image IMAGE NAME]: Define which image names and tags should be deleted
  - [-w|--when PATTERN]: Define the time range to delete the images. If no value is set '2 weeks' will be used

An example of its usage:
```
  ./cleanup-images.sh -i my-custom-image -w "2 weeks"
```
which will remove all images from the `my-custom-image` repository that where created `2 weeks` ago.

## Cleaning orphan images
We call orphan images those that have been renamed to a newer image, leaving the old image in the host with name `<none>` and label `<none>` too.

An example of its usage:
```
  ./cleanup-orphan-images.sh
```
which will remove all images from the `<none>` repository and tag `<none>` too.

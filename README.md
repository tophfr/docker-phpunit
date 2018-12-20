# Docker image for PHPUnit

Cf. https://phpunit.readthedocs.io/

## How to use it

    docker run --rm -it -v "$PWD:$PWD" -w "$PWD" -u "$(id -u):$(id -g)" tophfr/phpunit

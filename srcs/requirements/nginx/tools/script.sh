#!/bin/bash

service nginx start

# Run by dumb-init
nginx -g "daemon off;"

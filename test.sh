#!/bin/sh
## Copyright 2017 Mathieu Parent <math.parent@gmail.com>
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

set -e

family="$1"

. "$PWD/src/families/$family.sh"

if [ ! -f "$dockerfile_path" ]; then
    dockerfile_generate
fi
if [ -z "$docker_tag" ]; then
    echo "ERROR: No tag specified" >&2
    exit 1
fi

if [ -f "spec/families/${family}_spec.rb" ]; then
    rspec -fd -c "spec/families/${family}_spec.rb"
else
    echo "ERROR: File not found: spec/families/${family}_spec.rb" >&2
    exit 1
fi
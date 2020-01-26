#!/bin/bash 

if [ -z "$1" ]
  then
    echo "Docker username needs to be passed!"
    exit
fi

echo "This script will build substrate and substrate-telemetry and will upload it to a public docker registry"

echo "Setting up environment"

curl https://getsubstrate.io -sSf | bash -s -- --fast
source ~/.cargo/env
mkdir -p build build-artefact/substrate build-artefact/substrate-telemetry
cd build 

git clone https://github.com/substrate-developer-hub/substrate-node-template.git
git clone https://github.com/paritytech/substrate-telemetry.git

cd ./substrate-node-template
echo "Building node template. This will take a while..."
cargo build -j32 --release 
cp target/release/node-template ../../build-artefact/substrate/

cd ../substrate-telemetry/
echo "Building telemetry app. This will take a while..."
yarn 
cp -r node_modules scripts packages ../../build-artefact/substrate-telemetry/
cp package.json yarn.lock tsconfig.json ../../build-artefact/substrate-telemetry/
cd backend
cargo build -j32 --release
cp target/release/telemetry ../../../build-artefact/substrate-telemetry/

cd ../../../

echo "Ensure docker is installed and running. Will ask for credentials to login to docker hub and upload the built images"
sudo docker login -u $1

sudo docker build -t substrate -f Dockerfile.substrate .
sudo docker build -t substrate-telemetry -f Dockerfile.substrate-telemetry .

substrate_image_id=$(sudo docker images -f=reference='substrate' | awk 'NR==2{print($3)}')
sudo docker tag $substrate_image_id $1/substrate
sudo docker push $1/substrate

substrate_telemetry_image_id=$(sudo docker images -f=reference='substrate-telemetry' | awk 'NR==2{print($3)}')
sudo docker tag $substrate_telemetry_image_id $1/substrate-telemetry
sudo docker push $1/substrate-telemetry

echo "Done!"
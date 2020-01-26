#!/bin/bash

echo "Please create a service account and run this prior to the script. export GOOGLE_CLOUD_KEYFILE_JSON=<path to json> "

echo "export the google project ID as GCP_PROJECT_ID=<you project id>"

echo "Setting up gcloud sdk"

curl https://sdk.cloud.google.com | bash

cd modules/k8-provision
terraform init
terraform plan -var cluster_name="parity-cluster"  \
  -var location="us-central1-a" \
  -var node_count=2 \
  -var project=$GCP_PROJECT_ID
terraform apply -auto-approve -var cluster_name="parity-cluster"  \
  -var location="us-central1-a" \
  -var node_count=2 \
  -var project=$GCP_PROJECT_ID

cd ../create-namespace
terraform init
terraform plan -var namespace_name="parity"
terraform apply -auto-approve -var namespace_name="parity"

cd ../k8-service
terraform init
terraform plan namespace="parity" \
  -var service_name="substrate-telemetry-service" \
  -var app_name="substrate-telemetry-app" \
  -var ports="[3000, 8000]" 
terraform apply -auto-approve namespace="parity" \
  -var service_name="substrate-telemetry-service" \
  -var app_name="substrate-telemetry-app" \
  -var ports="[3000, 8000]" 

cd ../substrate-telemetry
terraform init
terraform plan -var namespace="parity" \
  -var app_name="substrate-telemetry-app" \
  -var container_image="rezesius/substrate-telemetry" \
  -var front_end_port="3000" \
  -var back_end_ports="[1024, 8080, 8000]"
terraform apply -auto-approve -var namespace="parity" \
  -var app_name="substrate-telemetry-app" \
  -var container_image="rezesius/substrate-telemetry" \
  -var front_end_port="3000" \
  -var back_end_ports="[1024, 8080, 8000]"

cd ../alice-pod
terraform init
terraform plan -var namespace="parity" 
  -var container_image="rezesius/substrate-telemetry" \
  -var port=30333 \
  -var ws_port=9944 \
  -var rpc_port=9933 
terrafotm apply -auto-approve -var container_image="rezesius/substrate-telemetry" \
  -var port=30333 \
  -var ws_port=9944 \
  -var rpc_port=9933 

cd ../substrate
terraform init
terraform plan -var namespace="parity" \
  -var container_image="rezesius/substrate-telemetry" \
  -var port=30333 \
  -var ws_port=9944 \
  -var rpc_port=9933 
terrafotm apply -auto-approve -var container_image="rezesius/substrate-telemetry" \
  -var port=30333 \
  -var ws_port=9944 \
  -var rpc_port=9933 

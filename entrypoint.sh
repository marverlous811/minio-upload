#!/bin/sh -l

export PATH=$PATH:/minio-binaries/

insecure_option=""
if [[ "$YA_INSECURE" == "true" ]]; then
  insecure_option="--insecure"
fi

recursive_option=""
if [[ "$YA_RECURSIVE" == "true" ]]; then
  recursive_option="--recursive"
fi

mc alias set ${insecure_option:+"$insecure_option"} target "$YA_ENDPOINT" "$YA_ACCESS_KEY" "$YA_SECRET_KEY" --api "$YA_SIGNATURE_VERSION" $YA_EXTRA_ARGS

echo $YA_DOWNLOAD
if [[ "$YA_DOWNLOAD" == "true" ]]; then
  echo "Copying target/$2 to $1 (download)"
  mc ${insecure_option:+"$insecure_option"} cp ${recursive_option:+"$recursive_option"} "target/$2" $1
else
  echo "Copying $1 to target/$2 (upload)"
  mc ${insecure_option:+"$insecure_option"} cp ${recursive_option:+"$recursive_option"} $1 "target/$2"
fi
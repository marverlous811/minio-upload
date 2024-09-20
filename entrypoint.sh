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

s3_path_style=""
if [[ "$YA_S3_PATH_STYLE" == "true" ]]; then
  s3_path_style="--path off"
fi

mc alias set ${insecure_option:+"$insecure_option"} target "$YA_ENDPOINT" "$YA_ACCESS_KEY" "$YA_SECRET_KEY" --api "$YA_SIGNATURE_VERSION" ${s3_path_style:+"$s3_path_style"}
mc ${insecure_option:+"$insecure_option"} cp ${recursive_option:+"$recursive_option"} $1 "target/$2"
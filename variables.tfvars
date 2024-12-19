# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# AWS Control Tower Controls (sometimes called Guardrails) Example Configuration

controls = [
  {
    control_names = [
      "503uicglhjkokaajywfpt6ros", # AWS-GR_ENCRYPTED_VOLUMES
      "2j9gjxqfo040xtx8kd1jf4ni6", # AWS-GR_EBS_OPTIMIZED_INSTANCE
      "8c3i4catfgmyy1e19476v06rr", # AWS-GR_EC2_VOLUME_INUSE_CHECK
      "4jc77cq1lcr7g64xywwypykv8", # AWS-GR_RDS_INSTANCE_PUBLIC_ACCESS_CHECK
      "1h4eyqyyonp19dlrreqf1i3w0", # AWS-GR_RDS_SNAPSHOTS_PUBLIC_PROHIBITED
      "e34kieahgkm0lggs5g0s412jt", # AWS-GR_RDS_STORAGE_ENCRYPTED
      "df2ta5ytg2zatj1q7y5e09u32", # AWS-GR_RESTRICTED_COMMON_PORTS
      "6rilu41n0gb9w6mxrkyewoer4", # AWS-GR_RESTRICTED_SSH
      "5kvme4m5d2b4d7if2fs5yg2ui", # AWS-GR_RESTRICT_ROOT_USER
      "8ui9y3oace2513xarz8aqojl7", # AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS
      "24izmu4k16gv9tvd7sexnyrfy", # AWS-GR_ROOT_ACCOUNT_MFA_ENABLED
      "8sw3pbid15t9cbww8d2w2qwgf", # AWS-GR_S3_BUCKET_PUBLIC_READ_PROHIBITED
      "9j9nwxj789d82sypnukhyyowy", # AWS-GR_S3_BUCKET_PUBLIC_WRITE_PROHIBITED
    ],
    organizational_unit_ids = ["ou-1111-11111111", "ou-2222-22222222"],
  },
  {
    control_names = [
      "50z1ot237wl8u1lv5ufau6qqo", # AWS-GR_SUBNET_AUTO_ASSIGN_PUBLIC_IP_DISABLED
      "aemn4s3hxv9erree434pvjboi", # AWS-GR_AUTOSCALING_LAUNCH_CONFIG_PUBLIC_IP_DISABLED
      "dvuaav61i5cnfazfelmvn9m6k", # AWS-GR_DISALLOW_CROSS_REGION_NETWORKING
      "41ngl8m5c4eb1myoz0t707n7h", # AWS-GR_DISALLOW_VPC_INTERNET_ACCESS
      "5rlqt6yj6u0v0gb62pqdy4ae",  # AWS-GR_DISALLOW_VPN_CONNECTIONS
      "dekrrxbiux86m6jdowdsbamze", # AWS-GR_DMS_REPLICATION_NOT_PUBLIC
      "87qo8rsoettjrxjevmjqcw1tu", # AWS-GR_EBS_SNAPSHOT_PUBLIC_RESTORABLE_CHECK
      "4v7xtm83uvvyulk1wwpm4qm3s", # AWS-GR_EC2_INSTANCE_NO_PUBLIC_IP
      "aeellyghb27pbehyzua1nyena", # AWS-GR_EKS_ENDPOINT_NO_PUBLIC_ACCESS
      "2civrte1w8tqff4vbtzdl4abq", # AWS-GR_ELASTICSEARCH_IN_VPC_ONLY
      "5cnql6so7p7bs0khdjodjr9e2", # AWS-GR_EMR_MASTER_NO_PUBLIC_IP
      "b2gzofz99eb7nsuj5g8wcimse", # AWS-GR_LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED
      "b8pjfqosgkgknznstduvel4rh", # AWS-GR_NO_UNRESTRICTED_ROUTE_TO_IGW
      "1oxkwnc4hwhi2ndv6ekwy7np7", # AWS-GR_REDSHIFT_CLUSTER_PUBLIC_ACCESS_CHECK
      "6wmutsohbkwhfw6sf7cbt5e81", # AWS-GR_S3_ACCOUNT_LEVEL_PUBLIC_ACCESS_BLOCKS_PERIODIC
      "66gfl06uj1v999z53szvu0exa", # AWS-GR_SAGEMAKER_NOTEBOOK_NO_DIRECT_INTERNET_ACCESS
      "dfanrd8y5p7oj8fjyugqnakfr", # AWS-GR_SSM_DOCUMENT_NOT_PUBLIC
    ],
    organizational_unit_ids = ["ou-1111-11111111"],
  },
]

#! /bin/bash


hostedzones=$(aws route53 list-hosted-zones | jq -r ".HostedZones | .[] | [.Name,.Id] | @csv")
for zone in $hostedzones
do
	name=$(echo $zone | cut -d"," -f1 | tr -d '"')
	id=$(echo $zone | cut -d"," -f2 | tr -d '"')
	aws route53 list-resource-record-sets  --hosted-zone-id $id | tee ${name}json
done

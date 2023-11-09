function switch_aws_config()
{
	AWS_CONFIG_PATH="$HOME/.aws"
	AWS_CONFIG_FILE="$AWS_CONFIG_PATH/config"
	AWS_CREDENTIALS_FILE="$AWS_CONFIG_PATH/credentials"
	[ -f "$AWS_CONFIG_FILE" ] && unlink "$AWS_CONFIG_FILE"
	[ -f "$AWS_CREDENTIALS_FILE" ] && unlink "$AWS_CREDENTIALS_FILE"
	
	CUSTOM_AWS_CONFIG_PATH="$AWS_CONFIG_PATH/$1"
	CUSTOM_AWS_CONFIG_FILE="$CUSTOM_AWS_CONFIG_PATH/config"
	CUSTOM_AWS_CREDENTIALS_FILE="$CUSTOM_AWS_CONFIG_PATH/credentials"
	ln -s $CUSTOM_AWS_CONFIG_FILE $AWS_CONFIG_FILE
	ln -s $CUSTOM_AWS_CREDENTIALS_FILE $AWS_CREDENTIALS_FILE
}

function start_vpn_gitlab()
{
	VPN_INSTANCE_ID=$(aws --profile akiros-corporate-production ec2 describe-instances --filters "Name=tag:Name,Values=vpn" --query "Reservations[*].Instances[*].InstanceId" --output text)
	GITLAB_INSTANCE_ID=$(aws --profile akiros-corporate-production ec2 describe-instances --filters "Name=tag:Name,Values=gitlab" --query "Reservations[*].Instances[*].InstanceId" --output text)
	aws --profile akiros-corporate-production ec2 start-instances --instance-ids $VPN_INSTANCE_ID $GITLAB_INSTANCE_ID
}
function stop_vpn_gitlab()
{
	VPN_INSTANCE_ID=$(aws --profile akiros-corporate-production ec2 describe-instances --filters "Name=tag:Name,Values=vpn" --query "Reservations[*].Instances[*].InstanceId" --output text)
	GITLAB_INSTANCE_ID=$(aws --profile akiros-corporate-production ec2 describe-instances --filters "Name=tag:Name,Values=gitlab" --query "Reservations[*].Instances[*].InstanceId" --output text)
	aws --profile akiros-corporate-production ec2 stop-instances --instance-ids $VPN_INSTANCE_ID $GITLAB_INSTANCE_ID
}

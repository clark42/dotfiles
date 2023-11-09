# SMILE
alias ldap="sudo sshuttle --dns -r jeaeym@ssh.vitry.smile.fr:443 -x 10.10.16.0/20 -x 10.10.32.160/27 172.29.10.0/24 10.1.0.0/11 10.206.0.0/15 195.54.62.139/32 195.54.63.43/32"
alias run_terraform.sh="$HOME/work/akiros/smile/smile-outsourcing/client-architectures/hermes/run_terraform.sh"

function release()
{
	HERMES_BASE_DIR="$HOME/work/akiros/smile/smile-outsourcing/client-architectures/hermes/"
	PROJECT="$( pwd -P | sed "s#$HERMES_BASE_DIR##" | cut -d '/' -f1 )"
	PROJECT_DIR="$HERMES_BASE_DIR/$PROJECT"
	SCRIPT_DIR="$PROJECT_DIR/scripts"
	$SCRIPT_DIR/which_release_on_env.sh $1
}

function deploy_commit()
{
	HERMES_BASE_DIR="$HOME/work/akiros/smile/smile-outsourcing/client-architectures/hermes/"
	PROJECT="$( pwd -P | sed "s#$HERMES_BASE_DIR##" | cut -d '/' -f1 )"
	PROJECT_DIR="$HERMES_BASE_DIR/$PROJECT"
	SCRIPT_DIR="$PROJECT_DIR/scripts"
	$SCRIPT_DIR/deploy_commit.sh $1
}

function tf_plan_release()
{
	HERMES_ENV=${PWD##*/}
	RELEASE_FULL="$( release $HERMES_ENV | grep full | awk '{ print $2 }' )"
	terraform plan -var release=$RELEASE_FULL -out plan.out
}

function redmineIM()
{
	 cd $HOME/work/akiros/smile
	 pipenv run python redmineIM.py $1
	 cd -
}

_sssh()
{
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$(cat ${HOME}/.ssh/config)
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

 _clients()
{
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$(cat ${HOME}/.platformcodes)
    COMPREPLY==( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _sssh sssh
complete -F _sssh s
complete -F _sssh rtget
complete -F _sssh sshsw
complete -F _sssh ping
complete -F _rsync srsync
complete -F _clients rtget

export PATH=$HOME/work/akiros/smile/svn/admsys/trunk/hosting/bin:$PATH
source $HOME/work/akiros/smile/smile-outsourcing/client-architectures/hermes/cli-session-manager/bash_completion

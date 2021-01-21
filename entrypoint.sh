token=${token:-""}
repo=${repo:-""}
name=${name:-""}

while [ $# -gt 0 ]; do
  if [[ $1 == *"--"* ]]; then
    param="${1/--/}"
    declare "$param"="$2"
  fi
  shift
done

export ACCESS_TOKEN=${token}
export REPO_URL=${repo}
export RUNNER_NAME=${name}

cleanup() {
    printf "\nRemoving runner"

    echo "Generating deletion token"
    _TOKEN=$(bash ./token.sh)
    DELETION_TOKEN=$(echo "${_TOKEN}" | jq -r .token)
    ./config.sh remove --token "${DELETION_TOKEN}"
    exit
}

trap cleanup EXIT

echo "Install actions"
bash ./install_actions.sh

echo "Generating token"
_TOKEN=$(bash ./token.sh)
RUNNER_TOKEN=$(echo "${_TOKEN}" | jq -r .token)
_SHORT_URL=$(echo "${_TOKEN}" | jq -r .short_url)

echo "Configuring"
./config.sh \
  --url "${_SHORT_URL}" \
  --token "${RUNNER_TOKEN}" \
  --name "${RUNNER_NAME}" \
  --unattended \
  --replace

echo "Running"
./run.sh

function create-db-branch {
    local DB_NAME=$1
    local BRANCH_NAME=$2
    local ORG_NAME=$3
    local recreate_branch=$4

    # delete the branch if it already exists and recreate branch is set
    if [ -n "$recreate_branch" ]; then
        echo "Trying to delete branch $BRANCH_NAME if it already existed ..."
        pscale branch delete "$DB_NAME" "$BRANCH_NAME" --force --org "$ORG_NAME" 2>/dev/null
    fi

    local raw_output=`pscale branch create "$DB_NAME" "$BRANCH_NAME" --region us-east --org "$ORG_NAME"`
    if [ "$raw_output" == "Error: Name has already been taken" ]; then
        echo "Branch $BRANCH_NAME already exists. Skipping ..."
        exit 0
    fi

    # if branch creation fails, exit with error
    if [ $? -ne 0 ]; then
        echo "Failed to create branch $BRANCH_NAME for database $DB_NAME"
        exit 1
    fi

    wait_for_branch_readiness 10 "$DB_NAME" "$BRANCH_NAME" "$ORG_NAME" 20
    if [ $? -ne 0 ]; then
        echo "Branch $BRANCH_NAME is not ready"
        exit 1
    fi

    local branch_url="https://app.planetscale.com/${ORG_NAME}/${DB_NAME}/${BRANCH_NAME}"
    echo "Branch $BRANCH_NAME is ready at $branch_url"
    # if CI variable ist set, then set output variables
    if [ -n "$CI" ]; then
        echo "::set-output name=BRANCH_URL::$branch_url"
    fi
}

# Function to list Google Cloud projects, allow fuzzy search, and set the selected project
function gcp-project() {
    # Check if gcloud is installed
    if ! command -v gcloud &> /dev/null; then
        echo "gcloud command not found. Please install the Google Cloud SDK."
        return 1
    fi

    # Check if fzf is installed
    if ! command -v fzf &> /dev/null; then
        echo "fzf command not found. Please install fzf."
        return 1
    fi

    if [[ -n "$1" ]]; then
        project_id="$1"
        echo "Using provided project ID: $project_id"
    else
        # Get the list of projects
        projects=$(gcloud projects list --sort-by=name --format="value(projectId,name)")

         # Check if projects were fetched successfully
        if [[ $? -ne 0 ]]; then
            echo "Failed to fetch projects. Please make sure you have the necessary permissions."
            return 1
        fi

         # Use fzf to select a project
        selected=$(echo "$projects" | fzf \
            --delimiter=" " \
            --with-nth=1,2 \
            --preview="echo \"gcloud projects describe {} \n________________________________________________________________\" && echo {} | awk '{print \$1}' | xargs -I {} sh -c 'gcloud projects describe {}'" \
            --preview-window=down:10:wrap)

        # Check if a project was selected
        if [[ -z "$selected" ]]; then
            echo "No project selected."
            return 1
        fi
        # Extract the project ID from the selected line
        project_id=$(echo "$selected" | awk '{print $1}')
    fi

    if ! gcloud auth application-default set-quota-project "$project_id"; then
        echo "Failed to set quota project."
        return 1
    fi

    if ! gcloud config set project "$project_id"; then
        echo "Failed to set current project."
        return 1
    fi

    echo "gcloud projects describe ${project_id}\n________________________________________________________________"
    gcloud projects describe ${project_id}
}

# Created on 19/12/2022 fransiskusandika #
source '.env'

while getopts ":gp:" option; do
    case "${option}" in
    g) GPT=true ;;
    p) PROMPT=${OPTARG} ;;
    esac
done

function generate_gherkin() {
    response=$(curl $BASE_URL/completions -H 'Content-Type: application/json' -H "Authorization: Bearer $API_KEY" \
    -d '{
        "model": "text-davinci-003",
        "prompt": "create gherkin scenario for this requirment '"$PROMPT"' in each scenario",
        "max_tokens": 4000,
        "temperature": 1.0
    }' | jq '.choices[0].text')
    echo "$response"
}

if [[ $GPT == true ]]; then
    if [[ $PROMPT == "" ]]; then
    echo "You forgot to pass prompt!"
    exit 1
    fi
    echo "Answer"
    generate_gherkin
else
    echo "Please check your argument"
fi

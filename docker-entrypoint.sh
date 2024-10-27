#!/usr/bin/env sh

set -e

PLAIN='\033[0m'
BOLD='\033[1;37m'

if [ "${INPUT_CNAME}" ]; then
  NAME=${INPUT_CNAME}
else
  NAME=${GITHUB_REPOSITORY}
fi

if [ "${INPUT_REPO}" ]; then
  REPO=${INPUT_REPO}
else
  REPO=${GITHUB_REPOSITORY}
fi

[ -z "${INPUT_GITHUBTOKEN}" ] && \
  (echo -e "\n${BOLD}ERROR: Missing githubToken.${PLAIN}" ; exit 1)

# Setup Git
echo -e "\n${BOLD}Setting up Git${PLAIN}"
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git config --global init.defaultBranch main
echo "machine github.com login ${GITHUB_ACTOR} password ${INPUT_GITHUBTOKEN}" > ~/.netrc

# Clone the source repo
git clone --depth=1 --single-branch --branch "${INPUT_BRANCH}" "https://x-access-token:${INPUT_GITHUBTOKEN}@github.com/${REPO}.git" /tmp/gh-pages
rm -rf /tmp/gh-pages/*

# Build the website from source
echo -e "\n${BOLD}Building Site ${NAME} at commit ${GITHUB_SHA}${PLAIN}"
pnpm i
pnpm build ${INPUT_ARGS}

# Move generated build
mv -r ./dist/ /tmp/gh-pages/

echo -e "\n${BOLD}Commiting${PLAIN}"
cd /tmp/gh-pages

[ -n "${INPUT_CNAME}" ] && \
  echo "${INPUT_CNAME}" > CNAME

git add -A && git commit --allow-empty -am "Publishing Site ${NAME} at ${GITHUB_SHA} on $(date -u)"


echo -e "\n${BOLD}Pushing${PLAIN}"
git push --force


echo -e "\n${BOLD}Site ${NAME} at ${GITHUB_SHA} was successfully deployed!${PLAIN}"
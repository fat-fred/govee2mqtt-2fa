#!/bin/sh
# Update the addon version. Prefer explicit git tag (CI tag-push), fall back
# to {commit_date}-{short_sha} for local builds. Avoids the drift where the
# pushed git tag differs from the apply-tag-generated version.
if [ -z "${TAG_NAME:-}" ]; then
  if [ -n "${GITHUB_REF_NAME:-}" ] && [ "${GITHUB_REF_TYPE:-}" = "tag" ]; then
    TAG_NAME="$GITHUB_REF_NAME"
  else
    TAG_NAME="$(git -c "core.abbrev=8" show -s "--format=%cd-%h" "--date=format:%Y.%m.%d")"
  fi
fi
sed -i "s/version:.*/version: \"$TAG_NAME\"/" addon/config.yaml

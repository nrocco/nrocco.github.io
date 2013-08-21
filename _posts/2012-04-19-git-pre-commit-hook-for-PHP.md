---
layout: post
title: Git pre-commit hook for PHP projects
comments: true
---

When working on PHP projects -- well on any project for that matter -- I
always like to commit code that does not contain embarrassing mistakes.  I
created a simple git pre commit hook that I always install locally on my git
repositories to warn me before actually commiting if I have any syntax errors.

<!-- more -->

    #!/bin/sh

    if git rev-parse --verify HEAD >/dev/null 2>&1
    then
      against=HEAD
    else
      # Initial commit: diff against an empty tree object
      against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
    fi

    BADWORDS='var_dump|die|todo'

    EXITCODE=0
    FILES=`git diff --cached --diff-filter=ACMRTUXB --name-only $against --`

    for FILE in $FILES ; do
      if [ "${FILE##*.}" = "php" ]; then

        # Run all php files through php -l and grep for `illegal` words

        /usr/bin/php -l "$FILE" > /dev/null
        if [ $? -gt 0 ]; then
          EXITCODE=1
        fi

        /bin/grep -H -i -n -E "${BADWORDS}" $FILE
        if [ $? -eq 0 ]; then
          EXITCODE=1
        fi

      fi
    done

    if [ $EXITCODE -gt 0 ]; then
      echo
      echo 'Fix the above erros or use:'
      echo ' git commit --no-validate'
      echo
    fi

    exit $EXITCODE

This hook will run every time I use `git commit` and it will check all my .php
files I am about to commit for syntax errors by running each file through PHP
lint. Second it does a `grep` on each file and checks for bad words like
`die`, `var_dump` and `todo`.

If a syntax error or bad word was found it is printed to stdout and the hook
will exit with an exit code of 1 which in turn cancels the git commit
procedure.

If I am really sure that I would like to commit code that does not comply with
the above rules I can always use `git commit --no-validate` to skip the pre
commit process.

In my opinion this is a non obtrusive way to warn me about stupidities.

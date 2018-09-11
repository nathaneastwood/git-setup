# git-setup

[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

## Overview

This repository contains the `git alias` commands that I use on a daily basis.

## Usage

Below are worked examples on how to use each alias.

### `log` Commands

Pretty printing of the `log`

```
$ git ls
2be81bc [15 minutes ago] (origin/master, origin/HEAD) feat: Add more log and branch aliases [GitHub]
058ca25 [43 minutes ago] feat: Add additional aliases [neastwood]
f0da4fa [6 months ago] feat: Add git squash N alias [nathaneastwood]
d3a9042 [6 months ago] feat: Add git undo [nathaneastwood]
6a3a383 [6 months ago] feat: Add common git aliases and prettify the terminal [nathaneastwood]
```

```
$ git ll
2be81bc (origin/master, origin/HEAD) feat: Add more log and branch aliases [GitHub]
5       0       .gitconfig

058ca25 feat: Add additional aliases [neastwood]
12      1       .gitconfig

f0da4fa feat: Add git squash N alias [nathaneastwood]
4       0       .gitconfig

d3a9042 feat: Add git undo [nathaneastwood]
4       1       .gitconfig

6a3a383 feat: Add common git aliases and prettify the terminal [nathaneastwood]
5       0       .bash_profile
7       0       .gitconfig
```

One line `log`

```
$ git lg
* 979a08b (HEAD -> master) feat: Add initial README
* 2be81bc (origin/master, origin/HEAD) feat: Add more log and branch aliases
* 058ca25 feat: Add additional aliases
* f0da4fa feat: Add git squash N alias
* d3a9042 feat: Add git undo
* 6a3a383 feat: Add common git aliases and prettify the terminal
```

Yesterday's commits

```
$ git standup
commit 979a08bc7b1f497a1a1d38b4b23af2144617efc4 (HEAD -> master)
Author: neastwood <email@address.co.uk>

    feat: Add initial README

commit 058ca25ff80890bfebd23f0e49b18af5e6398f40
Author: neastwood <email@address.co.uk>

    feat: Add additional aliases
```

See all the commits related to a file

```
$ git filelog .bash_profile
commit 6a3a383dffea8f10ba4ceafcc51fb45a48827151
Author: nathaneastwood <email@address.com>
Date:   Thu Mar 15 15:12:23 2018 +0000

    feat: Add common git aliases and prettify the terminal

diff --git a/.bash_profile b/.bash_profile
new file mode 100644
index 0000000..cf848e0
--- /dev/null
+++ b/.bash_profile
@@ -0,0 +1,5 @@
+# Git branch in prompt.
+parse_git_branch() {
+    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
+}
+export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
```

Show modified files in the last commit

```
$ git dl
979a08b (HEAD -> master) feat: Add initial README [neastwood]
15      0       README.md
```

### `diff` Commands

Show the `diff` in the last commit

```
$ git dlc
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..006786c
--- /dev/null
+++ b/README.md
@@ -0,0 +1,15 @@
+git-setup
+=========
+
+[![Project Status: Active - The project has reached a stable, usable
+state and is being actively
+developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
+
+Overview
+--------
+
+This repository contains the `git alias` commands that I use on a daily basis.
+
+Usage
+-----
+
```

Show content (full diff) of a commit given a revision

```
$ git dr 979a08b
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..006786c
--- /dev/null
+++ b/README.md
@@ -0,0 +1,15 @@
+git-setup
+=========
+
+[![Project Status: Active - The project has reached a stable, usable
+state and is being actively
+developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
+
+Overview
+--------
+
+This repository contains the `git alias` commands that I use on a daily basis.
+
+Usage
+-----
+
```

Show the number of changes between the working tree and the index.

```
$ git changes
 .gitconfig | 5 +++--
 README.md  | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)
```

### Convoluted Aliases

Undo the last N commits

```
$ git undo 1
HEAD is now at 2be81bc feat: Add more log and branch aliases
```

Squash the last N commits

```
$ git squash 2
```

List all branches sorted by the last modified

```
$ git bsort
Tue Sep 11 10:12:56 2018 +0100  f0fae0a master
```

Remove one or more files from the staging area

```
$ git unstage
Unstaged changes after reset:
M       .gitconfig
M       README.md

$ git unstage README.md
Unstaged changes after reset:
M       README.md
```

List all aliases

```
$ git la
ls=log --pretty=format:%C(green)%h\ %C(yellow)[%ad]%Cred%d\ %Creset%s%Cblue\ [%cn] --decorate --date=relative
ll=log --pretty=format:%C(yellow)%h%Cred%d\ %Creset%s%Cblue\ [%cn] --decorate --numstat
lg=log --graph --all  --decorate --oneline
dl=!git ll -1
standup=!git log --since yesterday --author $(git config user.email) --pretty=short
filelog=log -u
dr=!f() { git diff $1^..$1; }; f
dlc=diff --cached HEAD^
la=!git config -l | grep alias | cut -c 7-
undo=!f() { git reset --hard $(git rev-parse --abbrev-ref HEAD)@{${1-1}}; }; f
bsort=!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'
squash=!f(){ git reset --soft HEAD~${1} && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"; };f
```

Word and line counts

```
$ git wc
  25 .bash_profile
 150 .gitconfig
 676 README.md
 851 total

$ git lc
   5 .bash_profile
  26 .gitconfig
 198 README.md
 229 total
```
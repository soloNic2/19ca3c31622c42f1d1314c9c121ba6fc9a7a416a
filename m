Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF23C10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiLSKTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLSKTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:41 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69BEA444
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o5so8127804wrm.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4h2b5BvMqqlTsChYuopvWvXlldSa6LaQryT1r98Oqw=;
        b=jbzYF9icoIm8TCU4Eq9x9tcOjU0rT/TjYq9/eyr0OUSPzZImbCr95zjxmx0pdzw9rv
         nL+8eDmxRtXYJXzr6p7kq4oOvoooUDgvTQwT9jkQtjPyvMoDh+bkjJ/ig+TVpmlL2J8Q
         uHZNFVDl3vMJ4fnYma9YqRNwv+nLhLV/25736RPIGY4KtFqS29tiBZFhKMmSj0P2vF/i
         L/mhh3Q6H2Fd+Avqt7nBk+vRpP9Qv/iVhHVme36I2X0ANneDmH2IaXZQU9W5udFQeylk
         2j8Y/XxTp/q5iKvVSCt///BpEBw5gyB+dj9ScOdGZYt3tyJsFV7kh8O+dh5PEeppfgLj
         r/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4h2b5BvMqqlTsChYuopvWvXlldSa6LaQryT1r98Oqw=;
        b=761SdCdvRW6QD8kk+zstkUinBss0JgT14k1YpeIyM6Hmbh6vegmtEqlqJshQNTvqqF
         BqbYIK4HRcg4GJbTjc1GehFofOMcAB6WYvyEyOh9aCKljpPVRiKf2uPOp50PLXjKUmlT
         yve+W5DaaadM6BjnSWb5w96kh3EsUEttMixBFDZ8sKCN38YytC4mrvGxZzEToHzWlmQ+
         /nz8WTCi8uSIh7SQcR6rRpAPVQ5o/yY225uBcpZF3eBCFHHQL2bXr7T6ii3oXtxtjeUc
         0g+48V5DD7cNI5nCC9RDEABj/noh91CNMmrTNWg4BTae8Tz0QqwM06uF10TeLJrT/J+m
         l4QQ==
X-Gm-Message-State: ANoB5pkXEvbBy5IHgBT7IKtcsgSdqjdTpRibh5tt1kdQNF0As5sbUUhb
        /78U9ybqOjLtaws0oYq4FADR/3WLCdI41g==
X-Google-Smtp-Source: AA0mqf4mtr2tnkvNX//cfJSdgWni+x0LFHcD3f5tJEdZ3AOy4SLMLxMojdAkTJxZKBaRbyjIePHZYg==
X-Received: by 2002:adf:df05:0:b0:242:1ef2:cef3 with SMTP id y5-20020adfdf05000000b002421ef2cef3mr24834032wrl.12.1671445177739;
        Mon, 19 Dec 2022 02:19:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] tests: don't lose exit status with "test <op> $(git ...)"
Date:   Mon, 19 Dec 2022 11:19:27 +0100
Message-Id: <patch-v4-4.6-da66e5bf1c1-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the preceding commit, rewrite tests that ran "git" inside
command substitution and lost the exit status of "git" so that we
notice the failing "git". This time around we're converting cases that
didn't involve a containing sub-shell around the command substitution.

In the case of "t0060-path-utils.sh" and
"t2005-checkout-index-symlinks.sh" convert the relevant code to using
the modern style of indentation and newline wrapping while having to
change it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh          |   4 +-
 t/t0001-init.sh                    |   9 ++-
 t/t0002-gitfile.sh                 |   4 +-
 t/t0060-path-utils.sh              | 103 +++++++++++++++++++++--------
 t/t0100-previous.sh                |   8 ++-
 t/t1504-ceiling-dirs.sh            |   8 ++-
 t/t2005-checkout-index-symlinks.sh |   8 ++-
 t/t5522-pull-symlink.sh            |   4 +-
 t/t7402-submodule-rebase.sh        |   9 ++-
 t/t7504-commit-msg-hook.sh         |   4 +-
 t/t7810-grep.sh                    |   4 +-
 11 files changed, 120 insertions(+), 45 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index d7c2b670b4a..dee14992c52 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -185,7 +185,9 @@ test_git_directory_exists () {
 	if test -f sub1/.git
 	then
 		# does core.worktree point at the right place?
-		test "$(git -C .git/modules/$1 config core.worktree)" = "../../../$1"
+		echo "../../../$1" >expect &&
+		git -C ".git/modules/$1" config core.worktree >actual &&
+		test_cmp expect actual
 	fi
 }
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index d479303efa0..30a6edca1d2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -598,9 +598,14 @@ test_expect_success 'invalid default branch name' '
 test_expect_success 'branch -m with the initial branch' '
 	git init rename-initial &&
 	git -C rename-initial branch -m renamed &&
-	test renamed = $(git -C rename-initial symbolic-ref --short HEAD) &&
+	echo renamed >expect &&
+	git -C rename-initial symbolic-ref --short HEAD >actual &&
+	test_cmp expect actual &&
+
 	git -C rename-initial branch -m renamed again &&
-	test again = $(git -C rename-initial symbolic-ref --short HEAD)
+	echo again >expect &&
+	git -C rename-initial symbolic-ref --short HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 26eaca095a2..e013d38f485 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -33,7 +33,9 @@ test_expect_success 'bad setup: invalid .git file path' '
 
 test_expect_success 'final setup + check rev-parse --git-dir' '
 	echo "gitdir: $REAL" >.git &&
-	test "$REAL" = "$(git rev-parse --git-dir)"
+	echo "$REAL" >expect &&
+	git rev-parse --git-dir >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'check hash-object' '
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 53ec717cbca..6490ad5ca1b 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -10,20 +10,27 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 norm_path() {
 	expected=$(test-tool path-utils print_path "$2")
-	test_expect_success $3 "normalize path: $1 => $2" \
-	"test \"\$(test-tool path-utils normalize_path_copy '$1')\" = '$expected'"
+	test_expect_success $3 "normalize path: $1 => $2" "
+		echo '$expected' >expect &&
+		test-tool path-utils normalize_path_copy '$1' >actual &&
+		test_cmp expect actual
+	"
 }
 
 relative_path() {
 	expected=$(test-tool path-utils print_path "$3")
-	test_expect_success $4 "relative path: $1 $2 => $3" \
-	"test \"\$(test-tool path-utils relative_path '$1' '$2')\" = '$expected'"
+	test_expect_success $4 "relative path: $1 $2 => $3" "
+		echo '$expected' >expect &&
+		test-tool path-utils relative_path '$1' '$2' >actual &&
+		test_cmp expect actual
+	"
 }
 
 test_submodule_relative_url() {
 	test_expect_success "test_submodule_relative_url: $1 $2 $3 => $4" "
-		actual=\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &&
-		test \"\$actual\" = '$4'
+		echo '$4' >expect &&
+		test-tool submodule resolve-relative-url '$1' '$2' '$3' >actual &&
+		test_cmp expect actual
 	"
 }
 
@@ -64,9 +71,11 @@ ancestor() {
 		expected=$(($expected-$rootslash+$rootoff))
 		;;
 	esac
-	test_expect_success $4 "longest ancestor: $1 $2 => $expected" \
-	"actual=\$(test-tool path-utils longest_ancestor_length '$1' '$2') &&
-	 test \"\$actual\" = '$expected'"
+	test_expect_success $4 "longest ancestor: $1 $2 => $expected" "
+		echo '$expected' >expect &&
+		test-tool path-utils longest_ancestor_length '$1' '$2' >actual &&
+		test_cmp expect actual
+	"
 }
 
 # Some absolute path tests should be skipped on Windows due to path mangling
@@ -166,8 +175,10 @@ ancestor D:/Users/me C:/ -1 MINGW
 ancestor //server/share/my-directory //server/share/ 14 MINGW
 
 test_expect_success 'strip_path_suffix' '
-	test c:/msysgit = $(test-tool path-utils strip_path_suffix \
-		c:/msysgit/libexec//git-core libexec/git-core)
+	echo c:/msysgit >expect &&
+	test-tool path-utils strip_path_suffix \
+		c:/msysgit/libexec//git-core libexec/git-core >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'absolute path rejects the empty string' '
@@ -188,35 +199,61 @@ test_expect_success 'real path rejects the empty string' '
 '
 
 test_expect_success POSIX 'real path works on absolute paths 1' '
+	echo / >expect &&
+	test-tool path-utils real_path "/" >actual &&
+	test_cmp expect actual &&
+
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-tool path-utils real_path "/")" &&
-	test "/$nopath" = "$(test-tool path-utils real_path "/$nopath")"
+	echo "/$nopath" >expect &&
+	test-tool path-utils real_path "/$nopath" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'real path works on absolute paths 2' '
-	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "$d")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "$d/$nopath")"
+	echo "$d" >expect &&
+	test-tool path-utils real_path "$d" >actual &&
+	test_cmp expect actual &&
+
+	nopath="hopefully-absent-path" &&
+	echo "$d/$nopath" >expect &&
+	test-tool path-utils real_path "$d/$nopath" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success POSIX 'real path removes extra leading slashes' '
+	echo "/" >expect &&
+	test-tool path-utils real_path "///" >actual &&
+	test_cmp expect actual &&
+
 	nopath="hopefully-absent-path" &&
-	test "/" = "$(test-tool path-utils real_path "///")" &&
-	test "/$nopath" = "$(test-tool path-utils real_path "///$nopath")" &&
+	echo "/$nopath" >expect &&
+	test-tool path-utils real_path "///$nopath" >actual &&
+	test_cmp expect actual &&
+
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "//$d")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "//$d/$nopath")"
+	echo "$d" >expect &&
+	test-tool path-utils real_path "//$d" >actual &&
+	test_cmp expect actual &&
+
+	echo "$d/$nopath" >expect &&
+	test-tool path-utils real_path "//$d/$nopath" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'real path removes other extra slashes' '
-	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
-	test "$d" = "$(test-tool path-utils real_path "$d///")" &&
-	test "$d/$nopath" = "$(test-tool path-utils real_path "$d///$nopath")"
+	echo "$d" >expect &&
+	test-tool path-utils real_path "$d///" >actual &&
+	test_cmp expect actual &&
+
+	nopath="hopefully-absent-path" &&
+	echo "$d/$nopath" >expect &&
+	test-tool path-utils real_path "$d///$nopath" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success SYMLINKS 'real path works on symlinks' '
@@ -227,19 +264,29 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir third &&
 	dir="$(cd .git && pwd -P)" &&
 	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
+	echo "$dir" >expect &&
+	test-tool path-utils real_path $dir2 >actual &&
+	test_cmp expect actual &&
 	file="$dir"/index &&
-	test "$file" = "$(test-tool path-utils real_path $dir2/index)" &&
+	echo "$file" >expect &&
+	test-tool path-utils real_path $dir2/index >actual &&
+	test_cmp expect actual &&
 	basename=blub &&
-	test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
+	echo "$dir/$basename" >expect &&
+	test-tool -C .git path-utils real_path "$basename" >actual &&
+	test_cmp expect actual &&
 	ln -s ../first/file .git/syml &&
 	sym="$(cd first && pwd -P)"/file &&
-	test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
+	echo "$sym" >expect &&
+	test-tool path-utils real_path "$dir2/syml" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
 	ln -s target symlink &&
-	test "$(test-tool path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+	echo "symlink" >expect &&
+	test-tool path-utils prefix_path prefix "$(pwd)/symlink" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'prefix_path works with only absolute path to work tree' '
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index a16cc3d2983..70a3223f219 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -12,7 +12,9 @@ test_expect_success 'branch -d @{-1}' '
 	test_commit A &&
 	git checkout -b junk &&
 	git checkout - &&
-	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
+	echo refs/heads/main >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	git branch -d @{-1} &&
 	test_must_fail git rev-parse --verify refs/heads/junk
 '
@@ -21,7 +23,9 @@ test_expect_success 'branch -d @{-12} when there is not enough switches yet' '
 	git reflog expire --expire=now &&
 	git checkout -b junk2 &&
 	git checkout - &&
-	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
+	echo refs/heads/main >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
 	test_must_fail git branch -d @{-12} &&
 	git rev-parse --verify refs/heads/main
 '
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index 0fafcf9dde3..c1679e31d8a 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -6,8 +6,12 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_prefix() {
-	test_expect_success "$1" \
-	"test '$2' = \"\$(git rev-parse --show-prefix)\""
+	local expect="$2" &&
+	test_expect_success "$1: git rev-parse --show-prefix is '$2'" '
+		echo "$expect" >expect &&
+		git rev-parse --show-prefix >actual &&
+		test_cmp expect actual
+	'
 }
 
 test_fail() {
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 112682a45a1..67d18cfa104 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -22,8 +22,10 @@ test_expect_success \
 git checkout-index symlink &&
 test -f symlink'
 
-test_expect_success \
-'the file must be the blob we added during the setup' '
-test "$(git hash-object -t blob symlink)" = $l'
+test_expect_success 'the file must be the blob we added during the setup' '
+	echo "$l" >expect &&
+	git hash-object -t blob symlink >actual &&
+	test_cmp expect actual
+'
 
 test_done
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index bcff460d0a2..9fb73a8c3eb 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -78,7 +78,9 @@ test_expect_success SYMLINKS 'pushing from symlinked subdir' '
 		git commit -m push ./file &&
 		git push
 	) &&
-	test push = $(git show HEAD:subdir/file)
+	echo push >expect &&
+	git show HEAD:subdir/file >actual &&
+	test_cmp expect actual
 '
 
 test_done
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 1927a862839..c74798e8d24 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -55,12 +55,15 @@ chmod a+x fake-editor.sh
 
 test_expect_success 'interactive rebase with a dirty submodule' '
 
-	test submodule = $(git diff --name-only) &&
+	echo submodule >expect &&
+	git diff --name-only >actual &&
+	test_cmp expect actual &&
 	HEAD=$(git rev-parse HEAD) &&
 	GIT_EDITOR="\"$(pwd)/fake-editor.sh\"" EDITOR_TEXT="pick $HEAD" \
 		git rebase -i HEAD^ &&
-	test submodule = $(git diff --name-only)
-
+	echo submodule >expect &&
+	git diff --name-only >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase with dirty file and submodule fails' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 07ca46fb0d5..d1255228d5f 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -102,7 +102,9 @@ test_expect_success 'setup: commit-msg hook that always fails' '
 '
 
 commit_msg_is () {
-	test "$(git log --pretty=format:%s%b -1)" = "$1"
+	printf "%s" "$1" >expect &&
+	git log --pretty=format:%s%b -1 >actual &&
+	test_cmp expect actual
 }
 
 test_expect_success 'with failing hook' '
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8eded6ab274..39d6d713ecb 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1001,7 +1001,9 @@ test_expect_success 'log --committer does not search in timestamp' '
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-	test "$(git grep test)" = "t/t:test" &&
+	echo "t/t:test" >expect &&
+	git grep test >actual &&
+	test_cmp expect actual &&
 	git update-index --no-assume-unchanged t/t &&
 	git checkout t/t
 '
-- 
2.39.0.1071.g97ce8966538


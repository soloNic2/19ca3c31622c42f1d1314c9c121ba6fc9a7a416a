Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D25C433FE
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiDVWjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiDVWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC04289160
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r19so5802601wmq.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3IAiMHgRwhfbvkUdsr17fwV8M0Qk+EnCGfvQEEa+RAk=;
        b=WV+Ntpe2Lm3MPpas1PLIG4Eg610QtShtbicS66DEjAMet1CAyHPYDdDJr9/ZzwiFuK
         /GPn7klM9eJWElIrNCPNM49+irnHPoML6KmJ8xu5ccZ6v+sAih/AROLpYfmFxQNc42lc
         KfBsejjDHD96Ai34BOh+cBZSA9k6M5/uzhuvq0jGsFf0RDy+druI1NaCOwZ2BQATnvT0
         d1H7xLeRRHi5DDqCMmFDJf6Wq/uM9g8+ah97ustdew/tsfkJDJplw60bYkXt3tKOonPr
         aUo7TexzIo/HAUL+olsAlKMDNGrVdU9yE9YhxbBko4zh18Zc0C4unlS3+XlqTW1OaloT
         E5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3IAiMHgRwhfbvkUdsr17fwV8M0Qk+EnCGfvQEEa+RAk=;
        b=D98Q+9OS+jUMnZLKkTvHGtCQC1xbzr92cbrhEgu3yebtl9I833hGm3R3C22IzuTfmH
         Sr8HTzp5ZE6tMSUYkuP6ujdPwzf7+SmzXYvGrZPjBwraYHGbj8BTpOvHMdwfVde71z+k
         cP74aHUN2tlV480LVMEOKGUjue3rFqorVESxhOmMtNI7BdLU31wX9Kw7PP2YX6UODzKD
         Z90JxJ0q24lH3jHtMsTkdVOaB3AtS9RrGPSry+Ot172yVdN1laQx/0qSeXB2VgQLtJ6t
         2SLsyitmv+kdIPtnGZ/F12r82+J1cLFUgATGWS1W0Grozr/N5S9oeojqyNsSI7xYyQC3
         UPtg==
X-Gm-Message-State: AOAM531baMPmyABSyPkhW5ECtLTLhMR0z55AN24322/ebNwGtkfAhNpe
        HY4ADTarPrKFweRnMQiQ3ncvMrpDtu0=
X-Google-Smtp-Source: ABdhPJw9+BxGl3dKISnILw8rdpTcBHd44xGo06K5LHlf1MV/KcOZXnCg4iAVrSEapRfuYixDTh5DSg==
X-Received: by 2002:a05:600c:34ce:b0:392:9cf:4e25 with SMTP id d14-20020a05600c34ce00b0039209cf4e25mr14925756wmq.193.1650663019593;
        Fri, 22 Apr 2022 14:30:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm2621876wrf.80.2022.04.22.14.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:19 -0700 (PDT)
Message-Id: <26308936af90e2e01180572fd25ac2239a3d20da.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:48 +0000
Subject: [PATCH v6 22/28] t/perf/p7527: add perf test for builtin FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7527-builtin-fsmonitor.sh | 257 ++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh

diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..9338b9ea008
--- /dev/null
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -0,0 +1,257 @@
+#!/bin/sh
+
+test_description="Perf test for the builtin FSMonitor"
+
+. ./perf-lib.sh
+
+if ! test_have_prereq FSMONITOR_DAEMON
+then
+	skip_all="fsmonitor--daemon is not supported on this platform"
+	test_done
+fi
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+# Lie to perf-lib and ask for a new empty repo and avoid
+# the complaints about GIT_PERF_REPO not being big enough
+# the perf hit when GIT_PERF_LARGE_REPO is copied into
+# the trash directory.
+#
+# NEEDSWORK: It would be nice if perf-lib had an option to
+# "borrow" an existing large repo (especially for gigantic
+# monorepos) and use it in-place.  For now, fake it here.
+#
+test_perf_fresh_repo
+
+
+# Use a generated synthetic monorepo.  If it doesn't exist, we will
+# generate it.  If it does exist, we will put it in a known state
+# before we start our timings.
+#
+PARAM_D=5
+PARAM_W=10
+PARAM_F=9
+
+PARAMS="$PARAM_D"."$PARAM_W"."$PARAM_F"
+
+BALLAST_BR=p0006-ballast
+export BALLAST_BR
+
+TMP_BR=tmp_br
+export TMP_BR
+
+REPO=../repos/gen-many-files-"$PARAMS".git
+export REPO
+
+if ! test -d $REPO
+then
+	(cd ../repos; ./many-files.sh -d $PARAM_D -w $PARAM_W -f $PARAM_F)
+fi
+
+
+enable_uc () {
+	git -C $REPO config core.untrackedcache true
+	git -C $REPO update-index --untracked-cache
+	git -C $REPO status >/dev/null 2>&1
+}
+
+disable_uc () {
+	git -C $REPO config core.untrackedcache false
+	git -C $REPO update-index --no-untracked-cache
+	git -C $REPO status >/dev/null 2>&1
+}
+
+start_fsm () {
+	git -C $REPO fsmonitor--daemon start
+	git -C $REPO fsmonitor--daemon status
+	git -C $REPO config core.fsmonitor true
+	git -C $REPO update-index --fsmonitor
+	git -C $REPO status >/dev/null 2>&1
+}
+
+stop_fsm () {
+	git -C $REPO config --unset core.fsmonitor
+	git -C $REPO update-index --no-fsmonitor
+	test_might_fail git -C $REPO fsmonitor--daemon stop 2>/dev/null
+	git -C $REPO status >/dev/null 2>&1
+}
+
+
+# Ensure that FSMonitor is turned off on the borrowed repo.
+#
+test_expect_success "Setup borrowed repo (fsm+uc)" "
+	stop_fsm &&
+	disable_uc
+"
+
+# Also ensure that it starts in a known state.
+#
+# Because we assume that $GIT_PERF_REPEAT_COUNT > 1, we are not going to time
+# the ballast checkout, since only the first invocation does any work and the
+# subsequent ones just print "already on branch" and quit, so the reported
+# time is not useful.
+#
+# Create a temp branch and do all work relative to it so that we don't
+# accidentially alter the real ballast branch.
+#
+test_expect_success "Setup borrowed repo (temp ballast branch)" "
+	test_might_fail git -C $REPO checkout $BALLAST_BR &&
+	test_might_fail git -C $REPO reset --hard &&
+	git -C $REPO clean -d -f &&
+	test_might_fail git -C $REPO branch -D $TMP_BR &&
+	git -C $REPO branch $TMP_BR $BALLAST_BR &&
+	git -C $REPO checkout $TMP_BR
+"
+
+
+echo Data >data.txt
+
+# NEEDSWORK: We assume that $GIT_PERF_REPEAT_COUNT > 1.  With
+# FSMonitor enabled, we can get a skewed view of status times, since
+# the index MAY (or may not) be updated after the first invocation
+# which will update the FSMonitor Token, so the subsequent invocations
+# may get a smaller response from the daemon.
+#
+do_status () {
+	msg=$1
+
+	test_perf "$msg" "
+		git -C $REPO status >/dev/null 2>&1
+	"
+}
+
+do_matrix () {
+	uc=$1
+	fsm=$2
+
+	t="[uc $uc][fsm $fsm]"
+	MATRIX_BR="$TMP_BR-$uc-$fsm"
+
+	test_expect_success "$t Setup matrix branch" "
+		git -C $REPO clean -d -f &&
+		git -C $REPO checkout $TMP_BR &&
+		test_might_fail git -C $REPO branch -D $MATRIX_BR &&
+		git -C $REPO branch $MATRIX_BR $TMP_BR &&
+		git -C $REPO checkout $MATRIX_BR
+	"
+
+	if test $uc = true
+	then
+		enable_uc
+	else
+		disable_uc
+	fi
+
+	if test $fsm = true
+	then
+		start_fsm
+	else
+		stop_fsm
+	fi
+
+	do_status "$t status after checkout"
+
+	# Modify many files in the matrix branch.
+	# Stage them.
+	# Commit them.
+	# Rollback.
+	#
+	test_expect_success "$t modify tracked files" "
+		find $REPO -name file1 -exec cp data.txt {} \\;
+	"
+
+	do_status "$t status after big change"
+
+	# Don't bother timing the "add" because _REPEAT_COUNT
+	# issue described above.
+	#
+	test_expect_success "$t add all" "
+		git -C $REPO add -A
+	"
+
+	do_status "$t status after add all"
+
+	test_expect_success "$t add dot" "
+		git -C $REPO add .
+	"
+
+	do_status "$t status after add dot"
+
+	test_expect_success "$t commit staged" "
+		git -C $REPO commit -a -m data
+	"
+
+	do_status "$t status after commit"
+
+	test_expect_success "$t reset HEAD~1 hard" "
+		git -C $REPO reset --hard HEAD~1 >/dev/null 2>&1
+	"
+
+	do_status "$t status after reset hard"
+
+	# Create some untracked files.
+	#
+	test_expect_success "$t create untracked files" "
+		cp -R $REPO/ballast/dir1 $REPO/ballast/xxx1
+	"
+
+	do_status "$t status after create untracked files"
+
+	# Remove the new untracked files.
+	#
+	test_expect_success "$t clean -df" "
+		git -C $REPO clean -d -f
+	"
+
+	do_status "$t status after clean"
+
+	if test $fsm = true
+	then
+		stop_fsm
+	fi
+}
+
+# Begin testing each case in the matrix that we care about.
+#
+uc_values="false"
+test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+
+fsm_values="false true"
+
+for uc_val in $uc_values
+do
+	for fsm_val in $fsm_values
+	do
+		do_matrix $uc_val $fsm_val
+	done
+done
+
+cleanup () {
+	uc=$1
+	fsm=$2
+
+	MATRIX_BR="$TMP_BR-$uc-$fsm"
+
+	test_might_fail git -C $REPO branch -D $MATRIX_BR
+}
+
+
+# We're borrowing this repo.  We should leave it in a clean state.
+#
+test_expect_success "Cleanup temp and matrix branches" "
+	git -C $REPO clean -d -f &&
+	test_might_fail git -C $REPO checkout $BALLAST_BR &&
+	test_might_fail git -C $REPO branch -D $TMP_BR &&
+	for uc_val in $uc_values
+	do
+		for fsm_val in $fsm_values
+		do
+			cleanup $uc_val $fsm_val
+		done
+	done
+"
+
+test_done
-- 
gitgitgadget


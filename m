Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E7C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 09:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIGJxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiIGJxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 05:53:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F9DB5A42
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 02:53:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k9so19525821wri.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=aAYeUFktnDiJWsEQX/KjCE1/YHiSi/ywL+xNrCMI26I=;
        b=ex6nAWqQ6Wr3GDHqQrXQ4St3poQLAYM6FFIDDXYoRsQPcjUB2/j8wCHQUCfPi+qOAm
         94/Hi+p9R0VBmI3NpHeskwt87Bfv1Vrtr/oSMXkWOo/uApVvjBeNXne93wGezwy6YQBU
         Zuzl5tqtU20xamYaK39MjnSGyUAUxN18xWAhkg8W094HT+MEB8MhBH0tRpA5iy2CPn+G
         wDvSb3Vym3bEWyazgDG2EE53q3TuUcHa1JQfM/icXaPYOyGyL5pa3m3Sx54roDCCkAAJ
         xvoHHp3Ju0P4eQrO3AgnodNMaiXM0ZH1KVrD2ygkwI63FhhfAN4Uq9G18bTsOekjOtHC
         B97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aAYeUFktnDiJWsEQX/KjCE1/YHiSi/ywL+xNrCMI26I=;
        b=fUbe1ZYkgLUJZWq/2UF1r91pbYWipPcQbp3m6aBz/fPoLIi66exW9b2BUTc8UdbSW5
         WKbDAvh7TtWx97FuxqYdsuak9YD+Kh+5ya/hE1xqKFoYA1hA5hDdPlO9qWO+untAbQpt
         mAc7t6xHCqgd3wtJJjP9OkCMvnBhlDnElgV3p6DgyfoBbXyj2bhWPfY9EwqgFLScAeVa
         mSMRMc4mFt4ytI6o/MxTD+0HK9CTDTda7VodD1eugv7qWyImWPBQzhNr6vr+ntGS6FOM
         Lbav/0O6tOXhAFJSdsqwmRjKawZiHM9YFzJgqW6xNFuHdJeCUFfeQbA+0YOeWfwyj+xv
         684g==
X-Gm-Message-State: ACgBeo3CR2SMHHRATpK+lf0QoY6qzznfcWvpP0j8WyES7zNd9Fw33yog
        CUJVMGB8PW3NYL4ZcEfMCkuTJHymJ30=
X-Google-Smtp-Source: AA6agR6WoyCRDHMvmtsBnVKexIdMiYlt7eGH3SvV3k9+qpD/GJWKVVcAPFAOei7PMhnN/oKISRZfow==
X-Received: by 2002:a05:6000:1c0d:b0:225:6c66:5ed3 with SMTP id ba13-20020a0560001c0d00b002256c665ed3mr1579745wrb.678.1662544413980;
        Wed, 07 Sep 2022 02:53:33 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id c1-20020adfed81000000b0022860e8ae7csm13648945wro.77.2022.09.07.02.53.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 02:53:33 -0700 (PDT)
Subject: [PATCH v2 2/2] branch: support for shortcuts like @{-1} completed
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
Message-ID: <4bac4681-d1cf-1469-eaac-a4c2c63c562d@gmail.com>
Date:   Wed, 7 Sep 2022 11:53:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch command with options "edit-description", "set-upstream-to"
and "unset-upstream" expects a branch name.  Since ae5a6c3684
(checkout: implement "@{-N}" shortcut name for N-th last branch,
2009-01-17) a branch can be specified using shortcuts like @{-1}.
Those shortcuts need to be resolved when considering the
arguments.

Usage examples:

We can modify the description of the previously checked out branch
with:

$ git branch --edit--description @{-1}

We can modify the upstream of the previously checked out branch
with:

$ git branch --set-upstream-to upstream @{-1}
$ git branch --unset-upstream @{-1}

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c                      | 29 +++++++++++++++++++++------
 t/t3204-branch-name-interpretation.sh | 25 +++++++++++++++++++++++
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5229cb796f..6ee95b4179 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,14 +791,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
 		int ret = 0;
 
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
-		} else if (argc == 1)
-			branch_name = argv[0];
+		} else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch_name = buf.buf;
+		}
 		else
 			die(_("cannot edit description of more than one branch"));
 
@@ -814,6 +817,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			ret = edit_branch_description(branch_name);
 
 		strbuf_release(&branch_ref);
+		strbuf_release(&buf);
 		return ret;
 	} else if (copy) {
 		if (!argc)
@@ -834,9 +838,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else
 			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
+		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to set new upstream"));
 
 		if (!branch) {
@@ -853,11 +863,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
 					quiet);
+		strbuf_release(&buf);
 	} else if (unset_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to unset upstream"));
 
 		if (!branch) {
@@ -870,6 +886,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff..0a423298d6 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -133,4 +133,29 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
 	expect_branch HEAD one
 '
 
+test_expect_success 'edit-description via @{-1}' '
+	git checkout main &&
+	git checkout - &&
+	write_script editor <<-\EOF &&
+		echo "Branch description" >"$1"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+		write_script editor <<-\EOF &&
+		git stripspace -s <"$1" >"EDITOR_OUTPUT"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+	echo "Branch description" >expect &&
+	test_cmp expect EDITOR_OUTPUT
+'
+
+test_expect_success 'modify branch upstream via "@{-1}" and "@{-1}@{upstream}"' '
+	git branch upstream-branch &&
+	git checkout -b upstream-other -t upstream-branch &&
+	git checkout - &&
+	git branch --set-upstream-to @{-1} @{-1}@{upstream} &&
+	test "$(git config branch.upstream-branch.merge)" = "refs/heads/upstream-other" &&
+	git branch --unset-upstream @{-1} &&
+	test_must_fail git config branch.upstream-other.merge
+'
+
 test_done
-- 
2.36.1

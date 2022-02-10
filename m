Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8230C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiBJJ3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiBJJ3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E505110E
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso3971639pfa.10
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AIDjye1DDOnT7iBsdjGhA08VwNJHQSPMOfgmMBSCDP8=;
        b=O3RvFqCvr+EHzFYElBUqzmK1Ba0QEa82fs/evF7XgtxezSQ4JS/Ilsi4Hk0WXhsowM
         AAnSgfBOlyxrSJqeql38UatHlE68nPbqyVjScYjCVvaxVyVlg5gKBKftGLoiqVFLhWgF
         RrqS5hpdUsyN0lGdQJCcf4vlyAusiPau9yvjUaHynPTQAbVltbfqV1FyCafYUIsjqfy0
         cWrn0KU+zsXEkhzcSWBycUmHZl3gKEUFXckVDGXW/NmHHv/lUHbMRXxBsb2UQ7/RqvTX
         VVSso+N7rrwWnAJnAsiaAd9vZ4BFzOI/6wvG4oWOpf9v7KJjt/aroghMA6ppaOk8noeY
         lxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AIDjye1DDOnT7iBsdjGhA08VwNJHQSPMOfgmMBSCDP8=;
        b=triy1WLvo5GAzJYr6zFxqKLUg4/pHzhVRU1Zz7JFgfkrWNyfDmoAwIrVpcoi1v2k53
         75XMNcSG7I2BPOzceJiTZyYBaO1eAQQcdcg34pc5lk/DcgRMSE4UW1s4Ujtu7tywpa50
         FIQ5ROBlxGZhZjTaAGTVJq2DhwRwv7CoFDvDr6wpEgNkq2lHBvqou209/jscUMSvomrE
         m33YTOq8Ox9RJ/R74CHaFsDt8Pk40zdX5FmgIV1ccnOrJCV2SBzDsmI3odOw0Fpe/3x2
         nO/tICrgzsw+iYPlTkBZd/X4ksSlNU3en6PkBPCTDXoqXSAwSH5RtPnxDutcja4f6Brw
         UH4w==
X-Gm-Message-State: AOAM532yVJUdVgQfOnAXX1IkK5m1M8Fd/NGMsOFbTBo47lniMadElYz8
        Xod1yUwWuoerbswo3g/ebUkS/CIPzrZ7APwIefvK6qec8RqAMc/HOte77rQfvi4qB3z9jx2u4TO
        9YdT0Jmru5434WyTk8Dy1l4T9C3W+pIMRzbdg6GuyWgIa0La2DTG0mgZOG27duI8=
X-Google-Smtp-Source: ABdhPJxZuJ802/Zj/Y9d3QqZa2oCYfLSONBBptZ3vVT5d9GMHl6tRfHv3BwGranih2yJkrycCXFPWc0A+nJA9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1d88:: with SMTP id
 pf8mr1816948pjb.162.1644485353654; Thu, 10 Feb 2022 01:29:13 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:25 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-13-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 12/20] submodule--helper run-update-procedure: learn --remote
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach run-update-procedure to handle --remote instead of parsing
--remote in git-submodule.sh. As a result, "git submodule--helper
print-default-remote" has no more callers, so remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 39 ++++++++++++++++++++++---------------
 git-submodule.sh            | 30 +---------------------------
 2 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a26477ce04..15ae986692 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -71,21 +71,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -2026,6 +2011,7 @@ struct update_data {
 	unsigned int quiet;
 	unsigned int nofetch;
 	unsigned int just_cloned;
+	unsigned int remote;
 };
 #define UPDATE_DATA_INIT { \
 	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
@@ -2585,6 +2571,8 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
+		OPT_BOOL(0, "remote", &opt.remote,
+			 N_("use SHA-1 of submodule's remote tracking branch")),
 		OPT_END()
 	};
 
@@ -2988,6 +2976,25 @@ static int update_submodule2(struct update_data *update_data)
 			    update_data->displaypath);
 	}
 
+	if (update_data->remote) {
+		char *remote_name = get_default_remote_submodule(update_data->sm_path);
+		const char *branch = remote_submodule_branch(update_data->sm_path);
+		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
+
+		if (!update_data->nofetch) {
+			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
+					      0, NULL))
+				die(_("Unable to fetch in submodule path '%s'"),
+				    update_data->sm_path);
+		}
+
+		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
+			die(_("Unable to find %s revision in submodule path '%s'"),
+			    remote_ref, update_data->sm_path);
+
+		free(remote_ref);
+	}
+
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
 		return do_run_update_procedure(update_data);
 
@@ -3389,10 +3396,10 @@ static struct cmd_struct commands[] = {
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
+	/* NEEDSWORK: remote-branch is also obsolete */
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index d48c314f01..29fd69250d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -246,20 +246,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
-# Because arguments are positional, use an empty string to omit <depth>
-# but include <sha1>.
-fetch_in_submodule () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	if test $# -eq 3
-	then
-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
-	else
-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
-	fi
-)
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -396,21 +382,6 @@ cmd_update()
 			just_cloned=
 		fi
 
-		if test -n "$remote"
-		then
-			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
-			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
-			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
-		fi
-
 		out=$(git submodule--helper run-update-procedure \
 			  ${wt_prefix:+--prefix "$wt_prefix"} \
 			  ${GIT_QUIET:+--quiet} \
@@ -421,6 +392,7 @@ cmd_update()
 			  ${update:+--update "$update"} \
 			  ${prefix:+--recursive-prefix "$prefix"} \
 			  ${sha1:+--oid "$sha1"} \
+			  ${remote:+--remote} \
 			  "--" \
 			  "$sm_path")
 
-- 
2.33.GIT


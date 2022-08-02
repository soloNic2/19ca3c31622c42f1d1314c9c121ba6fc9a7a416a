Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644CDC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbiHBPrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiHBPq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2491CFC4
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so18404037wrh.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OQGyNUffDfNdU8jOI/BHEdz/m/0IUD5opA9lyM4N49Q=;
        b=fCIFOVfo3ICaINAL4ZAzQZtxVbH3+0Zcmz5FSSA8C7IEPGNCHZUGSq8aCpGj0dGlTb
         iglBxzkEdJSU0ATANKYIHOD5M/ajSPGMXHxefosyjP4oWYwwgl/w8XivJ3soGUuonnaG
         V9m5eRDWNrb54nCsVmszayEh7nvrw87szLQQ3OzcxsMGl8gUZhCnNWfwmsleq6OJFj0Z
         zDWzDcTch8S9GDFgdNHYAiAc5chL0QajiuxzeBWbg/i1fSpeXXVRE4kUr6M7c6XGSVmH
         nFRtKhQlzcZXjubzqueM2Vaeg6oVFMp7m8BVCb8hvKrZTpp7IwXTovveAcCMizyVFiVa
         LqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OQGyNUffDfNdU8jOI/BHEdz/m/0IUD5opA9lyM4N49Q=;
        b=P+P/RBB/niKTKMBKZbSzoWqih/8Y7hxDH+xHXHLsMG30Rpflmi0nXzZkuW/Fulb1hd
         YqjuXTz6lTpLSR75tBhBcqkPfExfdeUaS9iM1WVzzMDpGkyAr3SzQfOuFWtRgfJ1z/BP
         DaUUFgiOy7NzqnbSVkZTdhgKlLbLoY6uUdAYx//J9DFiK+gYe7WX8A5wJO2ASyhRf18a
         1n5Rgh0Kr/D/HZlEsIGqbcAxBqCNyfMfhFpdG0GZVX4xPsb6T5GtGUmwQqDuksI0p3Xt
         aeHYnokEJdqbreCc4i40du8mHuzn+LbhW7wAN/WgXemh2bACuER1n+atbKF7pIxhi2dU
         cbTQ==
X-Gm-Message-State: ACgBeo32znKes/ucVhAOSV7znx8UotEYOID4EqtFcKttiTtj0tyMtIAG
        22cd6Nb8V/8LoQcdwOSJlp/V/GeeyLOV/A==
X-Google-Smtp-Source: AA6agR5SsN89uwFp9M0XpU6F+HiF5sOjSuAIYXvVC1Zy5rQdo1qqdUhmCvO6dxC2S2iUdJAR/mrE2A==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr14349828wri.39.1659455190823;
        Tue, 02 Aug 2022 08:46:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/28] submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
Date:   Tue,  2 Aug 2022 17:45:58 +0200
Message-Id: <patch-v2-14.28-866b8397a59-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "const" to the "struct module_clone_data" that we pass to
clone_submodule(), which makes the ownership clear, and stops us from
clobbering the "clone_data->path".

We still need to add to the "reference" member, which is a "struct
string_list". Let's do this by having clone_submodule() create its
own, and copy the contents over, allowing us to pass it as a
separate parameter.

This new "struct string_list" still leaks memory, just as the "struct
module_clone_data" did before. let's not fix that for now, to fix that
we'll need to add some "goto cleanup" to the relevant code. That will
eventually be done in follow-up commits, this change makes it easier
to fix the memory leak.

The scope of the new "reference" variable in add_submodule() could be
narrowed to the "else" block, but as we'll eventually free it with a
"goto cleanup" let's declare it at the start of the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 49 ++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fe32abd45e6..6b4ee8a31bb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1434,7 +1434,6 @@ struct module_clone_data {
 	const char *url;
 	const char *depth;
 	struct list_objects_filter_options *filter_options;
-	struct string_list reference;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
@@ -1442,7 +1441,6 @@ struct module_clone_data {
 	int single_branch;
 };
 #define MODULE_CLONE_DATA_INIT { \
-	.reference = STRING_LIST_INIT_NODUP, \
 	.single_branch = -1, \
 }
 
@@ -1569,18 +1567,20 @@ static char *clone_submodule_sm_gitdir(const char *name)
 	return sm_gitdir;
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static int clone_submodule(const struct module_clone_data *clone_data,
+			   struct string_list *reference)
 {
 	char *p;
 	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
 	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
+	const char *clone_data_path;
 
 	if (!is_absolute_path(clone_data->path))
-		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
-					   clone_data->path);
+		clone_data_path = xstrfmt("%s/%s", get_git_work_tree(),
+					  clone_data->path);
 	else
-		clone_data->path = xstrdup(clone_data->path);
+		clone_data_path = xstrdup(clone_data->path);
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
 		die(_("refusing to create/use '%s' in another submodule's "
@@ -1590,7 +1590,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
 
-		prepare_possible_alternates(clone_data->name, &clone_data->reference);
+		prepare_possible_alternates(clone_data->name, reference);
 
 		strvec_push(&cp.args, "clone");
 		strvec_push(&cp.args, "--no-checkout");
@@ -1600,10 +1600,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_push(&cp.args, "--progress");
 		if (clone_data->depth && *(clone_data->depth))
 			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
-		if (clone_data->reference.nr) {
+		if (reference->nr) {
 			struct string_list_item *item;
 
-			for_each_string_list_item(item, &clone_data->reference)
+			for_each_string_list_item(item, reference)
 				strvec_pushl(&cp.args, "--reference",
 					     item->string, NULL);
 		}
@@ -1622,7 +1622,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 		strvec_push(&cp.args, "--");
 		strvec_push(&cp.args, clone_data->url);
-		strvec_push(&cp.args, clone_data->path);
+		strvec_push(&cp.args, clone_data_path);
 
 		cp.git_cmd = 1;
 		prepare_submodule_repo_env(&cp.env);
@@ -1630,25 +1630,25 @@ static int clone_submodule(struct module_clone_data *clone_data)
 
 		if(run_command(&cp))
 			die(_("clone of '%s' into submodule path '%s' failed"),
-			    clone_data->url, clone_data->path);
+			    clone_data->url, clone_data_path);
 	} else {
 		char *path;
 
-		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
-		    !is_empty_dir(clone_data->path))
-			die(_("directory not empty: '%s'"), clone_data->path);
-		if (safe_create_leading_directories_const(clone_data->path) < 0)
-			die(_("could not create directory '%s'"), clone_data->path);
+		if (clone_data->require_init && !access(clone_data_path, X_OK) &&
+		    !is_empty_dir(clone_data_path))
+			die(_("directory not empty: '%s'"), clone_data_path);
+		if (safe_create_leading_directories_const(clone_data_path) < 0)
+			die(_("could not create directory '%s'"), clone_data_path);
 		path = xstrfmt("%s/index", sm_gitdir);
 		unlink_or_warn(path);
 		free(path);
 	}
 
-	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
+	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
-	p = git_pathdup_submodule(clone_data->path, "config");
+	p = git_pathdup_submodule(clone_data_path, "config");
 	if (!p)
-		die(_("could not get submodule directory for '%s'"), clone_data->path);
+		die(_("could not get submodule directory for '%s'"), clone_data_path);
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
 	git_config_get_string("submodule.alternateLocation", &sm_alternate);
@@ -1673,6 +1673,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
+	struct string_list reference = STRING_LIST_INIT_NODUP;
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
 			   N_("path"),
@@ -1686,7 +1687,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "url", &clone_data.url,
 			   N_("string"),
 			   N_("url where to clone the submodule from")),
-		OPT_STRING_LIST(0, "reference", &clone_data.reference,
+		OPT_STRING_LIST(0, "reference", &reference,
 			   N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &dissociate,
@@ -1725,7 +1726,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-	clone_submodule(&clone_data);
+	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
 	return 0;
 }
@@ -2913,6 +2914,7 @@ static int add_submodule(const struct add_data *add_data)
 {
 	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+	struct string_list reference = STRING_LIST_INIT_NODUP;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
@@ -2929,6 +2931,7 @@ static int add_submodule(const struct add_data *add_data)
 		free(submod_gitdir_path);
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
+
 		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
 
 		if (is_directory(submod_gitdir_path)) {
@@ -2968,13 +2971,13 @@ static int add_submodule(const struct add_data *add_data)
 		clone_data.quiet = add_data->quiet;
 		clone_data.progress = add_data->progress;
 		if (add_data->reference_path)
-			string_list_append(&clone_data.reference,
+			string_list_append(&reference,
 					   xstrdup(add_data->reference_path));
 		clone_data.dissociate = add_data->dissociate;
 		if (add_data->depth >= 0)
 			clone_data.depth = xstrfmt("%d", add_data->depth);
 
-		if (clone_submodule(&clone_data))
+		if (clone_submodule(&clone_data, &reference))
 			return -1;
 
 		prepare_submodule_repo_env(&cp.env);
-- 
2.37.1.1233.ge8b09efaedc


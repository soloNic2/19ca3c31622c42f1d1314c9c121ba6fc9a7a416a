Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDAEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFZSMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjFZSLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C1F10D7
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3110ab7110aso4374818f8f.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803096; x=1690395096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5EJrTNr2AloyUYcVShflgYMkCD8X7BuwWrCJ5a3vF0=;
        b=TuN0wwHgiLjZ0XuhZLF9m1pZMbDz2wWiBA6eHad5uknVNcZaughTTY5C13u5QCUzOG
         Du3UbHwm2Dt1VVy4eGj/uUooSdQLIoDZQhSFdBXkQFsgU5KXKvTstnQ1d80mLag//a2N
         vzkAsIuy/xSPOYxdhBADhFGVDDFGTWwRA8pZJlmh0IAZTAO/wKq6pesl++pyPrvX+N3w
         HOQcwt5AOimW1kIzzUHsG2nDBIqbNuj2IfXwnP3YFnGeMaKh09L+n9xxJ5fG0F39uxDY
         YZnz9IAy1GvN95VO3SGTuviyoxUJSkOnvuuh1ZDAXVMbdcq4kAIqSmd6EVHtwXw0+BzV
         pn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803096; x=1690395096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5EJrTNr2AloyUYcVShflgYMkCD8X7BuwWrCJ5a3vF0=;
        b=PxCmjMNkdqTItj2iP466GW9aJi4y4b9LrV5ShGM17DAyld55rWcOPPP12ZAaZr27wh
         EhxF2n/wB0A3Ox4JM5qFsa2hJYzfnDlk8kDjcIJF58cMbP0jV65GGK7IbipD7AQ1kz3P
         nwN2smWV8dyZsaIPj93Hw0r8jR9td2wfBrUdoj1//qyJv3jSiDyDyw/zl8Yv7qxiE/DN
         1whXA/5W9cOS/7K3jbixSeOuBCCMHh8/8OAnn4Q7S5dGpJwUbHoQ6UsIfHhGbnWye+Je
         hT9cb5n14JPczoc8eAgo4tNu91HCU61j/TOjgT63o0vRr40816a/I5/nwVfAERKvsggT
         9GyA==
X-Gm-Message-State: AC+VfDzQz1Oy4Fi1lYnq1CN8PXEzQthoJ1OKbfY3MvYQC+5rruoNop3r
        SafJiuX36B660l7R2f+m+0JcdDSQTEA=
X-Google-Smtp-Source: ACHHUZ7gq6p5QR1sPmcebon7DpuNAS6meLrTZcNbv4AKfyhu3z+GIWLgTV5SIyAm03dsLHN92JjIEA==
X-Received: by 2002:adf:db45:0:b0:313:ee05:46a8 with SMTP id f5-20020adfdb45000000b00313ee0546a8mr4676106wrj.44.1687803095254;
        Mon, 26 Jun 2023 11:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b003095bd71159sm8185309wrn.7.2023.06.26.11.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:34 -0700 (PDT)
Message-Id: <114723ee4a7135897b1c69a6ee859c4921bbe2f3.1687803086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:20 +0000
Subject: [PATCH v4 09/12] config: pass kvi to die_bad_number()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Plumb "struct key_value_info" through all code paths that end in
die_bad_number(), which lets us remove the helper functions that read
analogous values from "struct config_reader". As a result, nothing reads
config_reader.config_kvi any more, so remove that too.

In config.c, this requires changing the signature of
git_configset_get_value() to 'return' "kvi" in an out parameter so that
git_configset_get_<type>() can pass it to git_config_<type>(). Only
numeric types will use "kvi", so for non-numeric types (e.g.
git_configset_get_string()), pass NULL to indicate that the out
parameter isn't needed.

Outside of config.c, config callbacks now need to pass "ctx->kvi" to any
of the git_config_<type>() functions that parse a config string into a
number type. Included is a .cocci patch to make that refactor.

The only exceptional case is builtin/config.c, where git_config_<type>()
is called outside of a config callback (namely, on user-provided input),
so config source information has never been available. In this case,
die_bad_number() defaults to a generic, but perfectly descriptive
message. Let's provide a safe, non-NULL for "kvi" anyway, but make sure
not to change the message.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 archive-tar.c                              |   4 +-
 builtin/commit-graph.c                     |   4 +-
 builtin/commit.c                           |  10 +-
 builtin/config.c                           |  21 +--
 builtin/fetch.c                            |   4 +-
 builtin/fsmonitor--daemon.c                |   6 +-
 builtin/grep.c                             |   2 +-
 builtin/index-pack.c                       |   4 +-
 builtin/log.c                              |   2 +-
 builtin/pack-objects.c                     |  14 +-
 builtin/receive-pack.c                     |  10 +-
 builtin/submodule--helper.c                |   4 +-
 config.c                                   | 156 ++++++++-------------
 config.h                                   |  17 ++-
 contrib/coccinelle/git_config_number.cocci |  27 ++++
 diff.c                                     |   9 +-
 fmt-merge-msg.c                            |   2 +-
 help.c                                     |   4 +-
 http.c                                     |  10 +-
 imap-send.c                                |   2 +-
 sequencer.c                                |  22 +--
 setup.c                                    |   2 +-
 submodule-config.c                         |  13 +-
 submodule-config.h                         |   3 +-
 t/helper/test-config.c                     |   6 +-
 upload-pack.c                              |  12 +-
 worktree.c                                 |   2 +-
 27 files changed, 190 insertions(+), 182 deletions(-)
 create mode 100644 contrib/coccinelle/git_config_number.cocci

diff --git a/archive-tar.c b/archive-tar.c
index ef06e516b1f..3df8af6d1b1 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -412,14 +412,14 @@ static int tar_filter_config(const char *var, const char *value,
 }
 
 static int git_tar_config(const char *var, const char *value,
-			  const struct config_context *ctx UNUSED, void *cb)
+			  const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "tar.umask")) {
 		if (value && !strcmp(value, "user")) {
 			tar_umask = umask(0);
 			umask(tar_umask);
 		} else {
-			tar_umask = git_config_int(var, value);
+			tar_umask = git_config_int(var, value, ctx->kvi);
 		}
 		return 0;
 	}
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 1185c49239a..b071c5ab646 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -186,11 +186,11 @@ static int write_option_max_new_filters(const struct option *opt,
 }
 
 static int git_commit_graph_write_config(const char *var, const char *value,
-					 const struct config_context *ctx UNUSED,
+					 const struct config_context *ctx,
 					 void *cb UNUSED)
 {
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
-		write_opts.max_new_filters = git_config_int(var, value);
+		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
 	/*
 	 * No need to fall-back to 'git_default_config', since this was already
 	 * called in 'cmd_commit_graph()'.
diff --git a/builtin/commit.c b/builtin/commit.c
index 6a2b2503328..9fe691470a3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1415,7 +1415,8 @@ static int git_status_config(const char *k, const char *v,
 		return git_column_config(k, v, "status", &s->colopts);
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
-		s->submodule_summary = git_config_bool_or_int(k, v, &is_bool);
+		s->submodule_summary = git_config_bool_or_int(k, v, ctx->kvi,
+							      &is_bool);
 		if (is_bool && s->submodule_summary)
 			s->submodule_summary = -1;
 		return 0;
@@ -1475,11 +1476,11 @@ static int git_status_config(const char *k, const char *v,
 	}
 	if (!strcmp(k, "diff.renamelimit")) {
 		if (s->rename_limit == -1)
-			s->rename_limit = git_config_int(k, v);
+			s->rename_limit = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "status.renamelimit")) {
-		s->rename_limit = git_config_int(k, v);
+		s->rename_limit = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "diff.renames")) {
@@ -1625,7 +1626,8 @@ static int git_commit_config(const char *k, const char *v,
 	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
-		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
+		config_commit_verbose = git_config_bool_or_int(k, v, ctx->kvi,
+							       &is_bool);
 		return 0;
 	}
 
diff --git a/builtin/config.c b/builtin/config.c
index 9b9f5527311..680269d263c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -262,13 +262,14 @@ static int format_config(struct strbuf *buf, const char *key_,
 
 		if (type == TYPE_INT)
 			strbuf_addf(buf, "%"PRId64,
-				    git_config_int64(key_, value_ ? value_ : ""));
+				    git_config_int64(key_, value_ ? value_ : "", kvi));
 		else if (type == TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
 		else if (type == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
-			v = git_config_bool_or_int(key_, value_, &is_bool);
+			v = git_config_bool_or_int(key_, value_, kvi,
+						   &is_bool);
 			if (is_bool)
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
@@ -424,7 +425,8 @@ free_strings:
 	return ret;
 }
 
-static char *normalize_value(const char *key, const char *value)
+static char *normalize_value(const char *key, const char *value,
+			     struct key_value_info *kvi)
 {
 	if (!value)
 		return NULL;
@@ -439,12 +441,12 @@ static char *normalize_value(const char *key, const char *value)
 		 */
 		return xstrdup(value);
 	if (type == TYPE_INT)
-		return xstrfmt("%"PRId64, git_config_int64(key, value));
+		return xstrfmt("%"PRId64, git_config_int64(key, value, kvi));
 	if (type == TYPE_BOOL)
 		return xstrdup(git_config_bool(key, value) ?  "true" : "false");
 	if (type == TYPE_BOOL_OR_INT) {
 		int is_bool, v;
-		v = git_config_bool_or_int(key, value, &is_bool);
+		v = git_config_bool_or_int(key, value, kvi, &is_bool);
 		if (!is_bool)
 			return xstrfmt("%d", v);
 		else
@@ -674,6 +676,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	char *value = NULL;
 	int flags = 0;
 	int ret = 0;
+	struct key_value_info default_kvi = KVI_INIT;
 
 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
 
@@ -891,7 +894,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET) {
 		check_write();
 		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
@@ -900,7 +903,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_SET_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
 							     flags);
@@ -908,7 +911,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_ADD) {
 		check_write();
 		check_argc(argc, 2, 2);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value,
 							     CONFIG_REGEX_NONE,
@@ -917,7 +920,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
 		check_argc(argc, 2, 3);
-		value = normalize_value(argv[0], argv[1]);
+		value = normalize_value(argv[0], argv[1], &default_kvi);
 		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
 							     argv[0], value, argv[2],
 							     flags | CONFIG_FLAGS_MULTI_REPLACE);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a4aa0fbb8f5..fe86dfeb62a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -137,7 +137,7 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "submodule.fetchjobs")) {
-		fetch_config->submodule_fetch_jobs = parse_submodule_fetchjobs(k, v);
+		fetch_config->submodule_fetch_jobs = parse_submodule_fetchjobs(k, v, ctx->kvi);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
 		fetch_config->recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
@@ -145,7 +145,7 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.parallel")) {
-		fetch_config->parallel = git_config_int(k, v);
+		fetch_config->parallel = git_config_int(k, v, ctx->kvi);
 		if (fetch_config->parallel < 0)
 			die(_("fetch.parallel cannot be negative"));
 		if (!fetch_config->parallel)
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 91a776e2f17..6d2826b07da 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -41,7 +41,7 @@ static int fsmonitor_config(const char *var, const char *value,
 			    const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
-		int i = git_config_int(var, value);
+		int i = git_config_int(var, value, ctx->kvi);
 		if (i < 1)
 			return error(_("value of '%s' out of range: %d"),
 				     FSMONITOR__IPC_THREADS, i);
@@ -50,7 +50,7 @@ static int fsmonitor_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
-		int i = git_config_int(var, value);
+		int i = git_config_int(var, value, ctx->kvi);
 		if (i < 0)
 			return error(_("value of '%s' out of range: %d"),
 				     FSMONITOR__START_TIMEOUT, i);
@@ -60,7 +60,7 @@ static int fsmonitor_config(const char *var, const char *value,
 
 	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
 		int is_bool;
-		int i = git_config_bool_or_int(var, value, &is_bool);
+		int i = git_config_bool_or_int(var, value, ctx->kvi, &is_bool);
 		if (i < 0)
 			return error(_("value of '%s' not bool or int: %d"),
 				     var, i);
diff --git a/builtin/grep.c b/builtin/grep.c
index 757d52b94ec..3a464e6faab 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -301,7 +301,7 @@ static int grep_cmd_config(const char *var, const char *value,
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-		num_threads = git_config_int(var, value);
+		num_threads = git_config_int(var, value, ctx->kvi);
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index de8884ea5c2..e428f6d9a4a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1587,13 +1587,13 @@ static int git_index_pack_config(const char *k, const char *v,
 	struct pack_idx_option *opts = cb;
 
 	if (!strcmp(k, "pack.indexversion")) {
-		opts->version = git_config_int(k, v);
+		opts->version = git_config_int(k, v, ctx->kvi);
 		if (opts->version > 2)
 			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		nr_threads = git_config_int(k, v);
+		nr_threads = git_config_int(k, v, ctx->kvi);
 		if (nr_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    nr_threads);
diff --git a/builtin/log.c b/builtin/log.c
index 09d6a13075b..c7337354aaf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -574,7 +574,7 @@ static int git_log_config(const char *var, const char *value,
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
 	if (!strcmp(var, "format.filenamemaxlength")) {
-		fmt_patch_name_max = git_config_int(var, value);
+		fmt_patch_name_max = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(var, "format.encodeemailheaders")) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 34aa0b483a0..38054a38b2b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3139,23 +3139,23 @@ static int git_pack_config(const char *k, const char *v,
 			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(k, "pack.window")) {
-		window = git_config_int(k, v);
+		window = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.windowmemory")) {
-		window_memory_limit = git_config_ulong(k, v);
+		window_memory_limit = git_config_ulong(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.depth")) {
-		depth = git_config_int(k, v);
+		depth = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachesize")) {
-		max_delta_cache_size = git_config_int(k, v);
+		max_delta_cache_size = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.deltacachelimit")) {
-		cache_max_small_delta_size = git_config_int(k, v);
+		cache_max_small_delta_size = git_config_int(k, v, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(k, "pack.writebitmaphashcache")) {
@@ -3181,7 +3181,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
-		delta_search_threads = git_config_int(k, v);
+		delta_search_threads = git_config_int(k, v, ctx->kvi);
 		if (delta_search_threads < 0)
 			die(_("invalid number of threads specified (%d)"),
 			    delta_search_threads);
@@ -3192,7 +3192,7 @@ static int git_pack_config(const char *k, const char *v,
 		return 0;
 	}
 	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_opts.version = git_config_int(k, v);
+		pack_idx_opts.version = git_config_int(k, v, ctx->kvi);
 		if (pack_idx_opts.version > 2)
 			die(_("bad pack.indexVersion=%"PRIu32),
 			    pack_idx_opts.version);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d9898aff7..98f6f0038f0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -158,12 +158,12 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.unpacklimit") == 0) {
-		receive_unpack_limit = git_config_int(var, value);
+		receive_unpack_limit = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (strcmp(var, "transfer.unpacklimit") == 0) {
-		transfer_unpack_limit = git_config_int(var, value);
+		transfer_unpack_limit = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -231,7 +231,7 @@ static int receive_pack_config(const char *var, const char *value,
 		return git_config_string(&cert_nonce_seed, var, value);
 
 	if (strcmp(var, "receive.certnonceslop") == 0) {
-		nonce_stamp_slop_limit = git_config_ulong(var, value);
+		nonce_stamp_slop_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -246,12 +246,12 @@ static int receive_pack_config(const char *var, const char *value,
 	}
 
 	if (strcmp(var, "receive.keepalive") == 0) {
-		keepalive_in_sec = git_config_int(var, value);
+		keepalive_in_sec = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (strcmp(var, "receive.maxinputsize") == 0) {
-		max_input_size = git_config_int64(var, value);
+		max_input_size = git_config_int64(var, value, ctx->kvi);
 		return 0;
 	}
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f8e9d85e77a..57185cf5f3d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2192,13 +2192,13 @@ static int update_clone_task_finished(int result,
 }
 
 static int git_update_clone_config(const char *var, const char *value,
-				   const struct config_context *ctx UNUSED,
+				   const struct config_context *ctx,
 				   void *cb)
 {
 	int *max_jobs = cb;
 
 	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
+		*max_jobs = parse_submodule_fetchjobs(var, value, ctx->kvi);
 	return 0;
 }
 
diff --git a/config.c b/config.c
index 8546fea370e..a9a45e4ffe0 100644
--- a/config.c
+++ b/config.c
@@ -73,18 +73,8 @@ struct config_reader {
 	 *
 	 * The "source" variable will be non-NULL only when we are actually
 	 * parsing a real config source (file, blob, cmdline, etc).
-	 *
-	 * The "config_kvi" variable will be non-NULL only when we are feeding
-	 * cached config from a configset into a callback.
-	 *
-	 * They cannot be non-NULL at the same time. If they are both NULL, then
-	 * we aren't parsing anything (and depending on the function looking at
-	 * the variables, it's either a bug for it to be called in the first
-	 * place, or it's a function which can be reused for non-config
-	 * purposes, and should fall back to some sane behavior).
 	 */
 	struct config_source *source;
-	struct key_value_info *config_kvi;
 };
 /*
  * Where possible, prefer to accept "struct config_reader" as an arg than to use
@@ -96,8 +86,6 @@ static struct config_reader the_reader;
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
-	if (reader->config_kvi)
-		BUG("source should not be set while iterating a config set");
 	top->prev = reader->source;
 	reader->source = top;
 }
@@ -112,12 +100,6 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 	return ret;
 }
 
-static inline void config_reader_set_kvi(struct config_reader *reader,
-					 struct key_value_info *kvi)
-{
-	reader->config_kvi = kvi;
-}
-
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -1346,80 +1328,78 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
-static int reader_config_name(struct config_reader *reader, const char **out);
-static int reader_origin_type(struct config_reader *reader,
-			      enum config_origin_type *type);
 NORETURN
-static void die_bad_number(struct config_reader *reader, const char *name,
-			   const char *value)
+static void die_bad_number(const char *name, const char *value,
+			   const struct key_value_info *kvi)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
 	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
-	const char *config_name = NULL;
-	enum config_origin_type config_origin = CONFIG_ORIGIN_UNKNOWN;
+
+	if (!kvi)
+		BUG("kvi should not be NULL");
 
 	if (!value)
 		value = "";
 
-	/* Ignoring the return value is okay since we handle missing values. */
-	reader_config_name(reader, &config_name);
-	reader_origin_type(reader, &config_origin);
-
-	if (!config_name)
+	if (!kvi->filename)
 		die(_(bad_numeric), value, name, _(error_type));
 
-	switch (config_origin) {
+	switch (kvi->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
 		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, config_name, _(error_type));
+		    value, name, kvi->filename, _(error_type));
 	}
 }
 
-int git_config_int(const char *name, const char *value)
+int git_config_int(const char *name, const char *value,
+		   const struct key_value_info *kvi)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-int64_t git_config_int64(const char *name, const char *value)
+int64_t git_config_int64(const char *name, const char *value,
+			 const struct key_value_info *kvi)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-unsigned long git_config_ulong(const char *name, const char *value)
+unsigned long git_config_ulong(const char *name, const char *value,
+			       const struct key_value_info *kvi)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
-ssize_t git_config_ssize_t(const char *name, const char *value)
+ssize_t git_config_ssize_t(const char *name, const char *value,
+			   const struct key_value_info *kvi)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(&the_reader, name, value);
+		die_bad_number(name, value, kvi);
 	return ret;
 }
 
@@ -1524,7 +1504,8 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
 
-int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
+int git_config_bool_or_int(const char *name, const char *value,
+			   const struct key_value_info *kvi, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
 	if (0 <= v) {
@@ -1532,7 +1513,7 @@ int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 		return v;
 	}
 	*is_bool = 0;
-	return git_config_int(name, value);
+	return git_config_int(name, value, kvi);
 }
 
 int git_config_bool(const char *name, const char *value)
@@ -1658,7 +1639,7 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (!git_parse_maybe_bool_text(value))
 			default_abbrev = the_hash_algo->hexsz;
 		else {
-			int abbrev = git_config_int(var, value);
+			int abbrev = git_config_int(var, value, ctx->kvi);
 			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
 				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev = abbrev;
@@ -1670,7 +1651,7 @@ static int git_default_core_config(const char *var, const char *value,
 		return set_disambiguate_hint_config(var, value);
 
 	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, ctx->kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -1681,7 +1662,7 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, ctx->kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -1695,7 +1676,7 @@ static int git_default_core_config(const char *var, const char *value,
 
 	if (!strcmp(var, "core.packedgitwindowsize")) {
 		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value);
+		packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
 
 		/* This value must be multiple of (pagesize * 2) */
 		packed_git_window_size /= pgsz_x2;
@@ -1706,17 +1687,17 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.bigfilethreshold")) {
-		big_file_threshold = git_config_ulong(var, value);
+		big_file_threshold = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value);
+		packed_git_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value);
+		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -1995,12 +1976,12 @@ int git_default_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value);
+		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
 	if (!strcmp(var, "pack.compression")) {
-		int level = git_config_int(var, value);
+		int level = git_config_int(var, value, ctx->kvi);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -2344,13 +2325,11 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
 
-		config_reader_set_kvi(reader, values->items[value_index].util);
 		ctx.kvi = values->items[value_index].util;
 		if (fn(entry->key, values->items[value_index].string, &ctx, data) < 0)
 			git_die_config_linenr(entry->key,
 					      ctx.kvi->filename,
 					      ctx.kvi->linenr);
-		config_reader_set_kvi(reader, NULL);
 	}
 }
 
@@ -2534,11 +2513,12 @@ int git_configset_add_file(struct config_set *set, const char *filename)
 	return git_config_from_file(config_set_callback, filename, &data);
 }
 
-int git_configset_get_value(struct config_set *set, const char *key, const char **value)
+int git_configset_get_value(struct config_set *set, const char *key,
+			    const char **value, struct key_value_info *kvi)
 {
 	const struct string_list *values = NULL;
 	int ret;
-
+	struct string_list_item item;
 	/*
 	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
 	 * queried key in the files of the configset, the value returned will be the last
@@ -2548,7 +2528,10 @@ int git_configset_get_value(struct config_set *set, const char *key, const char
 		return ret;
 
 	assert(values->nr > 0);
-	*value = values->items[values->nr - 1].string;
+	item = values->items[values->nr - 1];
+	*value = item.string;
+	if (kvi)
+		*kvi = *((struct key_value_info *)item.util);
 	return 0;
 }
 
@@ -2601,7 +2584,7 @@ int git_configset_get(struct config_set *set, const char *key)
 int git_configset_get_string(struct config_set *set, const char *key, char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value))
+	if (!git_configset_get_value(set, key, &value, NULL))
 		return git_config_string((const char **)dest, key, value);
 	else
 		return 1;
@@ -2611,7 +2594,7 @@ static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 					const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		if (!value)
 			return config_error_nonbool(key);
 		*dest = value;
@@ -2624,8 +2607,10 @@ static int git_configset_get_string_tmp(struct config_set *set, const char *key,
 int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
-		*dest = git_config_int(key, value);
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_int(key, value, &kvi);
 		return 0;
 	} else
 		return 1;
@@ -2634,8 +2619,10 @@ int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
-		*dest = git_config_ulong(key, value);
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_ulong(key, value, &kvi);
 		return 0;
 	} else
 		return 1;
@@ -2644,7 +2631,7 @@ int git_configset_get_ulong(struct config_set *set, const char *key, unsigned lo
 int git_configset_get_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		*dest = git_config_bool(key, value);
 		return 0;
 	} else
@@ -2655,8 +2642,10 @@ int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 				int *is_bool, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
-		*dest = git_config_bool_or_int(key, value, is_bool);
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_bool_or_int(key, value, &kvi, is_bool);
 		return 0;
 	} else
 		return 1;
@@ -2665,7 +2654,7 @@ int git_configset_get_bool_or_int(struct config_set *set, const char *key,
 int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value)) {
+	if (!git_configset_get_value(set, key, &value, NULL)) {
 		*dest = git_parse_maybe_bool(value);
 		if (*dest == -1)
 			return -1;
@@ -2677,7 +2666,7 @@ int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *d
 int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
 {
 	const char *value;
-	if (!git_configset_get_value(set, key, &value))
+	if (!git_configset_get_value(set, key, &value, NULL))
 		return git_config_pathname(dest, key, value);
 	else
 		return 1;
@@ -2747,7 +2736,7 @@ int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value)
 {
 	git_config_check_init(repo);
-	return git_configset_get_value(repo->config, key, value);
+	return git_configset_get_value(repo->config, key, value, NULL);
 }
 
 int repo_config_get_value_multi(struct repository *repo, const char *key,
@@ -3987,18 +3976,6 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-static int reader_origin_type(struct config_reader *reader,
-			      enum config_origin_type *type)
-{
-	if (the_reader.config_kvi)
-		*type = reader->config_kvi->origin_type;
-	else if(the_reader.source)
-		*type = reader->source->origin_type;
-	else
-		return 1;
-	return 0;
-}
-
 const char *config_origin_type_name(enum config_origin_type type)
 {
 	switch (type) {
@@ -4037,17 +4014,6 @@ const char *config_scope_name(enum config_scope scope)
 	}
 }
 
-static int reader_config_name(struct config_reader *reader, const char **out)
-{
-	if (the_reader.config_kvi)
-		*out = reader->config_kvi->filename;
-	else if (the_reader.source)
-		*out = reader->source->name;
-	else
-		return 1;
-	return 0;
-}
-
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
 {
 	int i;
diff --git a/config.h b/config.h
index 82eeba94e71..bd366ddb5ef 100644
--- a/config.h
+++ b/config.h
@@ -249,22 +249,26 @@ int git_parse_maybe_bool(const char *);
  * Parse the string to an integer, including unit factors. Dies on error;
  * otherwise, returns the parsed result.
  */
-int git_config_int(const char *, const char *);
+int git_config_int(const char *, const char *, const struct key_value_info *);
 
-int64_t git_config_int64(const char *, const char *);
+int64_t git_config_int64(const char *, const char *,
+			 const struct key_value_info *);
 
 /**
  * Identical to `git_config_int`, but for unsigned longs.
  */
-unsigned long git_config_ulong(const char *, const char *);
+unsigned long git_config_ulong(const char *, const char *,
+			       const struct key_value_info *);
 
-ssize_t git_config_ssize_t(const char *, const char *);
+ssize_t git_config_ssize_t(const char *, const char *,
+			   const struct key_value_info *);
 
 /**
  * Same as `git_config_bool`, except that integers are returned as-is, and
  * an `is_bool` flag is unset.
  */
-int git_config_bool_or_int(const char *, const char *, int *);
+int git_config_bool_or_int(const char *, const char *,
+			   const struct key_value_info *, int *);
 
 /**
  * Parse a string into a boolean value, respecting keywords like "true" and
@@ -529,7 +533,8 @@ int git_configset_get(struct config_set *cs, const char *key);
  * touching `value`. The caller should not free or modify `value`, as it
  * is owned by the cache.
  */
-int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_value(struct config_set *cs, const char *key,
+			    const char **dest, struct key_value_info *kvi);
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
diff --git a/contrib/coccinelle/git_config_number.cocci b/contrib/coccinelle/git_config_number.cocci
new file mode 100644
index 00000000000..7b57dceefe6
--- /dev/null
+++ b/contrib/coccinelle/git_config_number.cocci
@@ -0,0 +1,27 @@
+@@
+identifier C1, C2, C3;
+@@
+(
+(
+git_config_int
+|
+git_config_int64
+|
+git_config_ulong
+|
+git_config_ssize_t
+)
+  (C1, C2
++ , ctx->kvi
+  )
+|
+(
+git_configset_get_value
+|
+git_config_bool_or_int
+)
+  (C1, C2
++ , ctx->kvi
+ , C3
+  )
+)
diff --git a/diff.c b/diff.c
index 0e382c8f7f0..460211e7d40 100644
--- a/diff.c
+++ b/diff.c
@@ -379,13 +379,14 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.context")) {
-		diff_context_default = git_config_int(var, value);
+		diff_context_default = git_config_int(var, value, ctx->kvi);
 		if (diff_context_default < 0)
 			return -1;
 		return 0;
 	}
 	if (!strcmp(var, "diff.interhunkcontext")) {
-		diff_interhunk_context_default = git_config_int(var, value);
+		diff_interhunk_context_default = git_config_int(var, value,
+								ctx->kvi);
 		if (diff_interhunk_context_default < 0)
 			return -1;
 		return 0;
@@ -411,7 +412,7 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.statgraphwidth")) {
-		diff_stat_graph_width = git_config_int(var, value);
+		diff_stat_graph_width = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(var, "diff.external"))
@@ -450,7 +451,7 @@ int git_diff_basic_config(const char *var, const char *value,
 	const char *name;
 
 	if (!strcmp(var, "diff.renamelimit")) {
-		diff_rename_limit_default = git_config_int(var, value);
+		diff_rename_limit_default = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 10137444321..3ae59bde2f2 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -25,7 +25,7 @@ int fmt_merge_msg_config(const char *key, const char *value,
 {
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
-		merge_log_config = git_config_bool_or_int(key, value, &is_bool);
+		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
 		if (!is_bool && merge_log_config < 0)
 			return error("%s: negative length %s", key, value);
 		if (is_bool && merge_log_config)
diff --git a/help.c b/help.c
index ac0ae5ac0dc..389382b1482 100644
--- a/help.c
+++ b/help.c
@@ -545,7 +545,7 @@ static struct cmdnames aliases;
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
 static int git_unknown_cmd_config(const char *var, const char *value,
-				  const struct config_context *ctx UNUSED,
+				  const struct config_context *ctx,
 				  void *cb UNUSED)
 {
 	const char *p;
@@ -560,7 +560,7 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 		} else if (!strcmp(value, "prompt")) {
 			autocorrect = AUTOCORRECT_PROMPT;
 		} else {
-			int v = git_config_int(var, value);
+			int v = git_config_int(var, value, ctx->kvi);
 			autocorrect = (v < 0)
 				? AUTOCORRECT_IMMEDIATELY : v;
 		}
diff --git a/http.c b/http.c
index 762502828c9..b12b234bde1 100644
--- a/http.c
+++ b/http.c
@@ -414,21 +414,21 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.minsessions", var)) {
-		min_curl_sessions = git_config_int(var, value);
+		min_curl_sessions = git_config_int(var, value, ctx->kvi);
 		if (min_curl_sessions > 1)
 			min_curl_sessions = 1;
 		return 0;
 	}
 	if (!strcmp("http.maxrequests", var)) {
-		max_requests = git_config_int(var, value);
+		max_requests = git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedlimit", var)) {
-		curl_low_speed_limit = (long)git_config_int(var, value);
+		curl_low_speed_limit = (long)git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp("http.lowspeedtime", var)) {
-		curl_low_speed_time = (long)git_config_int(var, value);
+		curl_low_speed_time = (long)git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 
@@ -464,7 +464,7 @@ static int http_options(const char *var, const char *value,
 	}
 
 	if (!strcmp("http.postbuffer", var)) {
-		http_post_buffer = git_config_ssize_t(var, value);
+		http_post_buffer = git_config_ssize_t(var, value, ctx->kvi);
 		if (http_post_buffer < 0)
 			warning(_("negative value for http.postBuffer; defaulting to %d"), LARGE_PACKET_MAX);
 		if (http_post_buffer < LARGE_PACKET_MAX)
diff --git a/imap-send.c b/imap-send.c
index 47777e76861..3518a4ace6c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1342,7 +1342,7 @@ static int git_imap_config(const char *var, const char *val,
 	else if (!strcmp("imap.authmethod", var))
 		return git_config_string(&server.auth_method, var, val);
 	else if (!strcmp("imap.port", var))
-		server.port = git_config_int(var, val);
+		server.port = git_config_int(var, val, ctx->kvi);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			git_die_config("imap.host", "Missing value for 'imap.host'");
diff --git a/sequencer.c b/sequencer.c
index 34754d17596..a0aaee3056d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2883,7 +2883,7 @@ static int git_config_string_dup(char **dest,
 }
 
 static int populate_opts_cb(const char *key, const char *value,
-			    const struct config_context *ctx UNUSED,
+			    const struct config_context *ctx,
 			    void *data)
 {
 	struct replay_opts *opts = data;
@@ -2892,26 +2892,26 @@ static int populate_opts_cb(const char *key, const char *value,
 	if (!value)
 		error_flag = 0;
 	else if (!strcmp(key, "options.no-commit"))
-		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
+		opts->no_commit = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.edit"))
-		opts->edit = git_config_bool_or_int(key, value, &error_flag);
+		opts->edit = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-empty"))
 		opts->allow_empty =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-empty-message"))
 		opts->allow_empty_message =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.keep-redundant-commits"))
 		opts->keep_redundant_commits =
-			git_config_bool_or_int(key, value, &error_flag);
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.signoff"))
-		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
+		opts->signoff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
-		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+		opts->record_origin = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
-		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+		opts->allow_ff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
-		opts->mainline = git_config_int(key, value);
+		opts->mainline = git_config_int(key, value, ctx->kvi);
 	else if (!strcmp(key, "options.strategy"))
 		git_config_string_dup(&opts->strategy, key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
@@ -2920,7 +2920,7 @@ static int populate_opts_cb(const char *key, const char *value,
 		strvec_push(&opts->xopts, value);
 	} else if (!strcmp(key, "options.allow-rerere-auto"))
 		opts->allow_rerere_auto =
-			git_config_bool_or_int(key, value, &error_flag) ?
+			git_config_bool_or_int(key, value, ctx->kvi, &error_flag) ?
 				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
 	else if (!strcmp(key, "options.default-msg-cleanup")) {
 		opts->explicit_cleanup = 1;
diff --git a/setup.c b/setup.c
index fadba5bab4b..ca80fb464bb 100644
--- a/setup.c
+++ b/setup.c
@@ -597,7 +597,7 @@ static int check_repo_format(const char *var, const char *value,
 	const char *ext;
 
 	if (strcmp(var, "core.repositoryformatversion") == 0)
-		data->version = git_config_int(var, value);
+		data->version = git_config_int(var, value, ctx->kvi);
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		switch (handle_extension_v0(var, value, ext, data)) {
 		case EXTENSION_ERROR:
diff --git a/submodule-config.c b/submodule-config.c
index 3f25bd13674..54be580e2a9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -304,9 +304,10 @@ static int parse_fetch_recurse(const char *opt, const char *arg,
 	}
 }
 
-int parse_submodule_fetchjobs(const char *var, const char *value)
+int parse_submodule_fetchjobs(const char *var, const char *value,
+			      const struct key_value_info *kvi)
 {
-	int fetchjobs = git_config_int(var, value);
+	int fetchjobs = git_config_int(var, value, kvi);
 	if (fetchjobs < 0)
 		die(_("negative values not allowed for submodule.fetchJobs"));
 	if (!fetchjobs)
@@ -849,14 +850,14 @@ struct fetch_config {
 };
 
 static int gitmodules_fetch_config(const char *var, const char *value,
-				   const struct config_context *ctx UNUSED,
+				   const struct config_context *ctx,
 				   void *cb)
 {
 	struct fetch_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
 		if (config->max_children)
 			*(config->max_children) =
-				parse_submodule_fetchjobs(var, value);
+				parse_submodule_fetchjobs(var, value, ctx->kvi);
 		return 0;
 	} else if (!strcmp(var, "fetch.recursesubmodules")) {
 		if (config->recurse_submodules)
@@ -878,12 +879,12 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 }
 
 static int gitmodules_update_clone_config(const char *var, const char *value,
-					  const struct config_context *ctx UNUSED,
+					  const struct config_context *ctx,
 					  void *cb)
 {
 	int *max_jobs = cb;
 	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
+		*max_jobs = parse_submodule_fetchjobs(var, value, ctx->kvi);
 	return 0;
 }
 
diff --git a/submodule-config.h b/submodule-config.h
index c2045875bbb..2a37689cc27 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -50,7 +50,8 @@ struct repository;
 
 void submodule_cache_free(struct submodule_cache *cache);
 
-int parse_submodule_fetchjobs(const char *var, const char *value);
+int parse_submodule_fetchjobs(const char *var, const char *value,
+			      const struct key_value_info *kvi);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 int option_fetch_parse_recurse_submodules(const struct option *opt,
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 3f4c3678318..ed444ca4c25 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -63,12 +63,12 @@ static int iterate_cb(const char *var, const char *value,
 }
 
 static int parse_int_cb(const char *var, const char *value,
-			const struct config_context *ctx UNUSED, void *data)
+			const struct config_context *ctx, void *data)
 {
 	const char *key_to_match = data;
 
 	if (!strcmp(key_to_match, var)) {
-		int parsed = git_config_int(value, value);
+		int parsed = git_config_int(value, value, ctx->kvi);
 		printf("%d\n", parsed);
 	}
 	return 0;
@@ -182,7 +182,7 @@ int cmd__config(int argc, const char **argv)
 				goto exit2;
 			}
 		}
-		if (!git_configset_get_value(&cs, argv[2], &v)) {
+		if (!git_configset_get_value(&cs, argv[2], &v, NULL)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
diff --git a/upload-pack.c b/upload-pack.c
index 951fd1f9c25..c03415a5460 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1275,7 +1275,8 @@ static int find_symref(const char *refname,
 }
 
 static int parse_object_filter_config(const char *var, const char *value,
-				       struct upload_pack_data *data)
+				      const struct key_value_info *kvi,
+				      struct upload_pack_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	const char *sub, *key;
@@ -1302,7 +1303,8 @@ static int parse_object_filter_config(const char *var, const char *value,
 		}
 		string_list_insert(&data->allowed_filters, buf.buf)->util =
 			(void *)(intptr_t)1;
-		data->tree_filter_max_depth = git_config_ulong(var, value);
+		data->tree_filter_max_depth = git_config_ulong(var, value,
+							       kvi);
 	}
 
 	strbuf_release(&buf);
@@ -1310,7 +1312,7 @@ static int parse_object_filter_config(const char *var, const char *value,
 }
 
 static int upload_pack_config(const char *var, const char *value,
-			      const struct config_context *ctx UNUSED,
+			      const struct config_context *ctx,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
@@ -1331,7 +1333,7 @@ static int upload_pack_config(const char *var, const char *value,
 		else
 			data->allow_uor &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		data->keepalive = git_config_int(var, value);
+		data->keepalive = git_config_int(var, value, ctx->kvi);
 		if (!data->keepalive)
 			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
@@ -1346,7 +1348,7 @@ static int upload_pack_config(const char *var, const char *value,
 		data->advertise_sid = git_config_bool(var, value);
 	}
 
-	if (parse_object_filter_config(var, value, data) < 0)
+	if (parse_object_filter_config(var, value, ctx->kvi, data) < 0)
 		return -1;
 
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
diff --git a/worktree.c b/worktree.c
index c448fecd4b3..af277ec9010 100644
--- a/worktree.c
+++ b/worktree.c
@@ -835,7 +835,7 @@ int init_worktree_config(struct repository *r)
 	 * Relocate that value to avoid breaking all worktrees with this
 	 * upgrade to worktree config.
 	 */
-	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree)) {
+	if (!git_configset_get_value(&cs, "core.worktree", &core_worktree, NULL)) {
 		if ((res = move_config_setting("core.worktree", core_worktree,
 					       common_config_file,
 					       main_worktree_file)))
-- 
gitgitgadget


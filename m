Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D258EEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFTToK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFTToE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213CDE7D
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b258f3d8so21236505e9.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290240; x=1689882240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rSfGlmxJNHhdlSufqL6bRGfSLu1YpnYdKRtECKPkXc=;
        b=ITtSGUJhQe8cbLZfcjYodVff9038Xx2jVwLQtNCWI6e/tp7BPcxwMhCaitugu0y56G
         XWpeNjZ1WekTzZVrcIJyma6RiDWldXCOX4R9/piQVc78g9oI2HV07s5r9cbWxgBYxrnV
         KCt4CqgLzPr/mv0wylLUOhV+jwZD9DsTxzKHN7xJwkl2tAm+CY9Qh5Y1lsK7UF3cEAsq
         fTy8jmu9moc8CDCc874XWwMyXfTunsEYtFaFM2U1KtF3r+97XAC8msXUy7ppR72+VuDS
         9DBVbfn53IxCCvbApra8I3ACLaojvY3DmeGausE0EOqA8H+SlOHCdPKrVZwp7AFlT+P6
         yb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290240; x=1689882240;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rSfGlmxJNHhdlSufqL6bRGfSLu1YpnYdKRtECKPkXc=;
        b=dYm+lC3oLvJqMztELvI1TgXSHr64iQVRpZ/U7RYqCiewMGyIfKejr3KDxVvckbIU+j
         5JQsBtF9UiJPDAxL2xJeCeU7Cb9GYCTA5JsAIhjvQJ+X2eTRrX+E1lKJOKEsXc4YI0UI
         VSB5+llroqSiCCF7/M3ZsnEE939YJNHPovE2KkV9XRI7/zZDdZZB2nrxGMorMeszI+2h
         0uCr4DBQeW1MfdreReRcMBcLNfzVSqknJJpMKDCHXoswWDPU19bDwQoTnLeU6KW0Jq9l
         Z3cSa7a8i0sfwGjaJ15PYx9up2mq0OVtv98WamNJapn3CySDtRS2Qxf8UcwioCH08g7+
         C6FA==
X-Gm-Message-State: AC+VfDwd4K3Gq+N+UG5XeyNhE4prI3PRfYAL9IkkleF6HagOHV2F5Ec/
        ezHW8MB1/8HW95vIM7yEC9HoRw6zVhI=
X-Google-Smtp-Source: ACHHUZ7viNQA4hM/t5VCQ1MEWfSQgoHLzZpZbfnBASwZw/r6bQVbfmM4wkO1dIDEuUlV4jhcY3ul9w==
X-Received: by 2002:a1c:ed10:0:b0:3f7:e660:cdc5 with SMTP id l16-20020a1ced10000000b003f7e660cdc5mr11285409wmh.9.1687290240253;
        Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bcb8c000000b003f9b66a9376sm2945659wmi.42.2023.06.20.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
Message-Id: <595e7d2e163dc0333300bb20f82cc42177642a9e.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:44 +0000
Subject: [PATCH v3 05/12] config: pass ctx with config files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Pass config_context to config_callbacks when parsing config files. To
provide the .kvi member, refactor out the configset logic that caches
"struct config_source" and "enum config_scope" as a "struct
key_value_info". Make the "enum config_scope" available to the config
file machinery by plumbing an additional arg through
git_config_from_file_with_options().

We do not exercise ctx yet because the remaining current_config_*()
callers may be used with config_with_options(), which may read config
from parameters, but parameters don't pass ctx yet.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 bundle-uri.c       |   1 +
 config.c           | 105 ++++++++++++++++++++++++++++++---------------
 config.h           |   8 ++--
 fsck.c             |   3 +-
 submodule-config.c |   5 ++-
 5 files changed, 81 insertions(+), 41 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 0d5acc3dc51..64f32387745 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -255,6 +255,7 @@ int bundle_uri_parse_config_format(const char *uri,
 	}
 	result = git_config_from_file_with_options(config_to_bundle_list,
 						   filename, list,
+						   CONFIG_SCOPE_UNKNOWN,
 						   &opts);
 
 	if (!result && list->mode == BUNDLE_MODE_NONE) {
diff --git a/config.c b/config.c
index 1e146c861b1..79a6e7cce7e 100644
--- a/config.c
+++ b/config.c
@@ -258,7 +258,9 @@ static int handle_path_include(struct config_source *cs, const char *path,
 			    !cs ? "<unknown>" :
 			    cs->name ? cs->name :
 			    "the command line");
-		ret = git_config_from_file(git_config_include, path, inc);
+		ret = git_config_from_file_with_options(git_config_include, path, inc,
+							current_config_scope(),
+							NULL);
 		inc->depth--;
 	}
 cleanup:
@@ -501,7 +503,7 @@ static int git_config_include(const char *var, const char *value,
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, NULL, inc->data);
+	ret = inc->fn(var, value, ctx, inc->data);
 	if (ret < 0)
 		return ret;
 
@@ -937,12 +939,15 @@ static char *parse_value(struct config_source *cs)
 	}
 }
 
-static int get_value(struct config_source *cs, config_fn_t fn, void *data,
-		     struct strbuf *name)
+static int get_value(struct config_source *cs, struct key_value_info *kvi,
+		     config_fn_t fn, void *data, struct strbuf *name)
 {
 	int c;
 	char *value;
 	int ret;
+	struct config_context ctx = {
+		.kvi = kvi,
+	};
 
 	/* Get the full name */
 	for (;;) {
@@ -971,7 +976,8 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
 	 * accurate line number in error messages.
 	 */
 	cs->linenr--;
-	ret = fn(name->buf, value, NULL, data);
+	kvi->linenr = cs->linenr;
+	ret = fn(name->buf, value, &ctx, data);
 	if (ret >= 0)
 		cs->linenr++;
 	return ret;
@@ -1070,8 +1076,19 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 	return 0;
 }
 
+static void kvi_from_source(struct config_source *cs,
+			    enum config_scope scope,
+			    struct key_value_info *out)
+{
+	out->filename = strintern(cs->name);
+	out->origin_type = cs->origin_type;
+	out->linenr = cs->linenr;
+	out->scope = scope;
+}
+
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
-			    void *data, const struct config_options *opts)
+			    struct key_value_info *kvi, void *data,
+			    const struct config_options *opts)
 {
 	int comment = 0;
 	size_t baselen = 0;
@@ -1155,7 +1172,7 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
 		 */
 		strbuf_setlen(var, baselen);
 		strbuf_addch(var, tolower(c));
-		if (get_value(cs, fn, data, var) < 0)
+		if (get_value(cs, kvi, fn, data, var) < 0)
 			break;
 	}
 
@@ -2013,9 +2030,11 @@ int git_default_config(const char *var, const char *value,
  * this function.
  */
 static int do_config_from(struct config_reader *reader,
-			  struct config_source *top, config_fn_t fn, void *data,
+			  struct config_source *top, config_fn_t fn,
+			  void *data, enum config_scope scope,
 			  const struct config_options *opts)
 {
+	struct key_value_info kvi = KVI_INIT;
 	int ret;
 
 	/* push config-file parsing state stack */
@@ -2025,8 +2044,9 @@ static int do_config_from(struct config_reader *reader,
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
 	config_reader_push_source(reader, top);
+	kvi_from_source(top, scope, &kvi);
 
-	ret = git_parse_source(top, fn, data, opts);
+	ret = git_parse_source(top, fn, &kvi, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -2040,7 +2060,8 @@ static int do_config_from_file(struct config_reader *reader,
 			       config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
-			       void *data, const struct config_options *opts)
+			       void *data, enum config_scope scope,
+			       const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -2055,19 +2076,20 @@ static int do_config_from_file(struct config_reader *reader,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(reader, &top, fn, data, opts);
+	ret = do_config_from(reader, &top, fn, data, scope, opts);
 	funlockfile(f);
 	return ret;
 }
 
-static int git_config_from_stdin(config_fn_t fn, void *data)
+static int git_config_from_stdin(config_fn_t fn, void *data,
+				 enum config_scope scope)
 {
 	return do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_STDIN, "",
-				   NULL, stdin, data, NULL);
+				   NULL, stdin, data, scope, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
-				      void *data,
+				      void *data, enum config_scope scope,
 				      const struct config_options *opts)
 {
 	int ret = -1;
@@ -2078,7 +2100,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		ret = do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_FILE,
-					  filename, filename, f, data, opts);
+					  filename, filename, f, data, scope,
+					  opts);
 		fclose(f);
 	}
 	return ret;
@@ -2086,13 +2109,15 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
-	return git_config_from_file_with_options(fn, filename, data, NULL);
+	return git_config_from_file_with_options(fn, filename, data,
+						 CONFIG_SCOPE_UNKNOWN, NULL);
 }
 
 int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type origin_type,
 			const char *name, const char *buf, size_t len,
-			void *data, const struct config_options *opts)
+			void *data, enum config_scope scope,
+			const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 
@@ -2107,14 +2132,15 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&the_reader, &top, fn, data, opts);
+	return do_config_from(&the_reader, &top, fn, data, scope, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
 			      const char *name,
 			      struct repository *repo,
 			      const struct object_id *oid,
-			      void *data)
+			      void *data,
+			      enum config_scope scope)
 {
 	enum object_type type;
 	char *buf;
@@ -2130,7 +2156,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	}
 
 	ret = git_config_from_mem(fn, CONFIG_ORIGIN_BLOB, name, buf, size,
-				  data, NULL);
+				  data, scope, NULL);
 	free(buf);
 
 	return ret;
@@ -2139,13 +2165,14 @@ int git_config_from_blob_oid(config_fn_t fn,
 static int git_config_from_blob_ref(config_fn_t fn,
 				    struct repository *repo,
 				    const char *name,
-				    void *data)
+				    void *data,
+				    enum config_scope scope)
 {
 	struct object_id oid;
 
 	if (repo_get_oid(repo, name, &oid) < 0)
 		return error(_("unable to resolve config blob '%s'"), name);
-	return git_config_from_blob_oid(fn, name, repo, &oid, data);
+	return git_config_from_blob_oid(fn, name, repo, &oid, data, scope);
 }
 
 char *git_system_config(void)
@@ -2220,27 +2247,34 @@ static int do_git_config_sequence(struct config_reader *reader,
 	if (git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
-		ret += git_config_from_file(fn, system_config, data);
+		ret += git_config_from_file_with_options(fn, system_config,
+							 data, CONFIG_SCOPE_SYSTEM,
+							 NULL);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
 	git_global_config(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file(fn, xdg_config, data);
+		ret += git_config_from_file_with_options(fn, xdg_config, data,
+							 CONFIG_SCOPE_GLOBAL, NULL);
 
 	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file(fn, user_config, data);
+		ret += git_config_from_file_with_options(fn, user_config, data,
+							 CONFIG_SCOPE_GLOBAL, NULL);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
-		ret += git_config_from_file(fn, repo_config, data);
+		ret += git_config_from_file_with_options(fn, repo_config, data,
+							 CONFIG_SCOPE_LOCAL, NULL);
 
 	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
 	if (!opts->ignore_worktree && repository_format_worktree_config) {
 		char *path = git_pathdup("config.worktree");
 		if (!access_or_die(path, R_OK, 0))
-			ret += git_config_from_file(fn, path, data);
+			ret += git_config_from_file_with_options(fn, path, data,
+								 CONFIG_SCOPE_WORKTREE,
+								 NULL);
 		free(path);
 	}
 
@@ -2282,14 +2316,16 @@ int config_with_options(config_fn_t fn, void *data,
 	 * regular lookup sequence.
 	 */
 	if (config_source && config_source->use_stdin) {
-		ret = git_config_from_stdin(fn, data);
+		ret = git_config_from_stdin(fn, data, config_source->scope);
 	} else if (config_source && config_source->file) {
-		ret = git_config_from_file(fn, config_source->file, data);
+		ret = git_config_from_file_with_options(fn, config_source->file,
+							data, config_source->scope,
+							NULL);
 	} else if (config_source && config_source->blob) {
 		struct repository *repo = config_source->repo ?
 			config_source->repo : the_repository;
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
-						data);
+					       data, config_source->scope);
 	} else {
 		ret = do_git_config_sequence(&the_reader, opts, fn, data);
 	}
@@ -2432,16 +2468,14 @@ static int configset_add_value(struct config_reader *reader,
 	if (!reader->source)
 		BUG("configset_add_value has no source");
 	if (reader->source->name) {
-		kv_info->filename = strintern(reader->source->name);
-		kv_info->linenr = reader->source->linenr;
-		kv_info->origin_type = reader->source->origin_type;
+		kvi_from_source(reader->source, current_config_scope(), kv_info);
 	} else {
 		/* for values read from `git_config_from_parameters()` */
 		kv_info->filename = NULL;
 		kv_info->linenr = -1;
 		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
+		kv_info->scope = reader->parsing_scope;
 	}
-	kv_info->scope = reader->parsing_scope;
 	si->util = kv_info;
 
 	return 0;
@@ -3482,7 +3516,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 */
 		if (git_config_from_file_with_options(store_aux,
 						      config_filename,
-						      &store, &opts)) {
+						      &store, CONFIG_SCOPE_UNKNOWN,
+						      &opts)) {
 			error(_("invalid config file %s"), config_filename);
 			ret = CONFIG_INVALID_FILE;
 			goto out_free;
diff --git a/config.h b/config.h
index b4236e120a8..1fc746c3a46 100644
--- a/config.h
+++ b/config.h
@@ -170,16 +170,18 @@ int git_default_config(const char *, const char *,
 int git_config_from_file(config_fn_t fn, const char *, void *);
 
 int git_config_from_file_with_options(config_fn_t fn, const char *,
-				      void *,
+				      void *, enum config_scope,
 				      const struct config_options *);
 int git_config_from_mem(config_fn_t fn,
 			const enum config_origin_type,
 			const char *name,
 			const char *buf, size_t len,
-			void *data, const struct config_options *opts);
+			void *data, enum config_scope scope,
+			const struct config_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     struct repository *repo,
-			     const struct object_id *oid, void *data);
+			     const struct object_id *oid, void *data,
+			     enum config_scope scope);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
diff --git a/fsck.c b/fsck.c
index 55b6a694853..f92c216fb5c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1238,7 +1238,8 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 		data.ret = 0;
 		config_opts.error_action = CONFIG_ERROR_SILENT;
 		if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
-					".gitmodules", buf, size, &data, &config_opts))
+					".gitmodules", buf, size, &data,
+					CONFIG_SCOPE_UNKNOWN, &config_opts))
 			data.ret |= report(options, oid, OBJ_BLOB,
 					FSCK_MSG_GITMODULES_PARSE,
 					"could not parse gitmodules blob");
diff --git a/submodule-config.c b/submodule-config.c
index b364244102e..e19ab593aa4 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -606,7 +606,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.gitmodules_oid = &oid;
 	parameter.overwrite = 0;
 	git_config_from_mem(parse_config, CONFIG_ORIGIN_SUBMODULE_BLOB, rev.buf,
-			config, config_size, &parameter, NULL);
+			    config, config_size, &parameter, CONFIG_SCOPE_UNKNOWN, NULL);
 	strbuf_release(&rev);
 	free(config);
 
@@ -715,7 +715,8 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
 		git_config_from_blob_oid(gitmodules_cb, rev.buf,
-					 the_repository, &oid, the_repository);
+					 the_repository, &oid, the_repository,
+					 CONFIG_SCOPE_UNKNOWN);
 	}
 	strbuf_release(&rev);
 
-- 
gitgitgadget


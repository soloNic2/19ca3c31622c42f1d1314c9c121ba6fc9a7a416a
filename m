Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7772FC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbjELVe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbjELVes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:34:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0435A3
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso24216335e9.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683927285; x=1686519285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El/lj9J98x3Q2ivutJo6u6Nr2YTnt8hvvTJl+hDQGpM=;
        b=q7ESg+31zypfQO8LMSNhAJW5xvDjpFMnNAOfILXq4UZzk1YZb2GLQCFOwUsUHYVTpa
         9nYe0yog0HhEwK3Vd5nYT24lfIqXBGuRjkWK//4iBPqwWrvyJXjet/VG/usehjgv7frK
         Qv3WJFT6JVMrgINhF5yKiO/H3I5MPeiVtrFYid83XmzYjGo0yFmoZG0xowcaxIvI/i04
         K4YT3uZniQs1neSFfAd0/aRYXPXoqon5A4QqIhmV1uhvWe308zl3lUOoHoHjKVg30hwr
         50kPU0dPRFIdHMfDEwVxhB+T5BS25yhO0UJLUp9FoZW4nVbZ8/0QayB5NgFUOHjERfZz
         NI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927285; x=1686519285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El/lj9J98x3Q2ivutJo6u6Nr2YTnt8hvvTJl+hDQGpM=;
        b=LTc/E+m4Exa6xrmBUCxOz7D/YNMtl7E4HNKSqalnPq2UxL934bi0SMSbkk8QgsKiBj
         F3tTTWVEq1FM9QH320RWdg1Htl9so/XRqA+XrJ6kzq+yUm0Wcc0b0SUsYa2IXqw3XiIS
         AgTXwVjcLX8ao9TQCC61ttE69r2elBjPlCUFOZ1cT8q571Iy+91BTUdMd71k1Gq7x0Iz
         2qqeYN9qKxrRPBoqnUrpKIgAkDueInAjPHLE0/t4oYQolawycfZx8cH/9rLgpo36DdIb
         QdPy0NePpZAUE7FJfwSmWJ/dH5JC4zhFttDhxHtPwMdFF6hbq4p36BLKdMoVvE4IEqMv
         MT0w==
X-Gm-Message-State: AC+VfDxBs/ZPKfzVjcOTcb8ekqzL9cQmIif/kYWjavSR+O2yk4q7eT0g
        YYd65GWQ0JIc4el8QrKfwASZJ58VSqc=
X-Google-Smtp-Source: ACHHUZ6PxAccyjCnFiLNWa5bFG/O6Rlz921SjbOEX0DgKOKx67s9zYLXAEyjqans0N249BxmeoLfYw==
X-Received: by 2002:a7b:c314:0:b0:3ef:6b97:f0c3 with SMTP id k20-20020a7bc314000000b003ef6b97f0c3mr18626880wmj.15.1683927284550;
        Fri, 12 May 2023 14:34:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9-20020adff789000000b002c71b4d476asm24674691wrp.106.2023.05.12.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:34:44 -0700 (PDT)
Message-Id: <69300845df151f7deaf76f57ef3e796217a0c67b.1683927282.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
References: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
        <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 21:34:41 +0000
Subject: [PATCH v4 2/3] pack-refs: teach --exclude option to exclude refs from
 being packed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

At GitLab, we have a system that creates ephemeral internal refs that
don't live long before getting deleted. Having an option to exclude
certain refs from a packed-refs file allows these internal references to
be deleted much more efficiently.

Add an --exclude option to the pack-refs builtin, and use the ref
exclusions API to exclude certain refs from being packed into the final
packed-refs file

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-pack-refs.txt | 12 +++++++++++-
 builtin/pack-refs.c             | 20 ++++++++++++++++----
 refs.c                          |  4 ++--
 refs.h                          |  7 ++++++-
 refs/debug.c                    |  4 ++--
 refs/files-backend.c            | 16 ++++++++++------
 refs/packed-backend.c           |  2 +-
 refs/refs-internal.h            |  3 ++-
 revision.h                      |  2 +-
 t/helper/test-ref-store.c       |  3 ++-
 t/t3210-pack-refs.sh            | 16 ++++++++++++++++
 11 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 22f00665006..546aa122dff 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
 SYNOPSIS
 --------
 [verse]
-'git pack-refs' [--all] [--no-prune]
+'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -60,6 +60,16 @@ with many branches of historical interests.
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
 
+--exclude <pattern>::
+
+Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
+accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
+patterns. If a ref is already packed, including it with `--exclude` will not
+unpack it.
+
+When used with `--all`, pack only loose refs which do not match any of
+the provided `--exclude` patterns.
+
 
 BUGS
 ----
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 9833815fb30..1d1a64fe386 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -4,22 +4,34 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
+#include "revision.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune]"),
+	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
 	NULL
 };
 
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
+	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
+	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+
 	struct option opts[] = {
-		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
-		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
+		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
+			N_("references to exclude")),
 		OPT_END(),
 	};
 	git_config(git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return refs_pack_refs(get_main_ref_store(the_repository), flags);
+
+	for_each_string_list_item(item, &option_excluded_refs)
+		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
+
+	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
 }
diff --git a/refs.c b/refs.c
index d2a98e1c21f..881a0da65cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2132,9 +2132,9 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
 }
 
 /* backend functions */
-int refs_pack_refs(struct ref_store *refs, unsigned int flags)
+int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
 {
-	return refs->be->pack_refs(refs, flags);
+	return refs->be->pack_refs(refs, opts);
 }
 
 int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
diff --git a/refs.h b/refs.h
index 123cfa44244..46020bd335c 100644
--- a/refs.h
+++ b/refs.h
@@ -63,6 +63,11 @@ struct worktree;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
+struct pack_refs_opts {
+	unsigned int flags;
+	struct ref_exclusions *exclusions;
+};
+
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
@@ -405,7 +410,7 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
  */
-int refs_pack_refs(struct ref_store *refs, unsigned int flags);
+int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
 
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
diff --git a/refs/debug.c b/refs/debug.c
index 6f11e6de46c..c0fa707a1da 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -123,10 +123,10 @@ static int debug_initial_transaction_commit(struct ref_store *refs,
 	return res;
 }
 
-static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->pack_refs(drefs->refs, flags);
+	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
 	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
 	return res;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bca7b851c5a..5075e6c0d28 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -21,6 +21,7 @@
 #include "../worktree.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
+#include "../revision.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
@@ -1175,15 +1176,18 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
  */
 static int should_pack_ref(const char *refname,
 			   const struct object_id *oid, unsigned int ref_flags,
-			   unsigned int pack_flags)
+			   struct pack_refs_opts *opts)
 {
 	/* Do not pack per-worktree refs: */
 	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
 	    REF_WORKTREE_SHARED)
 		return 0;
 
+	if (ref_excluded(opts->exclusions, refname))
+		return 0;
+
 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
-	if (!(pack_flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
+	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
 		return 0;
 
 	/* Do not pack symbolic refs: */
@@ -1197,7 +1201,8 @@ static int should_pack_ref(const char *refname,
 	return 1;
 }
 
-static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
+static int files_pack_refs(struct ref_store *ref_store,
+			   struct pack_refs_opts *opts)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
@@ -1222,8 +1227,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 		 * in the packed ref cache. If the reference should be
 		 * pruned, also add it to refs_to_prune.
 		 */
-		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
-				     flags))
+		if (!should_pack_ref(iter->refname, iter->oid, iter->flags, opts))
 			continue;
 
 		/*
@@ -1237,7 +1241,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 			    iter->refname, err.buf);
 
 		/* Schedule the loose reference for pruning if requested. */
-		if ((flags & PACK_REFS_PRUNE)) {
+		if ((opts->flags & PACK_REFS_PRUNE)) {
 			struct ref_to_prune *n;
 			FLEX_ALLOC_STR(n, name, iter->refname);
 			oidcpy(&n->oid, iter->oid);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5b412a133be..291e53f5cfe 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1577,7 +1577,7 @@ static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 }
 
 static int packed_pack_refs(struct ref_store *ref_store UNUSED,
-			    unsigned int flags UNUSED)
+			    struct pack_refs_opts *pack_opts UNUSED)
 {
 	/*
 	 * Packed refs are already packed. It might be that loose refs
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a85d113123c..f72b7be8941 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -547,7 +547,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
-typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int pack_refs_fn(struct ref_store *ref_store,
+			 struct pack_refs_opts *opts);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
diff --git a/revision.h b/revision.h
index 31828748dc0..25776af3815 100644
--- a/revision.h
+++ b/revision.h
@@ -87,7 +87,7 @@ struct rev_cmdline_info {
 struct ref_exclusions {
 	/*
 	 * Excluded refs is a list of wildmatch patterns. If any of the
-	 * patterns matches, the reference will be excluded.
+	 * patterns match, the reference will be excluded.
 	 */
 	struct string_list excluded_refs;
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 6d8f844e9c7..de4197708d9 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -116,8 +116,9 @@ static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
+	struct pack_refs_opts pack_opts = { .flags = flags };
 
-	return refs_pack_refs(refs, flags);
+	return refs_pack_refs(refs, &pack_opts);
 }
 
 static int cmd_create_symref(struct ref_store *refs, const char **argv)
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 07a0ff93def..925b90cd3ba 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -108,6 +108,22 @@ test_expect_success \
      git branch -d n/o/p &&
      git branch n'
 
+test_expect_success 'test excluded refs are not packed' '
+	git branch dont_pack1 &&
+	git branch dont_pack2 &&
+	git branch pack_this &&
+	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
+	test -f .git/refs/heads/dont_pack1 &&
+	test -f .git/refs/heads/dont_pack2 &&
+	! test -f .git/refs/heads/pack_this'
+
+test_expect_success 'test --no-exclude refs clears excluded refs' '
+	git branch dont_pack3 &&
+	git branch dont_pack4 &&
+	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude &&
+	! test -f .git/refs/heads/dont_pack3 &&
+	! test -f .git/refs/heads/dont_pack4'
+
 test_expect_success \
 	'see if up-to-date packed refs are preserved' \
 	'git branch q &&
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521AEEB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGJVMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGJVM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A3E6D
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:25 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-576a9507a9bso89210367b3.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023544; x=1691615544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjrkiGfUCzQPf2L9v0euYLFsTSJJ7KAZPw4ucV5ZStE=;
        b=CIOEWLykKiZMq4hfVTuW9DF04DpgbKXtwo7e2CXSCi1HPeQrDaXz7n608KnFfZLNIc
         g0EiouJCEKN4FuS80vpW9zCudatd64mujqrIHDdX07d79ZcwPOFQG38h4cnOFK4XgJsP
         0TFHQRCd+dvfn8vTaY7CnvMAqd0YPzCQgSJLh7YCx+1UGagvzvBLKNzN5gVaWAwD3c2P
         KAsZm0HAft544bvwo8W8vua/L5+t1AcNilk6iTIdlkeUN9HPeluxYPNYbgYGQw7WOfVN
         MEKp6rcDr8GUkMBIKqV9+4khzT4UHE2NlSy0Qwh8YWWfC+WFKBCpFQCrQTvFunofa5lC
         Zrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023544; x=1691615544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjrkiGfUCzQPf2L9v0euYLFsTSJJ7KAZPw4ucV5ZStE=;
        b=fpfXU5lvk7QaPkPR+LrwO6/cGRiHTIw02/oJK7Xu4ejPlvennTGs+1ZF4GoEOotS/y
         OojgaGJnV1DwQdM3WnO0r5XsFK3I+PW7DokWdrNpj86oAey0I+2jrcR6trjoE8cVjr5l
         kOYax9At4eHqlb7ROz/MCcen/wXoYXLg8inknlh621ki+9O2XnKLpYv5NSBTFkfakGLQ
         x+kr6BQzIvrckUjzeXl+6RIQ6qlDiuH8YPDClCrOJGbElaLd7Z44IaevGwE6rvO5V9UY
         Nu3hZvZtZMWElt1tBvhLTWxg5X8jWIXOkAeHlmYtur8GuZZl1VuRTdmq9s5skY4MRrHJ
         00bA==
X-Gm-Message-State: ABy/qLY56iLdWNm2I+4VULkejmLjim66ppNYXvJ6j128xVP+OyxruNx1
        dFCS9A4189qGZjHAIZg28PMS1+JfCspcteN5WCUI1g==
X-Google-Smtp-Source: APBJJlFDNStRVntz5xj4Xa4JTqZiTy+AaBHEo0rm7uRFHh4lkjF0UMITtgmDeuBkvXN/CF7GczyhWg==
X-Received: by 2002:a0d:d855:0:b0:56c:f547:e058 with SMTP id a82-20020a0dd855000000b0056cf547e058mr13155252ywe.18.1689023543839;
        Mon, 10 Jul 2023 14:12:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b126-20020a0dc084000000b0056d443372f0sm181692ywd.119.2023.07.10.14.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:23 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 07/16] refs: plumb `exclude_patterns` argument throughout
Message-ID: <81e223de0c82dfc213ea7d7041e66c9505c1599d.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subsequent patch will want to access an optional `excluded_patterns`
array within `refs/packed-backend.c` that will cull out certain
references matching any of the given patterns on a best-effort basis.

To do so, the refs subsystem needs to be updated to pass this value
across a number of different locations.

Prepare for a future patch by introducing this plumbing now, passing
NULLs at top-level APIs in order to make that patch less noisy and more
easily readable.

Signed-off-by: Taylor Blau <me@ttaylorr.co>
---
 ls-refs.c             |  2 +-
 ref-filter.c          |  2 +-
 refs.c                | 32 +++++++++++++++++++-------------
 refs.h                |  8 +++++++-
 refs/debug.c          |  5 +++--
 refs/files-backend.c  |  5 +++--
 refs/packed-backend.c |  5 +++--
 refs/refs-internal.h  |  7 ++++---
 revision.c            |  2 +-
 9 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index a29c2364a59..65d1fa9029e 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -194,7 +194,7 @@ int ls_refs(struct repository *r, struct packet_reader *request)
 		strvec_push(&data.prefixes, "");
 	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
 					  get_git_namespace(), data.prefixes.v,
-					  send_ref, &data);
+					  NULL, send_ref, &data);
 	packet_fflush(stdout);
 	strvec_clear(&data.prefixes);
 	strbuf_release(&data.buf);
diff --git a/ref-filter.c b/ref-filter.c
index 845173a904a..925d77b7b79 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2215,7 +2215,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 
 	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
 						 NULL, filter->name_patterns,
-						 cb, cb_data);
+						 NULL, cb, cb_data);
 }
 
 /*
diff --git a/refs.c b/refs.c
index 876df4931f6..7e5cd84bf28 100644
--- a/refs.c
+++ b/refs.c
@@ -1528,7 +1528,9 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim,
+		const char *prefix,
+		const char **exclude_patterns,
+		int trim,
 		enum do_for_each_ref_flags flags)
 {
 	struct ref_iterator *iter;
@@ -1544,8 +1546,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 		}
 	}
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
-
+	iter = refs->be->iterator_begin(refs, prefix, exclude_patterns, flags);
 	/*
 	 * `iterator_begin()` already takes care of prefix, but we
 	 * might need to do some trimming:
@@ -1579,7 +1580,7 @@ static int do_for_each_repo_ref(struct repository *r, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, NULL, trim, flags);
 
 	return do_for_each_repo_ref_iterator(r, iter, fn, cb_data);
 }
@@ -1601,6 +1602,7 @@ static int do_for_each_ref_helper(struct repository *r,
 }
 
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
+			   const char **exclude_patterns,
 			   each_ref_fn fn, int trim,
 			   enum do_for_each_ref_flags flags, void *cb_data)
 {
@@ -1610,7 +1612,8 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns, trim,
+				       flags);
 
 	return do_for_each_repo_ref_iterator(the_repository, iter,
 					do_for_each_ref_helper, &hp);
@@ -1618,7 +1621,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "", NULL, fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1629,7 +1632,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(refs, prefix, NULL, fn, strlen(prefix), 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -1640,13 +1643,14 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, fn, 0, 0, cb_data);
+			       prefix, NULL, fn, 0, 0, cb_data);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
+			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_data);
 }
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
@@ -1663,14 +1667,14 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
 	ret = do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, fn, 0, 0, cb_data);
+			      buf.buf, NULL, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
+	return do_for_each_ref(refs, "", NULL, fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -1740,6 +1744,7 @@ static void find_longest_prefixes(struct string_list *out,
 int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 				      const char *namespace,
 				      const char **patterns,
+				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
@@ -1755,7 +1760,8 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 
 	for_each_string_list_item(prefix, &prefixes) {
 		strbuf_addstr(&buf, prefix->string);
-		ret = refs_for_each_fullref_in(ref_store, buf.buf, fn, cb_data);
+		ret = refs_for_each_fullref_in(ref_store, buf.buf,
+					       exclude_patterns, fn, cb_data);
 		if (ret)
 			break;
 		strbuf_setlen(&buf, namespace_len);
@@ -2410,7 +2416,7 @@ int refs_verify_refname_available(struct ref_store *refs,
 	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
 
-	iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
+	iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
 				       DO_FOR_EACH_INCLUDE_BROKEN);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 		if (skip &&
diff --git a/refs.h b/refs.h
index 933fdebe584..3c03b035a3f 100644
--- a/refs.h
+++ b/refs.h
@@ -344,6 +344,7 @@ int for_each_ref(each_ref_fn fn, void *cb_data);
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
+			     const char **exclude_patterns,
 			     each_ref_fn fn, void *cb_data);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
 
@@ -351,10 +352,15 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data);
  * iterate all refs in "patterns" by partitioning patterns into disjoint sets
  * and iterating the longest-common prefix of each set.
  *
+ * references matching any pattern in "exclude_patterns" are omitted from the
+ * result set on a best-effort basis.
+ *
  * callers should be prepared to ignore references that they did not ask for.
  */
 int refs_for_each_fullref_in_prefixes(struct ref_store *refs,
-				      const char *namespace, const char **patterns,
+				      const char *namespace,
+				      const char **patterns,
+				      const char **exclude_patterns,
 				      each_ref_fn fn, void *cb_data);
 
 /**
diff --git a/refs/debug.c b/refs/debug.c
index c0fa707a1da..b7ffc4ce67e 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -229,11 +229,12 @@ static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 
 static struct ref_iterator *
 debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
-			 unsigned int flags)
+			 const char **exclude_patterns, unsigned int flags)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
 	struct ref_iterator *res =
-		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
+		drefs->refs->be->iterator_begin(drefs->refs, prefix,
+						exclude_patterns, flags);
 	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
 	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
 	diter->iter = res;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 09b4954f21c..341354182bb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -832,7 +832,8 @@ static struct ref_iterator_vtable files_ref_iterator_vtable = {
 
 static struct ref_iterator *files_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, const char **exclude_patterns,
+		unsigned int flags)
 {
 	struct files_ref_store *refs;
 	struct ref_iterator *loose_iter, *packed_iter, *overlay_iter;
@@ -877,7 +878,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * the packed and loose references.
 	 */
 	packed_iter = refs_ref_iterator_begin(
-			refs->packed_ref_store, prefix, 0,
+			refs->packed_ref_store, prefix, exclude_patterns, 0,
 			DO_FOR_EACH_INCLUDE_BROKEN);
 
 	overlay_iter = overlay_ref_iterator_begin(loose_iter, packed_iter);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 27bd6339ff3..dec15dee31e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -925,7 +925,8 @@ static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 
 static struct ref_iterator *packed_ref_iterator_begin(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags)
+		const char *prefix, const char **exclude_patterns,
+		unsigned int flags)
 {
 	struct packed_ref_store *refs;
 	struct snapshot *snapshot;
@@ -1150,7 +1151,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	 * list of refs is exhausted, set iter to NULL. When the list
 	 * of updates is exhausted, leave i set to updates->nr.
 	 */
-	iter = packed_ref_iterator_begin(&refs->base, "",
+	iter = packed_ref_iterator_begin(&refs->base, "", NULL,
 					 DO_FOR_EACH_INCLUDE_BROKEN);
 	if ((ok = ref_iterator_advance(iter)) != ITER_OK)
 		iter = NULL;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f72b7be8941..9db8aec4da8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -367,8 +367,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
  */
 struct ref_iterator *refs_ref_iterator_begin(
 		struct ref_store *refs,
-		const char *prefix, int trim,
-		enum do_for_each_ref_flags flags);
+		const char *prefix, const char **exclude_patterns,
+		int trim, enum do_for_each_ref_flags flags);
 
 /*
  * A callback function used to instruct merge_ref_iterator how to
@@ -571,7 +571,8 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
  */
 typedef struct ref_iterator *ref_iterator_begin_fn(
 		struct ref_store *ref_store,
-		const char *prefix, unsigned int flags);
+		const char *prefix, const char **exclude_patterns,
+		unsigned int flags);
 
 /* reflog functions */
 
diff --git a/revision.c b/revision.c
index d66857ecc09..af11d599d35 100644
--- a/revision.c
+++ b/revision.c
@@ -2642,7 +2642,7 @@ static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
 	struct strbuf bisect_refs = STRBUF_INIT;
 	int status;
 	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
-	status = refs_for_each_fullref_in(refs, bisect_refs.buf, fn, cb_data);
+	status = refs_for_each_fullref_in(refs, bisect_refs.buf, NULL, fn, cb_data);
 	strbuf_release(&bisect_refs);
 	return status;
 }
-- 
2.41.0.343.gdff068c469f


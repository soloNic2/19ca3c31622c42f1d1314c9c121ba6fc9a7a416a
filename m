Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D0C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJLJCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJLJCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:02:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2967BA265
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f11so25267501wrm.6
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE+yDSHdlLiw5xxz02Ukmxj5wLkJrY5lWnCU5JMCWOU=;
        b=CjNKm8wvRwrSEsxDTxH/uYuoNpLC7l8TihUlNyh9QD5XIZxogtvZaOZ7Q8uFLEIEOc
         43/dorX81X5j34J0zWZJsm7F4eAOksjOpGrGvDMmMLygJEDf2vA2UvmUGyEYZZ13w9nP
         cncyu5IKQZHsCxYOkxTsIjhYKrmFnf9BxwQfUtvwu8GsdcjkRIWKvhzsYdk7IZSM/yfx
         GJ1y5LEgBKwmqimOucbBdufPxCJgI5AxQTjB1fq6cPIpGzuerzsDu0SyguPQSDuplL8A
         aVzJcLTE7Z6zgbhbAZCcvpi31NSGxS9zcPZWnbzarPCubeW0VxBxzupkjGTKdgPZoz70
         8/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE+yDSHdlLiw5xxz02Ukmxj5wLkJrY5lWnCU5JMCWOU=;
        b=WSC1mJeobbi4Iq+U9be5d24aCscjouv6jBqBHgeoItVQfkxOOst4dTULHy3eNtL7zi
         wEzuAlTuu+FQEa3O1EINK9ghAd6W+IdFEt2ZMXVTKo/Dvje+bQIZYxtbdnAbcEuCl9/y
         EximcNZL4z8lWqBE1LKp0Cz6GwQL9y/I7aC6ZlRapbkrV8hQvVWhJ6NITFH+JUgq8PH3
         vfvJgTVBgr4YAzoW3xh8RJUgwTt2BN9Vgh+O9ojfemGRmVMGb3fu7HH8MGc/+mdM7O4+
         DAUx6GupX2o45Z+Zb8Xw7UAGWZW1JevORyFSWNRtrKGEIfK62VXs/HpEZVpO72BljNdJ
         lkAw==
X-Gm-Message-State: ACrzQf1lOxSVbsYW4r+BRsESs+mbC1WE12v2uDWE3w01tixIjbQomeev
        AeDrd6niLQONq4OUCU6UVJgN/w4OdxXWSg==
X-Google-Smtp-Source: AMsMyM5M2kDZlBbQLJ4xvDVhcS+Fc0rNuq7lgLyv1XhD1kMbSwNnPK9K60LTm6eIJPtDlUQMB2dv+Q==
X-Received: by 2002:a5d:526d:0:b0:22e:4f4d:2546 with SMTP id l13-20020a5d526d000000b0022e4f4d2546mr17656919wrc.464.1665565310685;
        Wed, 12 Oct 2022 02:01:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a3170a7af9sm1280362wmq.4.2022.10.12.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:01:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/22] run-command.c: use designated init for pp_init(), add "const"
Date:   Wed, 12 Oct 2022 11:01:19 +0200
Message-Id: <patch-v2-11.22-aedda10d8e1-20221012T084850Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220930T111343Z-avarab@gmail.com> <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a designated initializer to initialize those parts of pp_init()
that don't need any conditionals for their initialization, this sets
us on a path to pp_init() itself into mostly a validation and
allocation function.

Since we're doing that we can add "const" to some of the members of
the "struct parallel_processes", which helps to clarify and
self-document this code. E.g. we never alter the "data" pointer we
pass t user callbacks, nor (after the preceding change to stop
invoking online_cpus()) do we change "max_processes", the same goes
for the "ungroup" option.

We can also do away with a call to strbuf_init() in favor of macro
initialization, and to rely on other fields being NULL'd or zero'd.

Making members of a struct "const" rather that the pointer to the
struct itself is usually painful, as e.g. it precludes us from
incrementally setting up the structure. In this case we only set it up
with the assignment in run_process_parallel() and pp_init(), and don't
pass the struct pointer around as "const", so making individual
members "const" is worth the potential hassle for extra safety.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/run-command.c b/run-command.c
index 21c00a48823..6acfd29d8c1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1496,9 +1496,9 @@ enum child_state {
 
 int run_processes_parallel_ungroup;
 struct parallel_processes {
-	void *data;
+	void *const data;
 
-	size_t max_processes;
+	const size_t max_processes;
 	size_t nr_processes;
 
 	get_next_task_fn get_next_task;
@@ -1518,7 +1518,7 @@ struct parallel_processes {
 	struct pollfd *pfd;
 
 	unsigned shutdown : 1;
-	unsigned ungroup : 1;
+	const unsigned ungroup : 1;
 
 	size_t output_owner;
 	struct strbuf buffered_output; /* of finished children */
@@ -1556,21 +1556,18 @@ static void handle_children_on_signal(int signo)
 }
 
 static void pp_init(struct parallel_processes *pp,
-		    size_t n,
 		    get_next_task_fn get_next_task,
 		    start_failure_fn start_failure,
-		    task_finished_fn task_finished,
-		    void *data, int ungroup)
+		    task_finished_fn task_finished)
 {
+	const size_t n = pp->max_processes;
+
 	if (!n)
 		BUG("you must provide a non-zero number of processes!");
 
-	pp->max_processes = n;
-
 	trace_printf("run_processes_parallel: preparing to run up to %"PRIuMAX" tasks",
 		     (uintmax_t)n);
 
-	pp->data = data;
 	if (!get_next_task)
 		BUG("you need to specify a get_next_task function");
 	pp->get_next_task = get_next_task;
@@ -1578,16 +1575,9 @@ static void pp_init(struct parallel_processes *pp,
 	pp->start_failure = start_failure ? start_failure : default_start_failure;
 	pp->task_finished = task_finished ? task_finished : default_task_finished;
 
-	pp->nr_processes = 0;
-	pp->output_owner = 0;
-	pp->shutdown = 0;
-	pp->ungroup = ungroup;
 	CALLOC_ARRAY(pp->children, n);
-	if (pp->ungroup)
-		pp->pfd = NULL;
-	else
+	if (!pp->ungroup)
 		CALLOC_ARRAY(pp->pfd, n);
-	strbuf_init(&pp->buffered_output, 0);
 
 	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
@@ -1785,13 +1775,17 @@ void run_processes_parallel(size_t n,
 	int output_timeout = 100;
 	int spawn_cap = 4;
 	int ungroup = run_processes_parallel_ungroup;
-	struct parallel_processes pp;
+	struct parallel_processes pp = {
+		.max_processes = n,
+		.data = pp_cb,
+		.buffered_output = STRBUF_INIT,
+		.ungroup = ungroup,
+	};
 
 	/* unset for the next API user */
 	run_processes_parallel_ungroup = 0;
 
-	pp_init(&pp, n, get_next_task, start_failure, task_finished, pp_cb,
-		ungroup);
+	pp_init(&pp, get_next_task, start_failure, task_finished);
 	while (1) {
 		for (int i = 0;
 		    i < spawn_cap && !pp.shutdown &&
-- 
2.38.0.971.ge79ff6d20e7

